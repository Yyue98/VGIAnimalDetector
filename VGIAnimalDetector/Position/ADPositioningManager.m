//
//  ADPositioningManager.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADPositioningManager.h"
#import <CoreMotion/CoreMotion.h>
#import <MapKit/MapKit.h>
#import <GLKit/GLKit.h>
#import "ADGeometry.h"
//#import "ADMapboxController.h"
#import "NSPointerArray+Helper.h"
#import "ADSensorMonitorManager.h"
#import "ADMercatorProjector.h"
#import "ADPositioningSource.h"
#import "ADAltitudeMonitor.h"

/// Degrade timer interval
#define DEGRADE_INTERVAL    30

/// Length for each step in meters
#define STRIDE_LENGTH   0.4


@interface ADPositioningManager () <ADSensorMonitorManagerDelegate, ADAltitudeMonitorDelegate>
@property (nonatomic, strong)   NSPointerArray  *observers;
@property (nonatomic, strong)   ADMercatorProjector *projector;
@property (nonatomic, strong)   ADAltitudeMonitor   *altitudeMonitor;
@property (nonatomic, assign)   BOOL    shouldRestoreLevelCode;
@property (nonatomic, copy) ADPositioningSource *source;
@property (nonatomic, assign)   BOOL    backgroundUpdates;
@property (nonatomic, copy) CLLocation  *location;
@property (nonatomic, copy) CLHeading   *heading;
@property (nonatomic, assign)   ADPositioningSourceAccuracy updateAccuracy;
@property (nonatomic, copy) ADLocation  *userLocation;
@property (nonatomic, strong)   NSTimer *sourceAccuracyTimer;
@property (nonatomic, copy) NSString    *levelCode;
@end

@implementation ADPositioningManager

+ (instancetype)sharedManager {
    static ADPositioningManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ADPositioningManager new];
    });
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _observers = [NSPointerArray weakObjectsPointerArray];
    _projector = [[ADMercatorProjector alloc] initWithTileSize:256];
    _altitudeMonitor = [ADAltitudeMonitor new];
    _altitudeMonitor.delegate = self;
    _updateAccuracy = ADPositioningSourceAccuracyLow;
//    _queue = dispatch_queue_create("com.mrcrow.aicity.positioning.queue", DISPATCH_QUEUE_SERIAL);
    [self registerApplicationStatusNotifications];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

/// Start receiving appliction status notification
- (void)registerApplicationStatusNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

/// Invoked when application did enter background
/// @param sender Application itself
- (void)applicationDidEnterBackground:(id)sender {
    [self locationUpdateEnterBackground];
}

/// Invoked when application did became active
/// @param sender Application itself
- (void)applicationDidBecomeActive:(id)sender {
    [self locationUpdateEnterForeground];
}

- (void)addNotifyObserver:(id<ADPositioningManagerDelegate>)observer {
    @synchronized (self) {
        if ([_observers containsObject:observer])   return;
        [_observers addPointer:(__bridge void *)observer];
        [_observers compact];
    }
}

- (void)removeNotifyObserver:(id<ADPositioningManagerDelegate>)observer {
    @synchronized (self) {
        if (![_observers containsObject:observer])  return;
        [_observers removeObject:observer];
        [_observers quickCompact];
    }
}

- (void)setSource:(ADPositioningSource *)source {
    _source = source;
    if (!source) return;
    
    _updateAccuracy = source.accuracy;
    if (source.type == ADPositioningSourceTypeLocation) {
        ADLocation *location = [[ADLocation alloc] initWithCoordinate:source.coordinate
                                                              heading:_heading.trueHeading
                                                           sourceType:ADPositioningSourceTypeLocation
                                                             accuracy:source.accuracy
                                                            levelCode:source.levelCode
                                                            timestamp:[NSDate date]];
        location.altitude = source.altitude;
        _userLocation = location;
        [self notifyObserversWithLocation:location];
    }
}

/// Emuration all obervers and pass in the input locations to each for notify
/// @param location ADLocation object for notify
- (void)notifyObserversWithLocation:(ADLocation *)location {
    ADLocation *copy = location.copy;
    NSPointerArray *observers = _observers.copy;
    for (id <ADPositioningManagerDelegate> observer in observers) {
        if ([observer respondsToSelector:@selector(positioningManager:didUpdateLocation:)]) {
            [observer positioningManager:self didUpdateLocation:copy];
        }
    }
}

/// Degrade timer is used to degrade acceptable source accuracy for positioning usage.
/// Since the initial accuracy is ADPositioningSourceAccuracyLow, all accuracy source update are all available for update location, but we want more accuracy update but not lower one.
/// But after for specific time period, when there is no same or higher accuracy source available, the degrade timer will be fired and degrade the acceptable accuracy for continue positioning
- (void)scheduleSourceAccuracyDegradeTimer {
    [self invalidateSourceAccuracyDegradeTimer];
    
    __weak typeof(self) _self = self;
    _sourceAccuracyTimer = [NSTimer scheduledTimerWithTimeInterval:DEGRADE_INTERVAL repeats:NO block:^(NSTimer * _Nonnull timer) {
        __strong typeof(_self) self = _self;
        if (!self) return;
        if (self.updateAccuracy <= ADPositioningSourceAccuracyLow) return;
        self.updateAccuracy -= 1;
        [self invalidateSourceAccuracyDegradeTimer];
    }];
}

/// Invalidate timer for stop accuracy degrade
- (void)invalidateSourceAccuracyDegradeTimer {
    if (!_sourceAccuracyTimer) return;
    [_sourceAccuracyTimer invalidate];
    _sourceAccuracyTimer = nil;
}

/// Check if GPS location is available for user position update
/// @param location CLLocation object
- (BOOL)sourceUpdateAvailabilityForLocation:(CLLocation *)location {
    if (!_source) return YES;
    
    ADPositioningSourceAccuracy accuracy = [self sourceAccuracyForLocation:location];
    if (_backgroundUpdates ) {
        return accuracy >= ADPositioningSourceAccuracyMedium;
    } else {
        if ( _updateAccuracy == ADPositioningSourceAccuracyConfidence) return NO;
        return accuracy >= _updateAccuracy;
    }
}

/// Update source with location update
/// @param location CLLocation object
- (void)updateSourceWithLocation:(CLLocation *)location {
    NSString *levelCode = _levelCode;
    
    if (![levelCode length]) {
        levelCode = @"100";
    } else if (_shouldRestoreLevelCode) {
        _shouldRestoreLevelCode = NO;
        levelCode = @"100";
    } else if (![_levelCode isEqualToString:@"100"] && !_altitudeMonitor.isMonitoring) {
        [_altitudeMonitor starAltitudeMonitoring];
    }
    
    ADPositioningSourceAccuracy accuracy = [self sourceAccuracyForLocation:location];
    ADPositioningSource *source = [[ADPositioningSource alloc] initWithCoordinate:location.coordinate sourceType:ADPositioningSourceTypeLocation accuracy:accuracy levelCode:levelCode];
    source.altitude = location.altitude;
    self.source = source;
}

/// Determine location accuracy for location
/// @param location CLLocation object
- (ADPositioningSourceAccuracy)sourceAccuracyForLocation:(CLLocation *)location {
    CLLocationAccuracy accuracy = location.horizontalAccuracy;
    if (accuracy < 0)   return ADPositioningSourceAccuracyInvalid;
    if (accuracy <= 10) return ADPositioningSourceAccuracyHigh;
    if (accuracy <= 30) return ADPositioningSourceAccuracyMedium;
    return ADPositioningSourceAccuracyLow;
}

/// Update accuracy when location update enter background
- (void)locationUpdateEnterBackground {
    _backgroundUpdates = YES;
    if (_updateAccuracy == ADPositioningSourceAccuracyConfidence) {
        _updateAccuracy = ADPositioningSourceAccuracyHigh;
    }
    
    [self invalidateSourceAccuracyDegradeTimer];
}

/// Location updates enter foreground
- (void)locationUpdateEnterForeground {
    _backgroundUpdates = NO;
    [self scheduleSourceAccuracyDegradeTimer];
}

/// Determine angle from one to another is acute angle
/// @param heading From user heading
/// @param direction To route direction
- (BOOL)isAcuteAngleFromHeading:(CLHeading *)heading toRouteDirection:(CLLocationDegrees)direction {
    CLLocationDegrees deviation = heading.headingAccuracy / 2.0;
    CLLocationDegrees headingFrom = heading.trueHeading - deviation;
    CLLocationDegrees headingTo = heading.trueHeading + deviation;
    float fromLength = [self lengthForVectorFrom:headingFrom to:direction];
    float toLength = [self lengthForVectorFrom:headingTo to:direction];
    BOOL isAcute = fromLength <= sqrt(2) || toLength <= sqrt(2);
    return isAcute;
}

- (float)lengthForVectorFrom:(CLLocationDegrees)from to:(CLLocationDegrees)to {
    GLKVector2 fromVector = GLKVector2Make(sin(ACDegreeToRadians(from)), cos(ACDegreeToRadians(from)));
    GLKVector2 toVector = GLKVector2Make(sin(ACDegreeToRadians(to)), cos(ACDegreeToRadians(to)));
    GLKVector2 vector = GLKVector2Subtract(fromVector, toVector);
    return GLKVector2Length(vector);
}

/// Calculate negtive angle for angle
/// @param angle Target angle
- (CLLocationDegrees)negativeAngleFor:(CLLocationDegrees)angle {
    CGFloat negative = angle + 180;
    if (negative > 360) {
        negative -= 360;
    }
    
    return negative;
}

- (ADLocation *)locationForMapMatching:(BOOL)matching {
    return  _userLocation.copy;
}

- (BOOL)isInsideLift {
    return [_userLocation.levelCode isEqualToString:@"000"];
}

/// Boolean value indicates whether should avoid dead reckoing calculation
- (BOOL)avoidDeadReckoningProcessing {
    return !_userLocation || _updateAccuracy < ADPositioningSourceAccuracyMedium || [self isInsideLift];
}

/// Procecess dead reckoning to input ADLocation object with length to generate new location
/// @param location ADLocation object to process
/// @param distance Stride distance
- (ADLocation *)calculateNextLocationWithLocation:(ADLocation *)location withLength:(CLLocationDistance)distance {
    CGPoint meters = [_projector coordinateToMeters:location.coordinate];

    CGFloat length = STRIDE_LENGTH;
    double angle = ACDegreeToRadians(_heading.trueHeading);

    CLLocationDistance x = meters.x + length * sin(angle);
    CLLocationDistance y = meters.y + length * cos(angle);
    CGPoint next = CGPointMake(x, y);
    CLLocationCoordinate2D coordinate = [_projector metersToCoordinate:next];

    
    ADLocation *nextLocation = [[ADLocation alloc] initWithCoordinate:coordinate
                                                              heading:_heading.trueHeading
                                                           sourceType:location.sourceType
                                                             accuracy:location.accuracy
                                                            levelCode:location.levelCode
                                                            timestamp:[NSDate date]];
    return nextLocation;
}

#pragma mark - ACSensorMonitorManagerDelegate
- (void)updateHeading:(CLHeading *)heading {
    if (heading.headingAccuracy < 0) return;
    _heading = heading;
}

- (CLHeading *)getCurrentHeading {
    return _heading.copy;
}

- (void)updateLocation:(CLLocation *)location {
    _location = location;
    if (![self sourceUpdateAvailabilityForLocation:location]) return;
    [self updateSourceWithLocation:location];
    [self scheduleSourceAccuracyDegradeTimer];
}

#pragma mark - ACAltitudeMonitorDelegate
- (void)altitudeMonitor:(ADAltitudeMonitor *)monitor didDetectSignificantAltitudeChange:(double)value {
    self.shouldRestoreLevelCode = YES;
    [monitor stopAltitudeMonitoring];
}

@end

//
//  ADMGLLocationProvider.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADMGLLocationProvider.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <YYKit/YYThreadSafeDictionary.h>
#import "ADPositioningManager.h"
#import "NSPointerArray+Helper.h"

static NSInteger tileZoomLevel = 19;

@interface ADMGLLocationProvider () <ADSensorMonitorManagerDelegate, ADPositioningManagerDelegate, CLLocationManagerDelegate>
@property (nonatomic, weak) id <MGLLocationManagerDelegate> locationDelegate;
@property (nonatomic, assign)   BOOL    updatingLocationInBackground;
@property (nonatomic, assign)   BOOL    backgroundUpdating;
@property (nonatomic, strong)   NSPointerArray  *observers;
@property (nonatomic, strong)   YYThreadSafeDictionary  *rangingBeaconLayer;
@property (nonatomic, copy) ADTileCollection    *currentTileCollection;
@property (nonatomic, copy) ADLocation  *location;
@property (nonatomic, strong)   CLLocationManager   *backgroundUpdator;
@end

@implementation ADMGLLocationProvider

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self);
        _sensorManager = [[ADSensorMonitorManager alloc] initWithDelegate:self tileZoom:tileZoomLevel   rangeConvertor:^ADLocationManagerMonitoringRange(CLLocation *location) {
            @strongify(self);
            return [self monitoringRangeWithLocation:location];
        }];
          
        _sensorManager.locationManager.core.headingFilter = 1;
        _sensorManager.locationManager.core.distanceFilter = 2;
        _sensorManager.locationManager.core.desiredAccuracy = kCLLocationAccuracyBest;
        _sensorManager.locationManager.core.allowsBackgroundLocationUpdates = YES;
        _sensorManager.locationManager.core.pausesLocationUpdatesAutomatically = NO;
        [[ADPositioningManager sharedManager] addNotifyObserver:self];
        
        _observers = [NSPointerArray weakObjectsPointerArray];
        _rangingBeaconLayer = [YYThreadSafeDictionary new];
    }
    
    return self;
}

- (void)dealloc {
    [[ADPositioningManager sharedManager] removeNotifyObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)registerApplicationStatusNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)applicationDidEnterBackground:(id)sender {
    if (_updatingLocationInBackground) {
        _backgroundUpdating = YES;
    }
}

- (void)applicationDidBecomeADTive:(id)sender {
    _backgroundUpdating = NO;
}

#pragma mark - Configuring Location Update Precision
- (CLLocationDistance)distanceFilter {
    return _sensorManager.distanceFilter;
}

- (void)setDistanceFilter:(CLLocationDistance)distanceFilter {
    _sensorManager.distanceFilter = distanceFilter;
}

- (CLLocationAccuracy)desiredAccuracy {
    return _sensorManager.desiredAccuracy;
}

- (void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy {
    _sensorManager.desiredAccuracy = desiredAccuracy;
}

- (void)setDelegate:(id<MGLLocationManagerDelegate>)delegate {
    _locationDelegate = delegate;
}

- (id <MGLLocationManagerDelegate>)delegate {
    return _locationDelegate;
}

#pragma mark - Requesting Authorization for Location Services
- (CLAuthorizationStatus)authorizationStatus {
    return [CLLocationManager authorizationStatus];
}

- (void)requestAlwaysAuthorization {
    [_sensorManager requestAlwaysAuthorization];
}

- (void)requestWhenInUseAuthorization {
    [_sensorManager requestWhenInUseAuthorization];
}

#pragma mark - Initiating Location Updates
- (void)startUpdatingLocation {
    [_sensorManager startUpdatingLocation];
    
    if (_backgroundUpdator) {
        [_backgroundUpdator stopUpdatingLocation];
        _backgroundUpdator.delegate = nil;
        _backgroundUpdator = nil;
    }
}

- (void)stopUpdatingLocation {
    [_sensorManager stopUpdatingLocation];
    
    if (_updatingLocationInBackground) {
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (state == UIApplicationStateBackground || state == UIApplicationStateInactive) {
            // This is called by MGLLocationManager as MGLMapView's locationManager when enter background, MGLMapView will call stopUpdatingLocation for its locationManage,
            // To achive background updates, we will create a new locationManager and startLocationUpdates to do this
            
            CLLocationManager *locationManager = [CLLocationManager new];
            locationManager.delegate = self;
            locationManager.allowsBackgroundLocationUpdates = YES;
            locationManager.pausesLocationUpdatesAutomatically = NO;
            [locationManager requestAlwaysAuthorization];
            [locationManager startUpdatingLocation];

            _backgroundUpdator = locationManager;
        }
    }
}

- (void)setLocation:(ADLocation *)location {
    NSArray *updates;
    if (_location) {
        updates = @[[self locationFromUpdatedLocation:_location],
                      [self locationFromUpdatedLocation:location]];
    } else {
        updates = @[[self locationFromUpdatedLocation:location]];
    }
    
    _location = location;
    if (self.locationDelegate && [self.locationDelegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
        [self.locationDelegate locationManager:self didUpdateLocations:updates];
    }
}

#pragma mark - Initiating Heading Updates
- (void)setHeadingOrientation:(CLDeviceOrientation)headingOrientation {
    _sensorManager.headingOrientation = headingOrientation;
}

- (CLDeviceOrientation)headingOrientation {
    return _sensorManager.headingOrientation;
}

- (void)startUpdatingHeading {
    [_sensorManager startUpdatingHeading];
}

- (void)stopUpdatingHeading {
    [_sensorManager stopUpdatingLocation];
}

- (void)dismissHeadingCalibrationDisplay {
    [_sensorManager dismissHeadingCalibrationDisplay];
}

- (void)addNotifyObserver:(id<ADSensorMonitorManagerDelegate>)observer {
    @synchronized (self) {
        if ([_observers containsObject:observer]) return;
        [_observers addPointer:(__bridge void *)observer];
        [_observers compact];
    }
}

- (void)removeNotifyObserver:(id<ADSensorMonitorManagerDelegate>)observer {
    @synchronized (self) {
        if (![_observers containsObject:observer]) return;
        [_observers removeObject:observer];
        [_observers quickCompact];
    }
}

- (void)switchUpdatingLocationInBackground:(BOOL)enable {
    _updatingLocationInBackground = enable;
    
    if (enable) {
        [self requestAlwaysAuthorization];
    } else {
        [self requestWhenInUseAuthorization];
    }
    
    [self startUpdatingLocation];
}

- (ADLocationManagerMonitoringRange)monitoringRangeWithLocation:(CLLocation *)location {
    CLLocationCoordinate2D coordinate = location.coordinate;
    if (location.horizontalAccuracy < 0) return ADLocationManagerMonitoringMakeRange(coordinate, 7);
    
    NSInteger length = round(location.horizontalAccuracy / 60.0);
    NSInteger dimension = MAX(length * 2 + 1, 3);
    return ADLocationManagerMonitoringMakeRange(coordinate, dimension);
}

- (CLLocationAccuracy)horizontalAccuracyForSourceType:(ADPositioningSourceAccuracy)accuracy {
    switch (accuracy) {
        case ADPositioningSourceAccuracyInvalid:
        case ADPositioningSourceAccuracyLow:        return 60;
        case ADPositioningSourceAccuracyMedium:     return 30;
        case ADPositioningSourceAccuracyHigh:       return 10;
        case ADPositioningSourceAccuracyConfidence:
        default:                                    return 8;
    }
}

- (CLLocation *)locationFromUpdatedLocation:(ADLocation *)location {
    return [[CLLocation alloc] initWithCoordinate:location.coordinate
                                         altitude:location.altitude
                               horizontalAccuracy:[self horizontalAccuracyForSourceType:location.accuracy]
                                 verticalAccuracy:15
                                        timestamp:location.timestamp];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    [self monitorManager:_sensorManager didUpdateLocations:locations];
}

#pragma mark - ADSensorMonitorManagerDelegate
- (void)monitorManager:(ADSensorMonitorManager *)manager didFailWithError:(NSError *)error {
    if (self.locationDelegate && [self.locationDelegate respondsToSelector:@selector(locationManager:didFailWithError:)]) {
        [self.locationDelegate locationManager:self didFailWithError:error];
    }
}

- (void)monitorManager:(ADSensorMonitorManager *)manager didUpdateSensorState:(ADSensorMonitorManagerState)state {
    NSPointerArray *observers = self.observers.copy;
    for (id <ADSensorMonitorManagerDelegate> observer in observers) {
        if (![observer respondsToSelector:_cmd]) continue;
        [observer monitorManager:manager didUpdateSensorState:state];
    }
}

- (void)monitorManager:(ADSensorMonitorManager *)manager didUpdateLocations:(NSArray <CLLocation *>*)locations {
    [[ADPositioningManager sharedManager] updateLocation:locations.lastObject];
    
    NSPointerArray *observers = self.observers.copy;
    for (id <ADSensorMonitorManagerDelegate> observer in observers) {
        if (![observer respondsToSelector:_cmd]) continue;
        [observer monitorManager:manager didUpdateLocations:locations];
    }
}

- (BOOL)monitorManagerShouldDisplayHeadingCalibration:(ADSensorMonitorManager *)manager {
    if (self.locationDelegate && [self.locationDelegate respondsToSelector:@selector(locationManagerShouldDisplayHeadingCalibration:)]) {
        return [self.locationDelegate locationManagerShouldDisplayHeadingCalibration:self];
    }
    
    return YES;
}

- (void)monitorManager:(ADSensorMonitorManager *)manager didUpdateHeading:(CLHeading *)heading {
    [[ADPositioningManager sharedManager] updateHeading:heading];
    
    if (self.locationDelegate && [self.locationDelegate respondsToSelector:@selector(locationManager:didUpdateHeading:)]) {
        [self.locationDelegate locationManager:self didUpdateHeading:heading];
    }
    
    NSPointerArray *observers = self.observers.copy;
    for (id <ADSensorMonitorManagerDelegate> observer in observers) {
        if (![observer respondsToSelector:_cmd]) continue;
        [observer monitorManager:manager didUpdateHeading:heading];
    }
}

- (void)monitorManager:(ADSensorMonitorManager *)manager didChangedMonitoringRange:(ADLocationManagerMonitoringRange)range {
    NSPointerArray *observers = self.observers.copy;
    for (id <ADSensorMonitorManagerDelegate> observer in observers) {
        if (![observer respondsToSelector:_cmd]) continue;
        [observer monitorManager:manager didChangedMonitoringRange:range];
    }
}

- (void)monitorManager:(ADSensorMonitorManager *)manager didStartMonitoringTilesWithTileCodes:(NSArray<NSString *> *)tileCodes {
    NSPointerArray *observers = self.observers.copy;
    for (id <ADSensorMonitorManagerDelegate> observer in observers) {
        if (![observer respondsToSelector:_cmd]) continue;
        [observer monitorManager:manager didStartMonitoringTilesWithTileCodes:tileCodes];
    }
}

- (void)monitorManager:(ADSensorMonitorManager *)manager didStopMonitoringTilesWithTileCodes:(NSArray<NSString *> *)tileCodes {
    NSPointerArray *observers = self.observers.copy;
    for (id <ADSensorMonitorManagerDelegate> observer in observers) {
        if (![observer respondsToSelector:_cmd]) continue;
        [observer monitorManager:manager didStopMonitoringTilesWithTileCodes:tileCodes];
    }
}

- (void)monitorManager:(ADSensorMonitorManager *)manager didChangeMonitoringTilesCollectionFrom:(ADTileCollection *)from to:(ADTileCollection *)to {
    self.currentTileCollection = to;
    NSPointerArray *observers = self.observers.copy;
    for (id <ADSensorMonitorManagerDelegate> observer in observers) {
        if (![observer respondsToSelector:_cmd]) continue;
        [observer monitorManager:manager didChangeMonitoringTilesCollectionFrom:from to:to];
    }
}

#pragma mark - ADPositioningManagerDelegate
- (void)positioningManager:(ADPositioningManager *)manager didUpdateLocation:(ADLocation *)location {
    self.location = location;
}

- (void)positioningManager:(ADPositioningManager *)manager didEnterLiftAtLocation:(ADLocation *)location {
    self.location = location;
}

@end

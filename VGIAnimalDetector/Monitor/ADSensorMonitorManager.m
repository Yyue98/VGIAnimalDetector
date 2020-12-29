//
//  ADSensorMonitorManager.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADSensorMonitorManager.h"


@interface ADSensorMonitorManager ()  < ADLocationManagerDelegate>


/// Default monitoring dimension
#define ad_DEFAULT_DIMENSION    5

/// Time interval for warning low accuracy heading update
#define ad_LOW_ACCURACY_HEADING_PERIOD   15

/// Timer for warning user when low accuracy heading update consisted for a period of time
@property (nonatomic, strong)   NSTimer *headingAccuracyTimer;

/// Calculation timer for nearest beacon calculate
@property (nonatomic, strong) dispatch_source_t calculationTimer;

/// Queue for nearest beacon calculation
@property (nonatomic, strong)   dispatch_queue_t    queue;

/// Last confirmed data
@property (nonatomic, copy) NSDate  *lastConfirmedDate;

/// Location for beacon ranging
@property (nonatomic, copy) CLLocation  *updatedLocation;

@end


@implementation ADSensorMonitorManager

- (instancetype)init {
    NSLog(@"Please use \"initWithDelegate:tileZoom:distanceConverter:dimensionConverter:\" to create ADSensorMonitorManager object");
    return nil;
}

- (instancetype)initWithDelegate:(id<ADSensorMonitorManagerDelegate>)delegate
                        tileZoom:(NSInteger)zoom
                  rangeConvertor:(ADSensorMonitorManagerMonitoringRangeConverter)range {
    NSAssert(delegate && zoom, @"delegate and zoom should not be nil");
    
    self = [super init];
    if (!self) return nil;
    
    _sensorDelegate = delegate;
    _rangeConverter = range;
    _locationDesireAccuracy = ADLocationManagerDesireAccuracyNormal;
    
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, -1);
    _queue = dispatch_queue_create("com.mrcrow.aicity.sensor.beacon", attr);
    
    _locationManager = [[ADLocationManager alloc] initWithDelegate:self tileZoom:zoom];
    _locationManager.core.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.core.distanceFilter = kCLDistanceFilterNone;
    _locationManager.core.headingFilter = kCLHeadingFilterNone;
    
    return self;
}

#pragma mark - Configuring Location Update Precision
- (CLLocationDistance)distanceFilter {
    return _locationManager.core.distanceFilter;
}

- (void)setDistanceFilter:(CLLocationDistance)distanceFilter {
    _locationManager.core.distanceFilter = distanceFilter;
}

- (CLLocationAccuracy)desiredAccuracy {
    return _locationManager.core.desiredAccuracy;
}

- (void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy {
    _locationManager.core.desiredAccuracy = desiredAccuracy;
}

#pragma mark - Requesting Authorization for Location Services
- (CLAuthorizationStatus)authorizationStatus {
    return [CLLocationManager authorizationStatus];
}

- (void)requestAlwaysAuthorization {
    [_locationManager.core requestAlwaysAuthorization];
}

- (void)requestWhenInUseAuthorization {
    [_locationManager.core requestWhenInUseAuthorization];
}

#pragma mark - Initiating Location Updates
- (void)startUpdatingLocation {
    [_locationManager startUpdatingLocationForMonitoring];
    [_locationManager startMonitoringTileRegions];
}

- (void)stopUpdatingLocation {
    [_locationManager stopUpdatingLocationForMonitoring];
    [_locationManager stopMonitoringTileRegions];
}

#pragma mark - Initiating Heading Updates
- (void)setHeadingOrientation:(CLDeviceOrientation)headingOrientation {
    _locationManager.core.headingOrientation = headingOrientation;
}

- (CLDeviceOrientation)headingOrientation {
    return _locationManager.core.headingOrientation;
}

- (void)startUpdatingHeading {
    [_locationManager.core startUpdatingHeading];
}

- (void)stopUpdatingHeading {
    [_locationManager.core stopUpdatingLocation];
}

- (void)dismissHeadingCalibrationDisplay {
    [_locationManager.core dismissHeadingCalibrationDisplay];
}

- (void)setLocationDesireAccuracy:(ADLocationManagerDesireAccuracy)locationDesireAccuracy {
    if (_locationDesireAccuracy == locationDesireAccuracy) return;
    
    _locationDesireAccuracy = locationDesireAccuracy;
    _locationManager.core.desiredAccuracy = locationDesireAccuracy == ADLocationManagerDesireAccuracyNormal ? kCLLocationAccuracyNearestTenMeters : kCLLocationAccuracyBestForNavigation;
}

- (void)setSensorState:(ADSensorMonitorManagerState)sensorState {
    if (_sensorState == sensorState) return;
    
    _sensorState = sensorState;
    if (self.sensorDelegate && [self.sensorDelegate respondsToSelector:@selector(monitorManager:didUpdateSensorState:)]) {
        [self.sensorDelegate monitorManager:self didUpdateSensorState:sensorState];
    }
}

/// Schedule timer for inaccurate heading update warning
- (void)scheduleHeadingAccuracyTimer {
    [self invalidateHeadingAccuracyTimer];
    
    __weak typeof(self) _self = self;
    _headingAccuracyTimer = [NSTimer scheduledTimerWithTimeInterval:ad_LOW_ACCURACY_HEADING_PERIOD repeats:NO block:^(NSTimer * _Nonnull timer) {
        __strong typeof(_self) self = _self;
        if (!self)  return;
        if (self.sensorDelegate && [self.sensorDelegate respondsToSelector:@selector(monitorManagerDidDetermineLowAccuracyHeadingUpdate:)]) {
            [self.sensorDelegate monitorManagerDidDetermineLowAccuracyHeadingUpdate:self];
        }
    }];
}

/// Invalidate heading accuracy timer
- (void)invalidateHeadingAccuracyTimer {
    if (!_headingAccuracyTimer) return;
    [_headingAccuracyTimer invalidate];
    _headingAccuracyTimer = nil;
}

- (void)scheduleCalculationTimer {
    [self invalidateCalculationTimer];
    
    dispatch_queue_t queue = dispatch_queue_create(0, 0);
    _calculationTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_calculationTimer, dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), NSEC_PER_SEC * 1, NSEC_PER_SEC * 0.1);
    dispatch_source_set_event_handler(_calculationTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self invalidateCalculationTimer];
        });
    });
    dispatch_resume(_calculationTimer);
}

- (void)invalidateCalculationTimer {
    if (!_calculationTimer) return;
    
    dispatch_source_cancel(_calculationTimer);
    _calculationTimer = nil;
}

- (void)resetHeadingAccuracyWarning {
    [self invalidateHeadingAccuracyTimer];
}

- (void)updateMonitoringLocation:(CLLocation *)location {
    if (location.horizontalAccuracy < 0 || location.horizontalAccuracy > 500) return;
    
    _updatedLocation = location;
}

/// Update sensor state with bluetooth and location service availability
- (void)updateSensorState {
    ADSensorMonitorManagerState state = ADSensorMonitorManagerStateNotReady;
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse || authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        state = ADSensorMonitorManagerStateReady;
    } else if (authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse || authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        state = ADSensorMonitorManagerStateBluetoothNotTurnOn;
    } else if (authorizationStatus != kCLAuthorizationStatusAuthorizedWhenInUse || authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        state = ADSensorMonitorManagerStateLocationServiceNotAutorized;
    }
    
    self.sensorState = state;
}

#pragma mark - ADLocationManagerDelegate
- (void)ad_locationManager:(ADLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self updateSensorState];
}

- (void)ad_locationManager:(ADLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.sensorDelegate && [self.sensorDelegate respondsToSelector:@selector(monitorManager:didFailWithError:)]) {
        [self.sensorDelegate monitorManager:self didFailWithError:error];
    }
}

- (void)ad_locationManager:(ADLocationManager *)manager didUpdateLocations:(NSArray <CLLocation *>*)locations {
    if (self.sensorDelegate && [self.sensorDelegate respondsToSelector:@selector(monitorManager:didUpdateLocations:)]) {
        [self.sensorDelegate monitorManager:self didUpdateLocations:locations];
    }
}

- (void)ad_locationManager:(ADLocationManager *)manager shouldUpdateMonitoringRangeWithLocation:(CLLocation *)location {
    if (!_rangeConverter) return;
    [self updateMonitoringLocation:location];
}

- (void)ad_locationManager:(ADLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    if (self.sensorDelegate && [self.sensorDelegate respondsToSelector:@selector(monitorManager:didUpdateHeading:)]) {
        [self.sensorDelegate monitorManager:self didUpdateHeading:heading];
    }
    
    if (heading.headingAccuracy < 0 || heading.headingAccuracy > 45) {
        if (_headingAccuracyTimer) return;
        [self scheduleHeadingAccuracyTimer];
    } else {
        [self invalidateHeadingAccuracyTimer];
    }
}

- (BOOL)ad_locationManagerShouldDisplayHeadingCalibration:(ADLocationManager *)manager {
    BOOL display = YES;
    if (self.sensorDelegate && [self.sensorDelegate respondsToSelector:@selector(monitorManagerShouldDisplayHeadingCalibration:)]) {
        display = [self.sensorDelegate monitorManagerShouldDisplayHeadingCalibration:self];
    }
    
    return display;
}

- (void)ad_locationManager:(ADLocationManager *)manager didChangedMonitoringRange:(ADLocationManagerMonitoringRange)range {
    if (self.sensorDelegate && [self.sensorDelegate respondsToSelector:@selector(monitorManager:didChangedMonitoringRange:)]) {
        [self.sensorDelegate monitorManager:self didChangedMonitoringRange:range];
    }
}

- (void)ad_locationManager:(ADLocationManager *)manager didStartMonitoringTilesWithTileCodes:(NSArray<NSString *> *)tileCodes {
    if (self.sensorDelegate && [self.sensorDelegate respondsToSelector:@selector(monitorManager:didStartMonitoringTilesWithTileCodes:)]) {
        [self.sensorDelegate monitorManager:self didStartMonitoringTilesWithTileCodes:tileCodes];
    }
}

- (void)ad_locationManager:(ADLocationManager *)manager didStopMonitoringTilesWithTileCodes:(NSArray<NSString *> *)tileCodes {
    if (self.sensorDelegate && [self.sensorDelegate respondsToSelector:@selector(monitorManager:didStopMonitoringTilesWithTileCodes:)]) {
        [self.sensorDelegate monitorManager:self didStopMonitoringTilesWithTileCodes:tileCodes];
    }
}

- (void)ad_locationManager:(ADLocationManager *)manager didChangeMonitoringTilesCollectionFrom:(ADTileCollection *)from to:(ADTileCollection *)to {
    if (self.sensorDelegate && [self.sensorDelegate respondsToSelector:@selector(monitorManager:didChangeMonitoringTilesCollectionFrom:to:)]) {
        [self.sensorDelegate monitorManager:self didChangeMonitoringTilesCollectionFrom:from to:to];
    }
}

@end


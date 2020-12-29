//
//  ADSensorMonitorManager.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>
#import "ADLocationManager.h"


/// State that determine manager usablility
typedef NS_ENUM(NSInteger, ADSensorMonitorManagerState) {
    // Determined that bluetooth and location service are ready to go
    ADSensorMonitorManagerStateReady                        = 0,
    
    // Determined that location service is not authorized by user
    ADSensorMonitorManagerStateLocationServiceNotAutorized  = 1,
    
    // Determined that bluetooth is not turned on
    ADSensorMonitorManagerStateBluetoothNotTurnOn           = 2,
    
    // Determined that both bluetooth and location service are not ready
    ADSensorMonitorManagerStateNotReady                     = 3
};

///  Desire accuracy for location usage
typedef NS_ENUM(NSInteger, ADLocationManagerDesireAccuracy) {
    //  kCLLocationAccuracyNearestTenMeters
    //  Ten meters location accuracy for low accuracy and low power usage
    ADLocationManagerDesireAccuracyNormal               = 0,
    
    //  kCLLocationAccuracyBestForNavigation
    //  Best location accuracy for navigation but high power usage
    ADLocationManagerDesireAccuracyBestForNavigation    = 1
};

/// Conversion block for auto-translate monitoring range by location update
/// @param location Conversion block
typedef ADLocationManagerMonitoringRange (^ADSensorMonitorManagerMonitoringRangeConverter)(CLLocation *location);


@class ADSensorMonitorManager;


/// Delegate of ADSensorMonitorManager
@protocol ADSensorMonitorManagerDelegate <NSObject>
@optional


/// Invoked when location service failed to start with error
/// @param manager ADSensorMonitorManager object
/// @param error Failed with error
- (void)monitorManager:(ADSensorMonitorManager *)manager didFailWithError:(NSError *)error;

/// Invoked when sensor state changed
/// @param manager ADSensorMonitorManager object
/// @param state Sensor state
- (void)monitorManager:(ADSensorMonitorManager *)manager didUpdateSensorState:(ADSensorMonitorManagerState)state;

/// Invoked when new locations are available
/// @param manager ADSensorMonitorManager object
/// @param locations Array of CLLocation objects in chronological order
- (void)monitorManager:(ADSensorMonitorManager *)manager didUpdateLocations:(NSArray <CLLocation *>*)locations;

/// Invoked when heading calibration is required, return YES will display calibration on screen
/// @param manager ADSensorMonitorManager object
- (BOOL)monitorManagerShouldDisplayHeadingCalibration:(ADSensorMonitorManager *)manager;

/// Invoked when new heading has been detected
/// @param manager ADSensorMonitorManager object
/// @param heading Updated CLHeading object
- (void)monitorManager:(ADSensorMonitorManager *)manager didUpdateHeading:(CLHeading *)heading;

/// Invoked when low accuracy heading update consist for a period of time
/// @param manager ADSensorMonitorManager object
- (void)monitorManagerDidDetermineLowAccuracyHeadingUpdate:(ADSensorMonitorManager *)manager;

/// Invoked when monitoring range changed
/// @param manager ADLocationManager object
/// @param range Monitoring range
- (void)monitorManager:(ADSensorMonitorManager *)manager didChangedMonitoringRange:(ADLocationManagerMonitoringRange)range;

/// Invoked when square region has been monitored successfully
/// @param manager ADLocationManager object
/// @param tileCodes Tile codes for tile regions
- (void)monitorManager:(ADSensorMonitorManager *)manager didStartMonitoringTilesWithTileCodes:(NSArray <NSString *> *)tileCodes;

/// Invoked when square region has been removed from monitoring list
/// @param manager ADLocationManager object
/// @param tileCodes Tile codes for tile regions
- (void)monitorManager:(ADSensorMonitorManager *)manager didStopMonitoringTilesWithTileCodes:(NSArray <NSString *> *)tileCodes;

/// Invoked when ADLocationManager changed monitoring area by location changes
/// @param manager ADLocationManager object
/// @param from Previous monitoring tile collection
/// @param to Current monitoring tile collection
- (void)monitorManager:(ADSensorMonitorManager *)manager didChangeMonitoringTilesCollectionFrom:(ADTileCollection *)from to:(ADTileCollection *)to;


@end


@interface ADSensorMonitorManager : NSObject <MGLLocationManager>


/// Size converter for auto sizing monitoring area size
@property (nonatomic, copy) ADSensorMonitorManagerMonitoringRangeConverter  rangeConverter;

/// Location desire accuracy for location update, default is ADLocationManagerDesireAccuracyNormal
@property (nonatomic, assign)   ADLocationManagerDesireAccuracy locationDesireAccuracy;

/// Sonsor state use for indicating the bluetooth and location service availability
@property (nonatomic, assign, readonly) ADSensorMonitorManagerState sensorState;

/// Location manager for heading/location/area/beacon updates
@property (nonatomic, strong, readonly) ADLocationManager   *locationManager;

/// MGLLocationManagerDelegate for MGLMapView userLocation updating
@property (nonatomic, weak) id <MGLLocationManagerDelegate> delegate;

/// ADSensorMonitorManagerDelegate delegate to receive notification
@property (nonatomic, weak, readonly) id <ADSensorMonitorManagerDelegate>   sensorDelegate;

/// Designate initializer to create ADSensorMonitorManager object
/// @param delegate Sensor delegate object
/// @param zoom Default zoom level for calculation
/// @param location Location convertor block
/// @param distance Distance convertor block
/// @param range Range convertor block
- (instancetype)initWithDelegate:(id <ADSensorMonitorManagerDelegate>)delegate
                        tileZoom:(NSInteger)zoom
                  rangeConvertor:(ADSensorMonitorManagerMonitoringRangeConverter)range;

/// Update monitoring location with input
/// @param location - location input
- (void)updateMonitoringLocation:(CLLocation *)location;


/// Reset warning timer for inaccurate heading update
- (void)resetHeadingAccuracyWarning;


@end

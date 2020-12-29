//
//  ADLocationManager.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>
#import "ADTileCollection.h"


@class ADLocationManager;

/// A structure that contains monitoring parameter with coordinate and dimension
/// Fields:
///     center:
///         Location coordinate center
///     dimension:
///         Monitoring tile dimension
struct ADLocationManagerMonitoringRange {
    CLLocationCoordinate2D center;
    NSInteger dimension;
};
typedef struct ADLocationManagerMonitoringRange ADLocationManagerMonitoringRange;

/// Designate initializer for ADLocationManagerMonitoringRange object
ADLocationManagerMonitoringRange ADLocationManagerMonitoringMakeRange(CLLocationCoordinate2D center, NSInteger dimension);

/// Return an invalid monitoring range
ADLocationManagerMonitoringRange ADLocationManagerMonitoringRangeInvalid(void);

/// Validate monitoring range
BOOL ADLocationManagerMonitoringRangeIsValid(ADLocationManagerMonitoringRange range);

/// Check equality between two ranges
/// @param lh Left hand range
/// @param rh Right hand range
BOOL ADLocationManagerMonitoringRangeIsEqualsToRange(ADLocationManagerMonitoringRange lh, ADLocationManagerMonitoringRange rh);


/// Delegate of ADLocationManager
@protocol ADLocationManagerDelegate <NSObject>
@optional

/// Invoked when authorization status changed
/// @param manager ADLocationManager object
/// @param status Authorization status
- (void)ad_locationManager:(ADLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;

/// Invoked when location service failed to start with error
/// @param manager ADLocationManager object
/// @param error Failed with error
- (void)ad_locationManager:(ADLocationManager *)manager didFailWithError:(NSError *)error;

/// Invoked when new locations are available
/// @param manager ADLocationManager object
/// @param locations Array of CLLocation objects in chronological order
- (void)ad_locationManager:(ADLocationManager *)manager didUpdateLocations:(NSArray <CLLocation *>*)locations;

///Invoked when monitoring tile regions started
///@param manager ADLocationManager object
///@param location Location input for monitoring
- (void)ad_locationManager:(ADLocationManager *)manager shouldUpdateMonitoringRangeWithLocation:(CLLocation *)location;

/// Invoked when new heading has been detected
/// @param manager ADLocationManager object
/// @param heading Updated CLHeading object
- (void)ad_locationManager:(ADLocationManager *)manager didUpdateHeading:(CLHeading *)heading;

/// Invoked when heading calibration is required, return YES will display calibration on screen
/// @param manager ADLocationManager object
- (BOOL)ad_locationManagerShouldDisplayHeadingCalibration:(ADLocationManager *)manager;


/// Invoked when monitoring range changed
/// @param manager ADLocationManager object
/// @param range Monitoring range
- (void)ad_locationManager:(ADLocationManager *)manager didChangedMonitoringRange:(ADLocationManagerMonitoringRange)range;

/// Invoked when tile region has been monitored successfully
/// @param manager ADLocationManager object
/// @param tileCodes Tile codes for tile regions
- (void)ad_locationManager:(ADLocationManager *)manager didStartMonitoringTilesWithTileCodes:(NSArray <NSString *>*)tileCodes;

/// Invoked when tile region has been removed from monitoring list
/// @param manager ADLocationManager object
/// @param tileCodes Tile codes for tile regions
- (void)ad_locationManager:(ADLocationManager *)manager didStopMonitoringTilesWithTileCodes:(NSArray <NSString *>*)tileCodes;

/// Invoked when ADLocationManager changed monitoring area by location changes
/// @param manager ADLocationManager object
/// @param from Previous monitoring tile collection
/// @param to Current monitoring tile collection
- (void)ad_locationManager:(ADLocationManager *)manager didChangeMonitoringTilesCollectionFrom:(ADTileCollection *)from to:(ADTileCollection *)to;

@end

@interface ADLocationManager : NSObject

/// ADLocationManager delegate object
@property (nonatomic, weak, readonly) id <ADLocationManagerDelegate>  delegate;

/// Location manager core object
@property (nonatomic, strong)   CLLocationManager   *core;

/// Zoom level for tile manager monitoring
@property (nonatomic, assign, readonly) NSInteger   tileZoom;

/// Initialize ADLocationManager object with delegate and zoom level
/// @param delegate ADLocationManager delegate object
- (instancetype)initWithDelegate:(id <ADLocationManagerDelegate>)delegate tileZoom:(NSInteger)zoom;

/// Start updating location for tile monitoring
- (void)startUpdatingLocationForMonitoring;

/// Stop updating location for tile monitoring
- (void)stopUpdatingLocationForMonitoring;

/// Monitoring tile collections of regions
- (void)startMonitoringTileRegions;

/// Update monitoring with range
/// @param range Monitoring range
- (void)updateMonitoringTileRegionsWithRange:(ADLocationManagerMonitoringRange)range;

/// Stop monitoring tile regions and release current area
- (void)stopMonitoringTileRegions;

@end

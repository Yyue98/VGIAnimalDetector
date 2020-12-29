//
//  ADMercatorProjector.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "ADTileRegion.h"


NS_ASSUME_NONNULL_BEGIN

@interface ADMercatorProjector : NSObject


/**
 initWithTileSize:

 Discussion:
    Designate initliazer for ADMercatorProjector object
 
 @param size - tile size
 */
- (instancetype)initWithTileSize:(NSUInteger)size;


/**
 coordinateToMeters:
 
 Discussion:
    Convert coordinate in WGS84 Datum to Spherical Mercator EPSG:900913 xy point in meters
 
 @param coordinate - location coordinate
 */
- (CGPoint)coordinateToMeters:(CLLocationCoordinate2D)coordinate;


/**
 metersToCoordinate:
 
 Discussion:
    Converts XY point from Spherical Mercator EPSG:900913 to lat/lon in WGS84 Datum
 
 @param meters - xy point in meters
 */
- (CLLocationCoordinate2D)metersToCoordinate:(CGPoint)meters;


/**
 tileWithZoom:atCoordinate:

 Discussion:
    Retrieve tile region from coordinate and zoom
 
 @param zoom - zoom level
 @param coordinate - location coordinate
 */
- (ADTileRegion *)tileWithZoom:(NSUInteger)zoom atCoordinate:(CLLocationCoordinate2D)coordinate;


/**
 tileXYWithZoom:atCoordinate:
 
 Discussion:
    Get tile x/y with zoom level and location coordinate

 @param zoom - zoom level
 @param coordinate - location coordinate
 */
- (CGPoint)tileXYWithZoom:(NSUInteger)zoom atCoordinate:(CLLocationCoordinate2D)coordinate;


/**
 tileCodeWithZoom:x:y:

 Discussion:
    Get tile formatted code zoom/x/y with zoom, x, y input
 
 @param zoom - zoom level
 @param x - x index
 @param y - y index
 */
- (NSString *)tileCodeWithZoom:(NSUInteger)zoom x:(NSUInteger)x y:(NSUInteger)y;


/**
 tileWithZoom:x:y:

 Discussion:
    Retrieve tile region with zoom, x, y input
 
 @param zoom - zoom level
 @param x - x index
 @param y - y index
 */
- (ADTileRegion *)tileWithZoom:(NSUInteger)zoom x:(NSInteger)x y:(NSUInteger)y;


/**
 tileYRangeInZoom:

 Discussion:
    Get validate range for Y value in zoom level
 
 @param zoom - zoom level
 */
- (NSRange)tileYRangeInZoom:(NSUInteger)zoom;


@end

NS_ASSUME_NONNULL_END


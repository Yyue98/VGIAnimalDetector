//
//  ADTileManager.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ADTileRegion.h"
#import "ADTileCollection.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADTileManager : NSObject


/**
 sharedManager

 Discussion:
    Designate singleton initializer for ADTilesManager object
 */
+ (instancetype)sharedManager;


/**
 initWithHightDPITileImages:
 
 Discussion:
    High DPI tiles are 512 X 512 pixel size tile images, default is 256 x 256 pixel size

 @param high - high dpi tile option
 */
- (instancetype)initWithHightDPITileImages:(BOOL)high;


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
 tileCodeWithZoom:atCoordinate:

 Discussion:
    Get tile code for coordinate at zoom level
 
 @param zoom - zoom level
 @param coordinate - location coordinate
 */
- (NSString *)tileCodeWithZoom:(NSUInteger)zoom atCoordinate:(CLLocationCoordinate2D)coordinate;


/**
 tileWithZoom:atCoordinate:

 Discussion:
    Get tile under certain zoom level and location coordinate,
    Tile x, y are calculated under Google schema (not TMS)
 
 @param zoom - zoom level
 @param coordinate - location coordinate
 */
- (ADTileRegion *)tileWithZoom:(NSUInteger)zoom atCoordinate:(CLLocationCoordinate2D)coordinate;


/**
tileWithTileCode:

Discussion:
   Get tile region based on tile code

@param tileCode - tile code in string
*/
- (ADTileRegion *)tileWithTileCode:(NSString *)tileCode;


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
- (ADTileRegion *)tileWithZoom:(NSUInteger)zoom x:(NSUInteger)x y:(NSUInteger)y;


/**
 tileCollectionWithZoom:atCoordinate:withDimension:

 Discussion:
    Get tiles collection with certain zoom level, location coordinate and dimension
 
 @param zoom - zoom level
 @param coordinate - location coordinate
 @param dimension - collection dimension, odd integer
 */
- (ADTileCollection *)tileCollectionWithZoom:(NSUInteger)zoom atCoordinate:(CLLocationCoordinate2D)coordinate withDimension:(NSUInteger)dimension;


/**
 tileCollectionRangeWithZoom:atCoordinate:withDimension:

 Discussion:
    Get tile collection range with certain zoom level, location coordinate and dimension
 
 @param zoom - zoom level
 @param coordinate - location coordinate
 @param dimension - dimension
 */
- (ADTileCollectionRange)tileCollectionRangeWithZoom:(NSUInteger)zoom atCoordinate:(CLLocationCoordinate2D)coordinate withDimension:(NSUInteger)dimension;


/**
 tileCollectionRangeWithZoom:fromCoordinate:toCoordinates:
 
 Discussion:
    Get tile collection range with certain zoom level from one coordinate to another
 
 @param zoom - zoom level
 @param from - from one coordinate
 @param to - to another coordinate
 */
- (ADTileCollectionRange)tileCollectionRangeWithZoom:(NSUInteger)zoom fromCoordinate:(CLLocationCoordinate2D)from toCoordinates:(CLLocationCoordinate2D)to;


/**
 tileCollectionWithRange:

 Discussion:
    Get tile collection with range
 
 @param range - tile range
 */
- (ADTileCollection *)tileCollectionWithRange:(ADTileCollectionRange)range;


/**
 tilesFrom:to:withZoom:

 Discussion:
    Get tiles from x/y to x/y
 
 @param fromXY - from x/y
 @param toXY - to x/y
 @param zoom - zoom level
 */
- (NSArray <ADTileRegion *>*)tilesFrom:(CGPoint)fromXY to:(CGPoint)toXY withZoom:(NSUInteger)zoom;


@end

NS_ASSUME_NONNULL_END


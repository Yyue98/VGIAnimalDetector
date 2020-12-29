//
//  ADTileRegion.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>


NS_ASSUME_NONNULL_BEGIN


/**
 ADTileData
 
 Discussion:
    A structure that contains map tile basic info
    Basically, tiles normally are 256 x 256 pixel size image
    Origin is the north-west point from the map
 
 Fields:
    pixelSize:
        Tile pixel size, normally 256
    zoom:
        The zoom level of tile
    x:
        The column number
    y:
        The row number
 */
struct ADTileData {
    NSInteger   pixelSize;
    NSInteger   zoom;
    NSInteger   x;
    NSInteger   y;
};
typedef struct ADTileData ADTileData;


/**
 ADTileDataMake()

 Discussion:
    Designate initliazer for ADTileData struct
 
 @param size - tile pixel size
 @param zoom - zoom level
 @param x - x index
 @param y - y index
 */
ADTileData ADTileDataMake(NSInteger size, NSInteger zoom, NSInteger x, NSInteger y);


/**
 ADTileDataIsEqualsTo()
 
 Discussion:
    Compare ADTileData structs equality
 
 @param lh - left tile data
 @param rh - right tile data
 */
BOOL ADTileDataIsEqualsTo(ADTileData lh, ADTileData rh);


/**
 ADTileBoundingBox
 
 Discussion:
    A structure that contains tile bounding corner coordinates
 
 Fields:
    northEast:
        Box north east coordinate
    northWest:
        Box north west coordinate
    southEast:
        Box south east coordinate
    southWest:
        Box south west coordinate
 */
struct ADTileBoundingBox {
    CLLocationCoordinate2D  northEast;
    CLLocationCoordinate2D  northWest;
    CLLocationCoordinate2D  southEast;
    CLLocationCoordinate2D  southWest;
};
typedef struct ADTileBoundingBox ADTileBoundingBox;


/**
 ADTileBoundingBoxMake()
 
 Discussion:
    Designate initializer for ADTileBoundingBox struct
 
 @param northWest - north west coordinate
 @param northEast - north east coordinate
 @param southEast - south east coordinate
 @param southWest - south west coordinate
 */
ADTileBoundingBox ADTileBoundingBoxMake(CLLocationCoordinate2D northWest,
                                        CLLocationCoordinate2D northEast,
                                        CLLocationCoordinate2D southEast,
                                        CLLocationCoordinate2D southWest);


/**
 ADTileBoundingBoxInvalid()

 Discussion:
    Return a invalid bounding box
 */
ADTileBoundingBox ADTileBoundingBoxInvalid(void);


@interface ADTileRegion : NSObject <NSCopying>


/**
 tileCode
 
 Discussion:
    Tile code for region under Google schema
 */
@property (nonatomic, copy) NSString    *tileCode;


/**
 tile
 
 Discussion:
    ADTileRegion tile info, contains x, y, zoom and size
 */
@property (nonatomic, assign)   ADTileData  data;


/**
 bounding
 
 Discussion:
    ADTileRegion bounding info, contains four corner's coordinate
 */
@property (nonatomic, assign)   ADTileBoundingBox   bounding;


/**
 initWithTilePixelSize:zoom:x:y:boundingBox

 Discussion:
    Designate initializer for ADTileRegion object
 
 @param size - tile pixel size
 @param zoom - zoom level
 @param x - coloum index
 @param y - row index
 @param code - formatted tile code
 @param box - bounding box
 */
- (instancetype)initWithTilePixelSize:(NSInteger)size
                                 zoom:(NSInteger)zoom
                                    x:(NSInteger)x
                                    y:(NSInteger)y
                             tileCode:(NSString *)code
                          boundingBox:(ADTileBoundingBox)box;

@end

NS_ASSUME_NONNULL_END


//
//  ADTileCollection.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import "ADTileRegion.h"
#import "ADTileCollectionChanges.h"

NS_ASSUME_NONNULL_BEGIN


/**
 ADTileCollectionRange
 
 Discussion:
    A structure that contains map tile within x/y ranges
 
 Fields:
    zoom:
        Zoom level
    xRange:
        Tile x range
    yRange:
        Tile y range
 */
struct ADTileCollectionRange {
    NSInteger zoom;
    NSRange xRange;
    NSRange yRange;
};
typedef struct ADTileCollectionRange ADTileCollectionRange;


/**
 ADTilesCollectionRangeMake()

 Discussion:
    Designate initializer for ADTilesCollectionRange struct
 
 @param zoom - zoom level
 @param xRange - tile x range
 @param yRange - tile y range
 */
ADTileCollectionRange ADTileCollectionRangeMake(NSInteger zoom, NSRange xRange, NSRange yRange);


/**
 ADTilesCollectionRangeIsEqualsTo()

 Discussion:
    Compare ADTilesCollectionRange structs equality
 
 @param lh - left collection range
 @param rh - right collection range
 */
BOOL ADTileCollectionRangeIsEqualsTo(ADTileCollectionRange lh, ADTileCollectionRange rh);


@interface ADTileCollection : NSObject <NSCopying>


/**
 range
 
 Discussion:
    Range contains x/y ranges
 */
@property (nonatomic, assign)   ADTileCollectionRange   range;


/**
 tiles
 
 Discussion:
    Tiles contains with range
 */
@property (nonatomic, copy) NSArray <NSString *>    *tileCodes;


/**
 initWithRange:tiles:

 Discussion:
    Designate initializer for ADTileCollection object
 
 @param range - x/y range
 @param tileCodes - tile codes within range
 */
- (instancetype)initWithRange:(ADTileCollectionRange)range tileCodes:(NSArray <NSString *>*)tileCodes;


/**
 containsTileWithTileCode:

 Discussion:
    Check if tile with tile code has been included in collection
 
 @param tileCode - tile code
 */
- (BOOL)containsTileWithTileCode:(NSString *)tileCode;


/**
 tileAt
 
 Discussion:
    Get tile at x/y
 */
- (NSString *(^)(NSInteger, NSInteger))tileCodeAt;


/**
 intersect
 
 Discussion:
    Get intersection tiles with input tiles collection
 */
- (NSArray <NSString *>*(^)(ADTileCollection *))intersect;


/**
 minus
 
 Discussion:
    Do minus calculation with input tiles
 */
- (NSArray <NSString *>*(^)(NSArray <NSString *>*))minus;


/**
 changesFrom:

 Discussion:
    Get changes information comparing to collection before
 
 @param from - changes from collection
 */
- (ADTileCollectionChanges *)changesFrom:(ADTileCollection *)from;


@end

NS_ASSUME_NONNULL_END


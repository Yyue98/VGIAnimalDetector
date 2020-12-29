//
//  ADTileManager.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADTileManager.h"
#import "ADMercatorProjector.h"

@interface ADTileManager ()

/**
 projector
 
 Discussion:
    Mercator projector for point converting
 */
@property (nonatomic, strong)   ADMercatorProjector *projector;


@end


@implementation ADTileManager

+ (instancetype)sharedManager {
    static ADTileManager *generator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        generator = [[ADTileManager alloc] initWithHightDPITileImages:NO];
    });
    
    return generator;
}

- (instancetype)init {
    return [self initWithHightDPITileImages:NO];
}

- (instancetype)initWithHightDPITileImages:(BOOL)high {
    self = [super init];
    if (!self) return nil;
    
    NSUInteger tileSize = high ? 512 : 256;
    _projector = [[ADMercatorProjector alloc] initWithTileSize:tileSize];
    return self;
}

- (CGPoint)coordinateToMeters:(CLLocationCoordinate2D)coordinate {
    return [_projector coordinateToMeters:coordinate];
}

- (CLLocationCoordinate2D)metersToCoordinate:(CGPoint)meters {
    return [_projector metersToCoordinate:meters];
}

- (NSString *)tileCodeWithZoom:(NSUInteger)zoom atCoordinate:(CLLocationCoordinate2D)coordinate {
    CGPoint tileXY = [_projector tileXYWithZoom:zoom atCoordinate:coordinate];
    return [_projector tileCodeWithZoom:zoom x:tileXY.x y:tileXY.y];
}

- (ADTileRegion *)tileWithZoom:(NSUInteger)zoom atCoordinate:(CLLocationCoordinate2D)coordinate {
    return [_projector tileWithZoom:zoom atCoordinate:coordinate];
}

- (ADTileRegion *)tileWithTileCode:(NSString *)tileCode {
    NSArray *components = [tileCode componentsSeparatedByString:@"/"];
    if ([components count] < 3) {
        NSLog(@"ADTileManager: Invalid tile code %@", tileCode);
        return nil;
    }
    
    NSUInteger x = [components[0] integerValue];
    NSUInteger y = [components[1] integerValue];
    NSUInteger zoom = [components[2] integerValue];
    return [_projector tileWithZoom:zoom x:x y:y];
}

- (NSString *)tileCodeWithZoom:(NSUInteger)zoom x:(NSUInteger)x y:(NSUInteger)y {
    return [_projector tileCodeWithZoom:zoom x:x y:y];
}

- (ADTileRegion *)tileWithZoom:(NSUInteger)zoom x:(NSUInteger)x y:(NSUInteger)y {
    return [_projector tileWithZoom:zoom x:x y:y];
}

- (ADTileCollection *)tileCollectionWithZoom:(NSUInteger)zoom atCoordinate:(CLLocationCoordinate2D)coordinate withDimension:(NSUInteger)dimension {
    ADTileCollectionRange range = [self tileCollectionRangeWithZoom:zoom atCoordinate:coordinate withDimension:dimension];
    return [self tileCollectionWithRange:range];
}

- (ADTileCollectionRange)tileCollectionRangeWithZoom:(NSUInteger)zoom atCoordinate:(CLLocationCoordinate2D)coordinate withDimension:(NSUInteger)dimension {
    CGPoint tileXY = [_projector tileXYWithZoom:zoom atCoordinate:coordinate];
    NSUInteger length = (dimension - 1) / 2;
    NSUInteger xOrigin = tileXY.x - length;
    NSUInteger xMax = xOrigin + dimension - 1;
    
    NSUInteger yOrigin = tileXY.y - length;
    NSUInteger yMax = yOrigin + dimension - 1;
    
    NSRange availableRange = [_projector tileYRangeInZoom:zoom];
    if (yOrigin < availableRange.location)  yOrigin = 0;
    if (yMax > NSMaxRange(availableRange))  yMax = NSMaxRange(availableRange);
    
    NSRange rangeX = NSMakeRange(xOrigin, xMax - xOrigin);
    NSRange rangeY = NSMakeRange(yOrigin, yMax - yOrigin);
    return ADTileCollectionRangeMake(zoom, rangeX, rangeY);
}

- (ADTileCollectionRange)tileCollectionRangeWithZoom:(NSUInteger)zoom fromCoordinate:(CLLocationCoordinate2D)from toCoordinates:(CLLocationCoordinate2D)to {
    CGPoint fromXY = [_projector tileXYWithZoom:zoom atCoordinate:from];
    CGPoint toXY = [_projector tileXYWithZoom:zoom atCoordinate:to];
    
    NSUInteger fromX = MIN(fromXY.x, toXY.x);
    NSUInteger toX = MAX(fromXY.x, toXY.x);
    NSUInteger fromY = MIN(fromXY.y, toXY.y);
    NSUInteger toY = MAX(fromXY.y, toXY.y);
    
    NSRange rangeX = NSMakeRange(fromX, toX - fromX);
    NSRange rangeY = NSMakeRange(fromY, toY - fromY);
    return ADTileCollectionRangeMake(zoom, rangeX, rangeY);
}

- (ADTileCollection *)tileCollectionWithRange:(ADTileCollectionRange)range {
    NSMutableArray *tileCodes = @[].mutableCopy;
    for (NSUInteger x = range.xRange.location; x <= NSMaxRange(range.xRange); x++) {
        for (NSUInteger y = range.yRange.location; y <= NSMaxRange(range.yRange); y++) {
            NSString *tile = [_projector tileCodeWithZoom:range.zoom x:x y:y];
            [tileCodes addObject:tile];
        }
    }
    
    return [[ADTileCollection alloc] initWithRange:range tileCodes:tileCodes.copy];
}

- (NSArray <ADTileRegion *>*)tilesFrom:(CGPoint)fromXY to:(CGPoint)toXY withZoom:(NSUInteger)zoom {
    NSMutableArray *mutable = @[].mutableCopy;
    NSUInteger fromX = MIN(fromXY.x, toXY.x);
    NSUInteger toX = MAX(fromXY.x, toXY.x);
    NSUInteger fromY = MIN(fromXY.y, toXY.y);
    NSUInteger toY = MAX(fromXY.y, toXY.y);
    for (NSUInteger x = fromX; x <= toX; x++) {
        for (NSUInteger y = fromY; y <= toY; y++) {
            ADTileRegion *tile = [self tileWithZoom:zoom x:x y:y];
            if (tile) {
                [mutable addObject:tile];
            }
        }
    }
    
    return mutable.copy;
}

@end

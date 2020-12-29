//
//  ADTileRegion.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADTileRegion.h"


ADTileData ADTileDataMake(NSInteger size, NSInteger zoom, NSInteger x, NSInteger y) {
    ADTileData data;
    data.pixelSize = size;
    data.zoom = zoom;
    data.x = x;
    data.y = y;
    return data;
}

BOOL ADTileDataIsEqualsTo(ADTileData lh, ADTileData rh) {
    return lh.pixelSize == rh.pixelSize && lh.zoom == rh.zoom && lh.x == rh.x && lh.y == rh.y;
}

ADTileBoundingBox ADTileBoundingBoxMake(CLLocationCoordinate2D northWest,
                                        CLLocationCoordinate2D northEast,
                                        CLLocationCoordinate2D southEast,
                                        CLLocationCoordinate2D southWest) {
    ADTileBoundingBox box;
    box.northWest = northWest;
    box.northEast = northEast;
    box.southEast = southEast;
    box.southWest = southWest;
    return box;
}

ADTileBoundingBox ADTileBoundingBoxInvalid(void) {
    return ADTileBoundingBoxMake(kCLLocationCoordinate2DInvalid,
                                 kCLLocationCoordinate2DInvalid,
                                 kCLLocationCoordinate2DInvalid,
                                 kCLLocationCoordinate2DInvalid);
}

@implementation ADTileRegion

- (instancetype)init {
    NSLog(@"Please use \"initWithTilePixelSize:zoom:x:y:\" to create ADTileRegion object");
    return nil;
}

- (instancetype)initWithTilePixelSize:(NSInteger)size zoom:(NSInteger)zoom x:(NSInteger)x y:(NSInteger)y tileCode:(NSString *)code boundingBox:(ADTileBoundingBox)box {
    NSAssert(size > 0 && zoom >= 0 && x >= 0 && y >= 0 && [code length], @"zoom/x/y should both greater or equals to 0");
    self = [super init];
    if (!self)  return nil;
    
    _data = ADTileDataMake(size, zoom, x, y);
    _bounding = box;
    _tileCode = code;
    return self;
}


/**
 initWithTileData:boundingBox:code:

 Discussion:
    Used only for NSCopying protocol
 
 @param data - tile data
 @param bounding - tile bounding box
 @param code - tile code
 */
- (instancetype)initWithTileData:(ADTileData)data boundingBox:(ADTileBoundingBox)bounding code:(NSString *)code {
    self = [super init];
    if (!self)  return nil;
    
    _data = data;
    _bounding = bounding;
    _tileCode = code;
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Tile: %@[%@]\nBounding:\n\tNW: (%6f, %6f)\n\tSW: (%6f, %6f)\n\tNE: (%6f, %6f)\n\tSE: (%6f, %6f)",
            _tileCode,
            @(_data.pixelSize),
            _bounding.northWest.latitude, _bounding.northWest.longitude,
            _bounding.southWest.latitude, _bounding.southWest.longitude,
            _bounding.northEast.latitude, _bounding.northEast.longitude,
            _bounding.southEast.latitude, _bounding.southEast.longitude];
}

#pragma mark - Equality
- (BOOL)isEqual:(id)object {
    if (self == object) return YES;
    if (![object isKindOfClass:[ADTileRegion class]])   return NO;
    return [self isEqualsToTile:(ADTileRegion *)object];
}

- (BOOL)isEqualsToTile:(ADTileRegion *)tile {
    if (!tile) return NO;
    return ADTileDataIsEqualsTo(_data, tile.data);
}

- (NSUInteger)hash {
    NSUInteger pixelHash = [@(_data.pixelSize) hash];
    NSUInteger zoomHash = [@(_data.zoom) hash];
    NSUInteger xHash = [@(_data.x) hash];
    NSUInteger yHash = [@(_data.y) hash];
    return pixelHash ^ zoomHash ^ xHash ^ yHash;
}

#pragma mark - NSCopying
- (id)copyWithZone:(nullable NSZone *)zone {
    return [[ADTileRegion allocWithZone:zone] initWithTileData:_data
                                                   boundingBox:_bounding
                                                          code:_tileCode];
}

@end


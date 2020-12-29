//
//  ADLocationManager.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADLocationManager.h"
#import <MapKit/MapKit.h>
#import "ADTileManager.h"
#import "ADGeometry.h"

ADLocationManagerMonitoringRange ADLocationManagerMonitoringMakeRange(CLLocationCoordinate2D center, NSInteger dimension) {
    ADLocationManagerMonitoringRange range;
    range.center = center;
    range.dimension = dimension;
    return range;
}

ADLocationManagerMonitoringRange ADLocationManagerMonitoringRangeInvalid(void) {
    ADLocationManagerMonitoringRange range;
    range.center = kCLLocationCoordinate2DInvalid;
    range.dimension = 0;
    return range;
}

BOOL ADLocationManagerMonitoringRangeIsValid(ADLocationManagerMonitoringRange range) {
    return CLLocationCoordinate2DIsValid(range.center) && range.dimension > 0 && range.dimension % 2 == 1;
}

BOOL ADLocationManagerMonitoringRangeIsEqualsToRange(ADLocationManagerMonitoringRange lh, ADLocationManagerMonitoringRange rh) {
    return ADMapCoordinateEqualsToCoordinate(lh.center, rh.center) && lh.dimension == rh.dimension;
}


@interface ADLocationManager () <CLLocationManagerDelegate>

/// Location for monitoring square regions
@property (nonatomic, copy) CLLocation  *currentLocation;

/// Tile region collection under monitoring
@property (nonatomic, copy) ADTileCollection    *monitoringTiles;

/// Indicates monitoring started or not
@property (nonatomic, assign)   BOOL    monitoringStart;

/// Monitoring range contains coordinate and dimension
@property (nonatomic, assign)   ADLocationManagerMonitoringRange   monitoringRange;

@end

@implementation ADLocationManager

- (instancetype)init {
    NSLog(@"Please use \'initWithDelegate:tileZoom:\' to create ADLocationManager object");
    return nil;
}

- (instancetype)initWithDelegate:(id<ADLocationManagerDelegate>)delegate tileZoom:(NSInteger)zoom {
    NSAssert(delegate && zoom > 0, @"delegate should not be nil and zoom level should greater 0");
    
    self = [super init];
    if (!self)  return nil;
    
    _delegate = delegate;
    _tileZoom = zoom;
    _core = [CLLocationManager new];
    _core.delegate = self;
    _monitoringRange = ADLocationManagerMonitoringRangeInvalid();
    return self;
}

- (void)setMonitoringRange:(ADLocationManagerMonitoringRange)monitoringRange {
    if (ADLocationManagerMonitoringRangeIsEqualsToRange(_monitoringRange, monitoringRange)) return;
    _monitoringRange = monitoringRange;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ad_locationManager:didChangedMonitoringRange:)]) {
        [self.delegate ad_locationManager:self didChangedMonitoringRange:monitoringRange];
    }
    
    [self updateMonitoringTilesWithCurrentLocation];
}

- (void)setMonitoringTiles:(ADTileCollection *)monitoringTiles {
    if ((!_monitoringTiles && !monitoringTiles) ||
        [_monitoringTiles isEqual:monitoringTiles]) return;
    
    ADTileCollection *previous = _monitoringTiles;
    _monitoringTiles = monitoringTiles;
    
    if ([self.delegate respondsToSelector:@selector(ad_locationManager:didChangeMonitoringTilesCollectionFrom:to:)]) {
        [self.delegate ad_locationManager:self didChangeMonitoringTilesCollectionFrom:previous to:monitoringTiles];
    }
    
    if (!previous) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(ad_locationManager:didStopMonitoringTilesWithTileCodes:)]) {
            [self.delegate ad_locationManager:self didStartMonitoringTilesWithTileCodes:monitoringTiles.tileCodes];
        }
    } else if (!monitoringTiles) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(ad_locationManager:didStopMonitoringTilesWithTileCodes:)]) {
            [self.delegate ad_locationManager:self didStopMonitoringTilesWithTileCodes:previous.tileCodes];
        }
    } else {
        NSArray <NSString *> *intersectTiles = previous.intersect(monitoringTiles);
        if (![intersectTiles count]) {
            if ([self.delegate respondsToSelector:@selector(ad_locationManager:didStopMonitoringTilesWithTileCodes:)]) {
                [self.delegate ad_locationManager:self didStopMonitoringTilesWithTileCodes:previous.tileCodes];
            }
            
            if ([self.delegate respondsToSelector:@selector(ad_locationManager:didStartMonitoringTilesWithTileCodes:)]) {
                [self.delegate ad_locationManager:self didStartMonitoringTilesWithTileCodes:monitoringTiles.tileCodes];
            }
            
            return;
        }
        
        NSArray *stopped = previous.minus(intersectTiles);
        NSArray *started = monitoringTiles.minus(intersectTiles);
        
        if ([self.delegate respondsToSelector:@selector(ad_locationManager:didStopMonitoringTilesWithTileCodes:)]) {
            [self.delegate ad_locationManager:self didStopMonitoringTilesWithTileCodes:stopped];
        }
        
        if ([self.delegate respondsToSelector:@selector(ad_locationManager:didStartMonitoringTilesWithTileCodes:)]) {
            [self.delegate ad_locationManager:self didStartMonitoringTilesWithTileCodes:started];
        }
    }
}

- (void)startUpdatingLocationForMonitoring {
    [_core startUpdatingLocation];
}

- (void)stopUpdatingLocationForMonitoring {
    [_core stopUpdatingLocation];
    _currentLocation = nil;
}

- (void)startMonitoringTileRegions {
    if (_monitoringStart) return;
    
    _monitoringStart = YES;
    if (!_currentLocation) return;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ad_locationManager:shouldUpdateMonitoringRangeWithLocation:)]) {
        [self.delegate ad_locationManager:self shouldUpdateMonitoringRangeWithLocation:_currentLocation];
    }
}

- (void)updateMonitoringTileRegionsWithRange:(ADLocationManagerMonitoringRange)range {
    if (!_monitoringStart) return;
    
    _monitoringRange = range;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ad_locationManager:didChangedMonitoringRange:)]) {
        [self.delegate ad_locationManager:self didChangedMonitoringRange:range];
    }
    
    [self updateMonitoringTilesWithCurrentLocation];
}

- (void)stopMonitoringTileRegions {
    if (!_monitoringStart) return;
    
    _monitoringStart = NO;
    _monitoringRange = ADLocationManagerMonitoringRangeInvalid();
    [self updateMonitoringTilesWithCurrentLocation];
}

/// Change monitoring tiles based on current location
- (void)updateMonitoringTilesWithCurrentLocation {
    if (!_currentLocation || !ADLocationManagerMonitoringRangeIsValid(_monitoringRange)) {
        if (!_monitoringTiles) return;
        self.monitoringTiles = nil;
    } else {
        if (!_monitoringTiles) {
            self.monitoringTiles = [[ADTileManager sharedManager] tileCollectionWithZoom:_tileZoom atCoordinate:_monitoringRange.center withDimension:_monitoringRange.dimension];
            return;
        }
        
        ADTileCollectionRange rang = [[ADTileManager sharedManager] tileCollectionRangeWithZoom:_tileZoom atCoordinate:_monitoringRange.center withDimension:_monitoringRange.dimension];
        if (ADTileCollectionRangeIsEqualsTo(rang, _monitoringTiles.range)) return;
        
        self.monitoringTiles = [[ADTileManager sharedManager] tileCollectionWithRange:rang];
    }
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ad_locationManager:didChangeAuthorizationStatus:)]) {
        [self.delegate ad_locationManager:self didChangeAuthorizationStatus:status];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ad_locationManager:didFailWithError:)]) {
        [self.delegate ad_locationManager:self didFailWithError:error];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ad_locationManager:didUpdateHeading:)]) {
        [self.delegate ad_locationManager:self didUpdateHeading:newHeading];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ad_locationManager:didUpdateLocations:)]) {
        [self.delegate ad_locationManager:self didUpdateLocations:locations];
    }
    
    if (!_monitoringStart) return;
    CLLocation *location = locations.lastObject;
    if (location.horizontalAccuracy < 0) return;
    
    _currentLocation = location;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ad_locationManager:shouldUpdateMonitoringRangeWithLocation:)]) {
        [self.delegate ad_locationManager:self shouldUpdateMonitoringRangeWithLocation:location];
    }
}

@end


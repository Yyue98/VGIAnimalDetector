//
//  ADContentUpdator.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "ADContentUpdator.h"
#import <MapKit/MapKit.h>
#import "ADGeometry.h"

#define MAX_SPEED   27.778

@interface ADContentUpdator ()
@property (nonatomic, weak) MGLMapView  *mapView;
@property (nonatomic, assign)   CLLocationCoordinate2D  coordinate;
@property (nonatomic, copy) NSDate  *timestamp;
@property (nonatomic, copy) NSDate  *lastUpdateTimestamp;
@property (nonatomic, assign)   CLLocationSpeed panSpeed;
@property (nonatomic, assign)   double  zoomLevel;
@end

@implementation ADContentUpdator

- (void)addToMapView:(MGLMapView *)mapView {
    if (_mapView) return;
    
    _mapView = mapView;
}

- (void)regionWillChangeWithReason:(MGLCameraChangeReason)resion {
    _coordinate = _mapView.centerCoordinate;
    _timestamp = [NSDate date];
    _lastUpdateTimestamp = [NSDate date];
    _panSpeed = 0;
    _zoomLevel = floor(_mapView.zoomLevel);
}

- (BOOL)regionIsChangingWithReason:(MGLCameraChangeReason)reason {
    return [self contentShouldUpdateWithReason:reason];
}

- (BOOL)regionDidChangeWithReason:(MGLCameraChangeReason)reason {
    return [self contentShouldUpdateWithReason:reason];
}

- (BOOL)contentShouldUpdateWithReason:(MGLCameraChangeReason)reason {
    NSDate *now = [NSDate date];
    CLLocationCoordinate2D coordinate = _mapView.centerCoordinate;
    BOOL update = NO;
    
    switch (reason) {
        case MGLCameraChangeReasonProgrammatic:
        case MGLCameraChangeReasonTransitionCancelled: {
            double zoomLevel = floor(_mapView.zoomLevel);
            BOOL significant = [self zoomLevelSignificantChanged:zoomLevel];
            
            NSTimeInterval interval = [now timeIntervalSinceDate:_timestamp];
            CLLocationDistance distance = [self panDistance:coordinate];
            NSTimeInterval since = [now timeIntervalSinceDate:_lastUpdateTimestamp];
            CLLocationSpeed speed = [self panSpeedWithDistance:distance interval:interval];
            BOOL appropriate = [self panSpeedIsAppropriate:speed interval:since distance:distance];
            
            update = appropriate || significant;
            if (update) {
                _lastUpdateTimestamp = now;
            }
            
            _panSpeed = speed;
            _zoomLevel = zoomLevel;
            _timestamp = now;
            _coordinate = coordinate;
        }
            break;
            
        case MGLCameraChangeReasonGestureZoomIn:
        case MGLCameraChangeReasonGestureZoomOut:
        case MGLCameraChangeReasonGestureOneFingerZoom: {
            double zoomLevel = floor(_mapView.zoomLevel);
            BOOL significant = [self zoomLevelSignificantChanged:zoomLevel];
            
            update = significant;
            if (update) {
                _lastUpdateTimestamp = now;
            }
            
            _zoomLevel = zoomLevel;
            _panSpeed = 0;
            _timestamp = now;
        }
            break;
            
        case MGLCameraChangeReasonGesturePan: {
            NSTimeInterval interval = [now timeIntervalSinceDate:_timestamp];
            CLLocationDistance distance = [self panDistance:coordinate];
            NSTimeInterval since = [now timeIntervalSinceDate:_lastUpdateTimestamp];
            CLLocationSpeed speed = [self panSpeedWithDistance:distance interval:interval];
            
//            NSLog(@"speed: %@->%@", @(_panSpeed), @(speed));
            update = [self panSpeedIsAppropriate:speed interval:since distance:distance];
            if (update) {
                _lastUpdateTimestamp = now;
            }
            
            _panSpeed = speed;
            _timestamp = now;
            _coordinate = coordinate;
        }
            break;
            
        default:    break;
    }
    
    return update;
}

- (CLLocationDistance)panDistance:(CLLocationCoordinate2D)coordinate {
    return ADMetersBetweenMapCoordinates(_coordinate, coordinate);
}

- (CLLocationSpeed)panSpeedWithDistance:(CLLocationDistance)distance interval:(NSTimeInterval)interval {
    return distance / interval;
}

- (BOOL)panSpeedIsAppropriate:(CLLocationSpeed)speed interval:(NSTimeInterval)interval distance:(CLLocationDistance)distance {
    return speed < _panSpeed && speed < MAX_SPEED && interval > 0.10;
}

- (BOOL)zoomLevelSignificantChanged:(double)zoomLevel {
    double diff = fabs(zoomLevel - _zoomLevel);
    return diff > 0;
}

@end

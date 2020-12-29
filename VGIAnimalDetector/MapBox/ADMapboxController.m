//
//  ADMapboxController.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "ADMapboxController.h"
#import <MapboxChinaPlugin/MapboxChinaPlugin.h>
//#import "ACStyleLayerManager.h"
#import "NSPointerArray+Helper.h"
#import "ADPositioningManager.h"
#import "ADMGLLocationProvider.h"
#import "ADUserLocationAnnotationView.h"
#import "ADContentUpdator.h"
//#import "ACFeatureGenerator.h"
//#import "ADPointAnnotation.h"
//#import "ADPointAnnotationView.h"
#import "ADGeometry.h"
#import "ADMultipleDelegateContainer.h"

/// Default  parking space status  check  request interval
#define CHECKOUT_TIMER_INTERVAL 30

#define MainThreadAssert()  NSAssert([NSThread isMainThread], @"Method called using a thread other than main!")

@interface ADMapboxController () <MGLMapViewDelegate, ADPositioningManagerDelegate>
@property (nonatomic, assign)   BOOL    convertCoordinates;
@property (nonatomic, strong)   NSPointerArray  *observers;
@property (nonatomic, strong)   ADUserLocationAnnotationView    *userLocationView;
@property (nonatomic, copy) ADLocation  *location;

@end

@implementation ADMapboxController

+ (instancetype)sharedController {
    static ADMapboxController *_controller;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _controller = [ADMapboxController new];
    });
    
    return _controller;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _observers = [NSPointerArray weakObjectsPointerArray];
        _controllerType = ADMapboxControllerTypeNone;
        [[ADPositioningManager sharedManager] addNotifyObserver:self];
    }
    
    return self;
}

- (void)dealloc {
    [[ADPositioningManager sharedManager] removeNotifyObserver:self];
}

- (void)addToMapView:(MGLMapView *)mapView {
    if (_mapView) return;
    
    ADMGLLocationProvider *provider = [ADMGLLocationProvider new];
    mapView.locationManager = provider;
    mapView.delegate = self;
    
    
    _mapView = mapView;
    _locationProvider = provider;
    _convertCoordinates = NO;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnMapView:)];
    for (UIGestureRecognizer *recognizer in _mapView.gestureRecognizers) {
        if ([recognizer isKindOfClass:[UITapGestureRecognizer class]]) {
            [singleTap requireGestureRecognizerToFail:recognizer];
        }
    }
    [_mapView addGestureRecognizer:singleTap];
}

- (void)removeFromMapView {
    if ([_mapView.delegate isKindOfClass:[ADMultipleDelegate class]]) {
        ADMultipleDelegate *delegate = (ADMultipleDelegate *)_mapView.delegate;
        [[ADMultipleDelegateContainer sharedContainer] removeMultipleDelegate:delegate];
    }
    
    _locationProvider.delegate = nil;
    _locationProvider = nil;
    _mapView = nil;
    _userLocationView = nil;
    _location = nil;
    [_observers quickCompact];
}

- (void)addNotifyObserver:(id<ADMapboxControllerDelegate>)observer {
    @synchronized (self) {
        if ([_observers containsObject:observer]) return;
        [_observers addPointer:(__bridge void *)observer];
        [_observers compact];
    }
}

- (void)removeNotifyObserver:(id<ADMapboxControllerDelegate>)observer {
    @synchronized (self) {
        if (![_observers containsObject:observer]) return;
        [_observers removeObject:observer];
        [_observers quickCompact];
    }
}

- (void)centerUserLocationWithPitch:(double)pitch
                            heading:(double)heading
                           animated:(BOOL)animated
                         completion:(void (^)(void))completion {
    MainThreadAssert();
    [self centerCoordinate:_location.coordinate
                 zoomLevel:_mapView.zoomLevel
                  animated:animated
                completion:completion];
}

- (void)centerCoordinate:(CLLocationCoordinate2D)coordinate
               zoomLevel:(double)zoomLevel
                animated:(BOOL)animated
              completion:(void (^)(void))completion {
    [self centerCoordinate:coordinate
                     pitch:_mapView.camera.pitch
                 zoomLevel:zoomLevel
                   heading:_mapView.camera.heading
                  animated:animated
                completion:completion];
}

- (void)centerCoordinate:(CLLocationCoordinate2D)coordinate
                   pitch:(double)pitch
               zoomLevel:(double)zoomLevel
                 heading:(CLLocationDegrees)heading
                animated:(BOOL)animated
              completion:(void (^)(void))completion {
    MainThreadAssert();
    double altitude = MGLAltitudeForZoomLevel(zoomLevel, 0, coordinate.latitude, _mapView.bounds.size);
    MGLMapCamera *camera = [MGLMapCamera cameraLookingAtCenterCoordinate:coordinate
                                                                altitude:altitude
                                                                   pitch:pitch
                                                                 heading:heading];
    [_mapView setUserTrackingMode:MGLUserTrackingModeNone];
    [_mapView flyToCamera:camera withDuration:0.5 completionHandler:nil];
}

- (BOOL)isAcuteAngleFrom:(CLLocationDegrees)from to:(CLLocationDegrees)to {
    CLLocationDegrees minus = fabs(from - to);
    BOOL acuteAngle = NO;
    if (minus < 90) {
        acuteAngle = YES;
    }
    
    return acuteAngle;
}

- (CLLocationDegrees)negativeAngleFor:(CLLocationDegrees)angle {
    CGFloat negative = angle + 180;
    if (negative > 360) {
        negative -= 360;
    }
    
    return negative;
}

- (void)handleTapOnMapView:(UIGestureRecognizer *)gesture {
    CGPoint spot = [gesture locationInView:_mapView];
//    NSPointerArray *observers = [self.observers copy];
//    for (id <ADMapboxControllerDelegate> observer in observers) {
//        if ([observer respondsToSelector:@selector(mapboxController:didSelectBuildingPOIFeature:)]) {
//            [observer mapboxController:self didSelectBuildingPOIFeature:feature];
//        }
//    }
}

#pragma mark - MGLMapViewDelegate
- (void)mapViewDidFinishLoadingMap:(MGLMapView *)mapView {
    mapView.showsUserLocation = YES;
    mapView.showsUserHeadingIndicator = YES;
    
    [_locationProvider switchUpdatingLocationInBackground:NO];
    
//    [[ACStyleLayerManager sharedManager] addToMapView:mapView withBaseLayer:mapView.style.layers.lastObject];
    
//    _poiManager = [ADPOIManager new];
//    _poiManager.delegate = self;
//    [_poiManager addToMapView:mapView convertCoordinates:_convertCoordinates];
    

    
    NSPointerArray *observers = [self.observers copy];
    for (id <ADMapboxControllerDelegate> observer in observers) {
        if ([observer respondsToSelector:@selector(mapboxController:didFinishLoadingMap:)]) {
            [observer mapboxController:self didFinishLoadingMap:mapView];
        }
    }
}

- (MGLAnnotationView *)mapView:(MGLMapView *)mapView viewForAnnotation:(id<MGLAnnotation>)annotation {
    if ([annotation isKindOfClass:[MGLUserLocation class]]) {
        ADUserLocationAnnotationView *view = [ADUserLocationAnnotationView new];
        view.state = ADUserLocationStateNormal;
        _userLocationView = view;
        return view;
    }
    
    return nil;
}

- (void)mapView:(MGLMapView *)mapView didSelectAnnotation:(id<MGLAnnotation>)annotation {
    if ([annotation isKindOfClass:[MGLUserLocation class]]) {
        [mapView setUserTrackingMode:MGLUserTrackingModeFollow animated:YES completionHandler:nil];
    }
}

- (void)mapView:(MGLMapView *)mapView didChangeUserTrackingMode:(MGLUserTrackingMode)mode animated:(BOOL)animated {
    NSPointerArray *observers = [self.observers copy];
    for (id <ADMapboxControllerDelegate> observer in observers) {
        if ([observer respondsToSelector:@selector(mapboxController:didChangeUserTrackingMode:animated:)]) {
            [observer mapboxController:self didChangeUserTrackingMode:mode animated:animated];
        }
    }
}

#pragma mark - ADPOIManagerDelegate
//- (void)poiManager:(ADPOIManager *)manager didSelectPointFeature:(MGLPointFeature *)feature {
//    NSString *pointID = [NSString stringWithFormat:@"%@", [feature attributeForKey:@"Id"]];
//    if (!pointID || ![pointID length]) return;
//
//    for (id <ADMapboxControllerDelegate> observer in _observers) {
//        if ([observer respondsToSelector:@selector(mapboxController:didSelectPOIWithIdentifier:)]) {
//            [observer mapboxController:self didSelectPOIWithIdentifier:pointID];
//        }
//    }
//}

#pragma mark - ADPositioningManagerDelegate
- (void)positioningManager:(ADPositioningManager *)manager didUpdateLocation:(ADLocation *)location {
    _location = location;
    
}

@end

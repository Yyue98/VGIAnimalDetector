//
//  ADMapboxController.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>
//#import "ACPOIManager.h"
#import "ADMGLLocationProvider.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ADMapboxControllerType) {
    ADMapboxControllerTypeNone,
    ADMapboxControllerTypeReview,
    ADMapboxControllerTypeDirection,
    ADMapboxControllerTypeNavigation
};

@class ADMapboxController;
@protocol ADMapboxControllerDelegate <NSObject>
@optional

- (void)mapboxController:(ADMapboxController *)controller didFinishLoadingMap:(MGLMapView *)mapView;
- (void)mapboxController:(ADMapboxController *)controller didChangeUserTrackingMode:(MGLUserTrackingMode)mode animated:(BOOL)animated;
- (void)mapboxController:(ADMapboxController *)controller didSelectOutdoorPOIFeature:(MGLPointFeature *)feature;


@end

@interface ADMapboxController : NSObject

@property (nonatomic, readonly, weak) MGLMapView  *mapView;
@property (nonatomic, readonly) ADMGLLocationProvider   *locationProvider;
//@property (nonatomic, readonly) ACPOIManager    *poiManager;
@property (nonatomic, assign)   ADMapboxControllerType  controllerType;

+ (instancetype)sharedController;
- (void)addToMapView:(MGLMapView *)mapView;
- (void)removeFromMapView;
- (void)addNotifyObserver:(id <ADMapboxControllerDelegate>)observer;
- (void)removeNotifyObserver:(id <ADMapboxControllerDelegate>)observer;
- (void)centerCoordinate:(CLLocationCoordinate2D)coordinate zoomLevel:(double)zoomLevel animated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;
- (void)centerUserLocationWithPitch:(double)pitch heading:(double)heading animated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END

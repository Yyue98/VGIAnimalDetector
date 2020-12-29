//
//  ADContentUpdator.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADContentUpdator : NSObject

- (void)addToMapView:(MGLMapView *)mapView;
- (void)regionWillChangeWithReason:(MGLCameraChangeReason)resion;
- (BOOL)regionIsChangingWithReason:(MGLCameraChangeReason)reason;
- (BOOL)regionDidChangeWithReason:(MGLCameraChangeReason)reason;

@end

NS_ASSUME_NONNULL_END

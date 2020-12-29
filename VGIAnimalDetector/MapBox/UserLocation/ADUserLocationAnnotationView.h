//
//  ADUserLocationAnnotationView.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import <Mapbox/Mapbox.h>
#import <Mapbox/Mapbox.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ADUserLocationState) {
    ADUserLocationStateUnknown              = 0,
    ADUserLocationStateNormal               = 1,
    ADUserLocationStateConfidence           = 2,
    ADUserLocationStateDisabled             = 3,
    ADUserLocationStateNavigation           = 4,
    ADUserLocationStateNavigationDisabled   = 5
};

@interface ADUserLocationAnnotationView : MGLUserLocationAnnotationView

@property (nonatomic, assign)   ADUserLocationState state;
@property (nonatomic, assign)   BOOL    ignoreUserLocationHeading;

- (void)updateDirectionWithNavigationHeading:(CLLocationDirection)heading;

@end

NS_ASSUME_NONNULL_END

//
//  SPUserLocationButton.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//
#import <QMUIKit/QMUIKit.h>
#import <Mapbox/Mapbox.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SPUserLocationButtonMode) {
    SPUserLocationButtonModeNone = MGLUserTrackingModeNone,
    SPUserLocationButtonModeFollow = MGLUserTrackingModeFollow,
    SPUserLocationButtonModeFollowWithHeading = MGLUserTrackingModeFollowWithHeading,
    SPUserLocationButtonModeFollowRouteBearing = 3,
    SPUserLocationButtonModeReviewNavigationContent = 4
};

@interface SPUserLocationButton : QMUIFillButton

@property (nonatomic, assign)   SPUserLocationButtonMode buttonMode;

- (instancetype)initWithButtonMode:(SPUserLocationButtonMode)mode;

@end

NS_ASSUME_NONNULL_END

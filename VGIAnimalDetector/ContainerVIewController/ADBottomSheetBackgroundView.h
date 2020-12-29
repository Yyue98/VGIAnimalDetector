//
//  ADBottomSheetBackgroundView.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>
#import "ADBottomSheetHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADBottomSheetBackgroundView : UIView

/// Header view above the bottom sheet viewController
@property (nonatomic, strong)   ADBottomSheetHeader *headerView;

/// Content view for bottom sheet content
@property (nonatomic, readonly, weak)   UIView  *contentView;

/// Hide background shadow layer
@property (nonatomic, readonly, assign) BOOL    hideShadow;

/// Initialize bottom sheet background view with height and corner radius
/// @param height Header view height
/// @param cornerRadius Upper corner radius
- (instancetype)initWithHeaderHeight:(CGFloat)height upperCornerRadius:(CGFloat)cornerRadius hideShadow:(BOOL)hide;

/// Layout content view on bottom sheet background view
/// @param view View to layout
- (void)layoutContentView:(UIView *)view;

/// Remove content view from background view
- (void)removeContentView;

/// Fade out shadow or not
/// @param fade Fade out or not
- (void)fadeOutShadow:(BOOL)fade;
@end

NS_ASSUME_NONNULL_END

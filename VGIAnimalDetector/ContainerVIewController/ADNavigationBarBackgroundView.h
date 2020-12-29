//
//  ADNavigationBarBackgroundView.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADNavigationBarBackgroundView : UIView

/// Layout view as content view on background
/// @param view View to layout
- (void)layoutContentView:(UIView *)view;

/// Remove content view from baackground
- (void)removeContentView;

@end

NS_ASSUME_NONNULL_END

//
//  UIView+ACEffectView.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//
#import <UIKit/UIKit.h>
#import "ACEffectView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ACEffectView)

- (void)addBlurEffectWithStyle:(UIBlurEffectStyle)style;
- (ACEffectView *)effectView;

@end

NS_ASSUME_NONNULL_END

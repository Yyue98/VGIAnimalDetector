//
//  UIView+Shadow.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import <UIKit/UIKit.h>
#import "ACShadowView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Shadow)

- (void)addShadowWithCornerRadius:(double)radius;
- (void)addShadowWithCornerRadius:(double)radius contentInsets:(UIEdgeInsets)insets;
- (UIView *)layoutView;

@end

NS_ASSUME_NONNULL_END

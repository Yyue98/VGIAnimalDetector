//
//  ADBottomSheetHeader.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADBottomSheetHeader : UIView
// Stroke color for arrow
@property (nonatomic, strong)   UIColor *strokeColor;

/// Stroke line width for arrow
@property (nonatomic, assign)   NSInteger   strokeWidth;

/// Indicates arrow is in curved state
@property (nonatomic, readonly) BOOL    isCurvedArrow;

/// Initialize container header with arror curve setting
/// @param curve Default state of arrow
- (instancetype)initWithCurveArror:(BOOL)curve;

/// Update arrow curve with animation
/// @param curve Curve the arror
/// @param animated Update with animation or not
- (void)setCurveArrow:(BOOL)curve animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END

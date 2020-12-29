//
//  ACShadowView.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import <UIKit/UIKit.h>

@interface ACShadowView : UIView

/// Content view for display
@property (nonatomic, weak) UIView  *contentView;

/// Content view layout insets
@property (nonatomic, assign)   UIEdgeInsets    contentEdgeInsets;

/// Content view corners for adding round radius
@property (nonatomic, assign)   UIRectCorner    corners;

/// Initialize shadow view with settings of shadow
/// @param cornerRadius Content corner radius
/// @param color Shadow color
/// @param offset Shadow offset
/// @param opacity Shadow opacity
/// @param radius Shadow radius
/// @param contentView Content view
- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius
                         shadowColor:(UIColor *)color
                        shadowOffset:(CGSize)offset
                       shadowOpacity:(CGFloat)opacity
                        shadowRadius:(CGFloat)radius
                         contentView:(UIView *)contentView;

@end

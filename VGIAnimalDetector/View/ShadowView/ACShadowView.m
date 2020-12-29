//
//  ACShadowView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "ACShadowView.h"

@interface ACShadowView ()

/// Corner radius for content view
@property (nonatomic, assign)   CGFloat contentRadius;

@end

@implementation ACShadowView

- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius
                         shadowColor:(UIColor *)color
                        shadowOffset:(CGSize)offset
                       shadowOpacity:(CGFloat)opacity
                        shadowRadius:(CGFloat)radius
                         contentView:(UIView *)contentView
{
    self = [super init];
    if (self) {
        _contentRadius = cornerRadius;
        
        self.contentView = contentView;
        [self addSubview:contentView];
        
        self.layer.shadowColor = color.CGColor;
        self.layer.shadowOffset = offset;
        self.layer.shadowOpacity = opacity;
        self.layer.shadowRadius = radius;
        
        _contentEdgeInsets = UIEdgeInsetsZero;
        _corners = UIRectCornerAllCorners;
    }
    
    return self;
}

- (void)setCorners:(UIRectCorner)corners {
    if (_corners == corners) return;
    
    _corners = corners;
    [self setNeedsLayout];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    if (UIEdgeInsetsEqualToEdgeInsets(_contentEdgeInsets, contentEdgeInsets)) return;
    
    _contentEdgeInsets = contentEdgeInsets;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _contentView.frame = UIEdgeInsetsInsetRect(self.bounds, _contentEdgeInsets);
    
    if (_contentRadius == 0) return;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds
                                               byRoundingCorners:_corners
                                                     cornerRadii:CGSizeMake(_contentRadius, _contentRadius)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    _contentView.layer.mask = layer;
    
    if (_corners == UIRectCornerAllCorners) return;
    
    self.layer.shadowPath = path.CGPath;
}

@end

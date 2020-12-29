//
//  ADBottomSheetBackgroundView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADBottomSheetBackgroundView.h"

@interface ADBottomSheetBackgroundView ()

/// Header view height
@property (nonatomic, assign)   CGFloat headerHeight;

/// Upper corner radius
@property (nonatomic, assign)   CGFloat cornerRadius;

/// Shadow background view
@property (nonatomic, strong)   UIView  *backgroundView;

@end

@implementation ADBottomSheetBackgroundView

- (instancetype)initWithHeaderHeight:(CGFloat)height upperCornerRadius:(CGFloat)cornerRadius hideShadow:(BOOL)hide {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _hideShadow = hide;
        
        _backgroundView = [UIView new];
        [self addSubview:_backgroundView];
        
        _headerHeight = height;
        _cornerRadius = cornerRadius;
        
        _headerView = [[ADBottomSheetHeader alloc] initWithCurveArror:NO];
        [_backgroundView addSubview:_headerView];
    }
    
    return self;
}

- (void)layoutContentView:(UIView *)view {
    _contentView = view;
    [self addSubview:_contentView];
    [self setNeedsLayout];
}

- (void)removeContentView {
    if (_contentView) {
        [_contentView removeFromSuperview];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backgroundView.frame = self.bounds;
    _headerView.frame = CGRectMake(0,
                                   0,
                                   CGRectGetWidth(_backgroundView.bounds),
                                   _headerHeight);
    
    if (_contentView)
    {
        _contentView.frame = CGRectMake(0,
                             _headerHeight,
                             CGRectGetWidth(self.bounds),
                             CGRectGetHeight(self.bounds) - _headerHeight);
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
    [self applyUpperCorners:path];
    
    if (!_hideShadow) {
        [self applyShaddow:path];
    }
}

/// Add upper corner radius to background view
/// @param path Upper bezier path
- (void)applyUpperCorners:(UIBezierPath *)path {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    _backgroundView.layer.mask = shapeLayer;
}

/// Add shadow to view
/// @param path Shdow bezier path
- (void)applyShaddow:(UIBezierPath *)path {
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, -2);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 4.0;
    self.layer.shadowPath = path.CGPath;
}

- (void)fadeOutShadow:(BOOL)fade {
    if (_hideShadow) return;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    anim.fromValue = fade ? @0.4 : @0;
    anim.toValue = fade ? @0 : @0.4;
    [self.layer addAnimation:anim forKey:@"shadowOpacity"];
    self.layer.shadowOpacity = fade ? 0 : 0.4;
}

@end


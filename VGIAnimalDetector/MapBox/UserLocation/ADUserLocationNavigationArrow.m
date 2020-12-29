//
//  ADUserLocationNavigationArrow.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/9.
//

#import "ADUserLocationNavigationArrow.h"


@interface ADUserLocationNavigationArrow ()
@property (nonatomic, assign)   CGFloat size;
@property (nonatomic, strong)   UIView *dot;
@property (nonatomic, strong)   CAShapeLayer    *arrow;
@end

@implementation ADUserLocationNavigationArrow

- (instancetype)initWithSize:(CGFloat)size {
    self = [super init];
    if (self) {
        _size = size;
        
        _dot = [UIView new];
        _dot.frame = CGRectMake(0, 0, size, size);
        _dot.layer.cornerRadius = size / 2;
        _dot.layer.borderWidth = 4;
        _dot.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:_dot];

        _arrow = [CAShapeLayer layer];
        _arrow.path = [self navigationArrowPath];
        _arrow.frame = CGRectMake(0, 0, size / 2, size / 2);
        _arrow.fillColor = [UIColor whiteColor].CGColor;
        [self.dot.layer addSublayer:_arrow];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _dot.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _arrow.position = CGPointMake(CGRectGetMidX(_dot.frame), CGRectGetMidY(_dot.frame));
}

- (CGPathRef)navigationArrowPath {
    CGFloat max = _size / 2;
    CGFloat pad = 3;
    
    CGPoint top =    CGPointMake(max * 0.5, 0);
    CGPoint left =   CGPointMake(0 + pad,   max - pad);
    CGPoint right =  CGPointMake(max - pad, max - pad);
    CGPoint center = CGPointMake(max * 0.5, max * 0.6);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:top];
    [bezierPath addLineToPoint:left];
    [bezierPath addLineToPoint:center];
    [bezierPath addLineToPoint:right];
    [bezierPath addLineToPoint:top];
    [bezierPath closePath];
    
    return bezierPath.CGPath;
}

- (void)setRotation:(CGAffineTransform)rotation {
    _arrow.affineTransform = rotation;
}

- (void)setStyleColor:(nonnull UIColor *)color {
    _dot.backgroundColor = color;
}

- (void)showHeadingIndicator:(BOOL)show {
    _arrow.hidden = !show;
}

- (CGFloat)size {
    return _size;
}

@end

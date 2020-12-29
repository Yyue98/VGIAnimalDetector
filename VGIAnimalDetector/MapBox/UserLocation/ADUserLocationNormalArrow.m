//
//  ADUserLocationNormalArrow.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/9.
//

#import "ADUserLocationNormalArrow.h"


@interface ADUserLocationNormalArrow ()
@property (nonatomic, assign)   CGFloat size;
@property (nonatomic, assign)   CGFloat dotSize;
@property (nonatomic, assign)   CGFloat arrowSize;
@property (nonatomic, strong)   UIView *dot;
@property (nonatomic, strong)   CAShapeLayer    *arrow;
@property (nonatomic, strong)   CAShapeLayer    *arrorBorderLayer;
@end

@implementation ADUserLocationNormalArrow

- (instancetype)initWithSize:(CGFloat)size {
    self = [super init];
    if (self) {
        _size = size;
        _dotSize = size - 24;
        _arrowSize = size - 6;
        
        _arrorBorderLayer = [CAShapeLayer layer];
        _arrorBorderLayer.path = [self arrowPathWithBorder:YES];
        _arrorBorderLayer.frame = CGRectMake(0, 0, _arrowSize, _arrowSize);
        _arrorBorderLayer.fillColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_arrorBorderLayer];
        
        _arrow = [CAShapeLayer layer];
        _arrow.path = [self arrowPathWithBorder:NO];
        _arrow.frame = CGRectMake(0, 0, _arrowSize, _arrowSize);
        [self.layer addSublayer:_arrow];
        
        _dot = [UIView new];
        _dot.frame = CGRectMake(0, 0, _dotSize, _dotSize);
        _dot.layer.cornerRadius = _dotSize / 2;
        _dot.layer.borderWidth = 4;
        _dot.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:_dot];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _dot.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _arrorBorderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _arrow.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)setRotation:(CGAffineTransform)rotation {
    _arrorBorderLayer.affineTransform = rotation;
    _arrow.affineTransform = rotation;
}

- (void)setStyleColor:(nonnull UIColor *)color {
    _dot.backgroundColor = color;
    _arrow.fillColor = color.CGColor;
}

- (void)showHeadingIndicator:(BOOL)show {
    _arrorBorderLayer.hidden = !show;
    _arrow.hidden = !show;
}

- (CGFloat)size {
    return _size;
}

- (CGPathRef)arrowPathWithBorder:(BOOL)border {
    CGFloat max = _arrowSize;
    CGFloat pad = border ? 10 : 11;
    CGFloat height = border ? 2 : 4;

    CGPoint top =    CGPointMake(max * 0.5, height);
    CGPoint left =   CGPointMake(pad, max * 0.4);
    CGPoint right =  CGPointMake(max - pad, max * 0.4);

    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:top];
    [bezierPath addLineToPoint:left];
    [bezierPath addLineToPoint:right];
    [bezierPath addLineToPoint:top];
    [bezierPath closePath];

    return bezierPath.CGPath;
}


@end

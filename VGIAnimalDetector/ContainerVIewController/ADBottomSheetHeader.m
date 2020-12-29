//
//  ADBottomSheetHeader.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADBottomSheetHeader.h"

@interface ADBottomSheetHeader ()

/// Curve arrow record
@property (nonatomic, assign)   BOOL    curveArrow;

///Arrow shape layer
@property (nonatomic, strong)   CAShapeLayer    *shapeLayer;

@end

@implementation ADBottomSheetHeader

- (instancetype)initWithCurveArror:(BOOL)curve {
    self = [super init];
    if (self) {
        _curveArrow = curve;
        [self setupShapeLayer];
    }
    
    return self;
}

/// Setup stroke shape layer
- (void)setupShapeLayer {
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_shapeLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _shapeLayer.frame = self.bounds;
    [self setCurveArrow:_curveArrow animated:NO];
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    self.shapeLayer.strokeColor = strokeColor.CGColor;
}

- (void)setStrokeWidth:(NSInteger)strokeWidth {
    _strokeWidth = strokeWidth;
    self.shapeLayer.lineWidth = strokeWidth;
}

- (void)setCurveArrow:(BOOL)curve animated:(BOOL)animated {
    _curveArrow = curve;
    
    UIBezierPath *arrowPath = [self arrowPathWithCurve:curve];
    NSString *keyPath = @"path";
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = (id)self.shapeLayer.path;
    self.shapeLayer.path = arrowPath.CGPath;
    animation.toValue = (id)self.shapeLayer.path;
    animation.duration = animated ? 0.5 : 0.0;
    [self.shapeLayer addAnimation:animation forKey:keyPath];
}

- (BOOL)isCurveArrow {
    return _curveArrow;
}

/// Bezier path for curve arrow or straight arrow
/// @param curve Curve path or not
- (UIBezierPath *)arrowPathWithCurve:(BOOL)curve {
    CGFloat offsetMultiplier = curve ? 0.7 : 0.0;
    CGSize arrowSize = CGSizeMake(30.0, 5.0);
    CGSize arrowADan = CGSizeMake(arrowSize.width / 2.0, arrowSize.height / 2.0);
    
    CGFloat centerY = CGRectGetMidY(self.bounds) + offsetMultiplier * arrowSize.height / 2.0;
    CGFloat centerX = CGRectGetMidX(self.bounds);
    CGFloat wingsY = centerY - offsetMultiplier * arrowSize.height;
    
    CGPoint center = CGPointMake(centerX, centerY);
    CGPoint centerRight = CGPointMake(centerX + arrowADan.width, wingsY);
    CGPoint centerLeft = CGPointMake(centerX - arrowADan.width, wingsY);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:centerLeft];
    [bezierPath addLineToPoint:center];
    [bezierPath addLineToPoint:centerRight];
    return bezierPath;
}

@end


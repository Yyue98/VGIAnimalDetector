// Copyright (c) 2020 mrcrow <wwz.michael@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "ACStatusIconErrorView.h"

@implementation ACStatusIconErrorView

- (void)animate {
    [self animateTopToBottomLine];
    [self animateBottomToTopLine];
}
    
- (void)animateTopToBottomLine {
    CGFloat length = CGRectGetWidth(self.frame);
    
    UIBezierPath *topToBottomLine = [UIBezierPath bezierPath];
    [topToBottomLine moveToPoint:CGPointMake(0, 0)];
    [topToBottomLine addLineToPoint:CGPointMake(length, length)];
    
    CAShapeLayer *animatableLayer = [CAShapeLayer layer];
    animatableLayer.path = topToBottomLine.CGPath;
    animatableLayer.fillColor = [UIColor clearColor].CGColor;
    animatableLayer.strokeColor = self.tintColor.CGColor;
    animatableLayer.lineWidth = 9;
    animatableLayer.lineCap = kCALineCapRound;
    animatableLayer.lineJoin = kCALineJoinRound;
    animatableLayer.strokeEnd = 0;
    [self.layer addSublayer:animatableLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.22;
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animatableLayer.strokeEnd = 1;
    [animatableLayer addAnimation:animation forKey:@"animation"];
}
    
- (void)animateBottomToTopLine {
    CGFloat length = CGRectGetWidth(self.frame);
    
    UIBezierPath *bottomToTopLine = [UIBezierPath bezierPath];
    [bottomToTopLine moveToPoint:CGPointMake(0, length)];
    [bottomToTopLine addLineToPoint:CGPointMake(length, 0)];
    
    CAShapeLayer *animatableLayer = [CAShapeLayer layer];
    animatableLayer.path = bottomToTopLine.CGPath;
    animatableLayer.fillColor = [UIColor clearColor].CGColor;
    animatableLayer.strokeColor = self.tintColor.CGColor;
    animatableLayer.lineWidth = 9;
    animatableLayer.lineCap = kCALineCapRound;
    animatableLayer.lineJoin = kCALineJoinRound;
    animatableLayer.strokeEnd = 0;
    [self.layer addSublayer:animatableLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.22;
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animatableLayer.strokeEnd = 1;
    [animatableLayer addAnimation:animation forKey:@"animation"];
}

@end

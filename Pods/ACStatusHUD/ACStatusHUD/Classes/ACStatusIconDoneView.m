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


#import "ACStatusIconDoneView.h"

@implementation ACStatusIconDoneView

- (void)animate {
    CGFloat length = CGRectGetWidth(self.frame);
    UIBezierPath *animatablePath = [UIBezierPath bezierPath];
    [animatablePath moveToPoint:CGPointMake(length * 0.196, length * 0.527)];
    [animatablePath addLineToPoint:CGPointMake(length * 0.47, length * 0.777)];
    [animatablePath addLineToPoint:CGPointMake(length * 0.99, length * 0.25)];
    
    CAShapeLayer *animatableLayer = [CAShapeLayer layer];
    animatableLayer.path = animatablePath.CGPath;
    animatableLayer.fillColor = [UIColor clearColor].CGColor;
    animatableLayer.strokeColor = self.tintColor.CGColor;
    animatableLayer.lineWidth = 9;
    animatableLayer.lineCap = kCALineCapRound;
    animatableLayer.lineJoin = kCALineJoinRound;
    animatableLayer.strokeEnd = 0;
    [self.layer addSublayer:animatableLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.3;
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animatableLayer.strokeEnd = 1;
    [animatableLayer addAnimation:animation forKey:@"animation"];
}

@end

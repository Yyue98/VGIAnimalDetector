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


#import "ACStatusIconLoadingView.h"

@implementation ACStatusIconLoadingView

- (void)animate {
    [self animateRingInfiniteRotation];
}

- (void)animateRingInfiniteRotation {
    CGFloat length = CGRectGetWidth(self.frame);
    
    UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(length * 0.5, length * 0.5) radius:length * 0.5 startAngle:0.1 * M_PI endAngle:1.9 * M_PI clockwise:YES];
    
    CAShapeLayer *animatableLayer = [CAShapeLayer layer];
    animatableLayer.frame = self.bounds;
    animatableLayer.anchorPoint = CGPointMake(0.5, 0.5);
    animatableLayer.path = circle.CGPath;
    animatableLayer.fillColor = [UIColor clearColor].CGColor;
    animatableLayer.strokeColor = self.tintColor.CGColor;
    animatableLayer.lineWidth = 6;
    animatableLayer.lineCap = kCALineCapRound;
    animatableLayer.lineJoin = kCALineJoinRound;
    animatableLayer.strokeEnd = 1;
    [self.layer addSublayer:animatableLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.duration = 1;
    animation.cumulative = YES;
    animation.repeatCount = HUGE_VALF;
    [animatableLayer addAnimation:animation forKey:@"animation"];
}

@end

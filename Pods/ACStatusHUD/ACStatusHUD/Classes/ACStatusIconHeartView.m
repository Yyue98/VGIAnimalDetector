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


#import "ACStatusIconHeartView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconHeartView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconHeartView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 510, 470) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 510.0, CGRectGetHeight(resizedFrame) / 470.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(255, 469.6)];
    [bezierPath addLineToPoint:CGPointMake(219.3, 433.9)];
    [bezierPath addCurveToPoint:CGPointMake(0, 140.65) controlPoint1:CGPointMake(86.7, 316.6) controlPoint2:CGPointMake(0, 237.55)];
    [bezierPath addCurveToPoint:CGPointMake(140.25, 0.4) controlPoint1:CGPointMake(0, 61.6) controlPoint2:CGPointMake(61.2, 0.4)];
    [bezierPath addCurveToPoint:CGPointMake(255, 53.95) controlPoint1:CGPointMake(183.6, 0.4) controlPoint2:CGPointMake(226.95, 20.8)];
    [bezierPath addCurveToPoint:CGPointMake(369.75, 0.4) controlPoint1:CGPointMake(283.05, 20.8) controlPoint2:CGPointMake(326.4, 0.4)];
    [bezierPath addCurveToPoint:CGPointMake(510, 140.65) controlPoint1:CGPointMake(448.8, 0.4) controlPoint2:CGPointMake(510, 61.6)];
    [bezierPath addCurveToPoint:CGPointMake(290.7, 433.9) controlPoint1:CGPointMake(510, 237.55) controlPoint2:CGPointMake(423.3, 316.6)];
    [bezierPath addLineToPoint:CGPointMake(255, 469.6)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

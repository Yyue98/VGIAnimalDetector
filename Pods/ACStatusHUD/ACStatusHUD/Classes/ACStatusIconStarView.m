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


#import "ACStatusIconStarView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconStarView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconStarView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 65, 65) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 65.0, CGRectGetHeight(resizedFrame) / 65.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(12.85, 61.49)];
    [bezierPath addCurveToPoint:CGPointMake(12.06, 57.48) controlPoint1:CGPointMake(11.76, 60.67) controlPoint2:CGPointMake(11.48, 59.34)];
    [bezierPath addLineToPoint:CGPointMake(17.96, 39.89)];
    [bezierPath addLineToPoint:CGPointMake(3.12, 29.24)];
    [bezierPath addCurveToPoint:CGPointMake(1.14, 25.35) controlPoint1:CGPointMake(1.39, 28.02) controlPoint2:CGPointMake(0.67, 26.71)];
    [bezierPath addCurveToPoint:CGPointMake(5.03, 23.35) controlPoint1:CGPointMake(1.59, 23.99) controlPoint2:CGPointMake(2.89, 23.32)];
    [bezierPath addLineToPoint:CGPointMake(23.24, 23.49)];
    [bezierPath addLineToPoint:CGPointMake(28.77, 6.09)];
    [bezierPath addCurveToPoint:CGPointMake(31.86, 3) controlPoint1:CGPointMake(29.44, 4.06) controlPoint2:CGPointMake(30.44, 3)];
    [bezierPath addCurveToPoint:CGPointMake(34.97, 6.09) controlPoint1:CGPointMake(33.31, 3) controlPoint2:CGPointMake(34.31, 4.06)];
    [bezierPath addLineToPoint:CGPointMake(40.51, 23.49)];
    [bezierPath addLineToPoint:CGPointMake(58.71, 23.35)];
    [bezierPath addCurveToPoint:CGPointMake(62.61, 25.35) controlPoint1:CGPointMake(60.85, 23.32) controlPoint2:CGPointMake(62.16, 23.99)];
    [bezierPath addCurveToPoint:CGPointMake(60.63, 29.24) controlPoint1:CGPointMake(63.05, 26.71) controlPoint2:CGPointMake(62.36, 28.02)];
    [bezierPath addLineToPoint:CGPointMake(45.79, 39.89)];
    [bezierPath addLineToPoint:CGPointMake(51.6, 57.21)];
    [bezierPath addCurveToPoint:CGPointMake(50.9, 61.49) controlPoint1:CGPointMake(52.29, 59.21) controlPoint2:CGPointMake(52.04, 60.63)];
    [bezierPath addCurveToPoint:CGPointMake(46.59, 60.82) controlPoint1:CGPointMake(49.73, 62.38) controlPoint2:CGPointMake(48.32, 62.07)];
    [bezierPath addLineToPoint:CGPointMake(31.86, 50.01)];
    [bezierPath addLineToPoint:CGPointMake(17.15, 60.82)];
    [bezierPath addCurveToPoint:CGPointMake(12.85, 61.49) controlPoint1:CGPointMake(15.43, 62.07) controlPoint2:CGPointMake(13.98, 62.38)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

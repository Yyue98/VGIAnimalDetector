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


#import "ACStatusIconRepeatView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconRepeatView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconRepeatView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 73, 64) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 73.0, CGRectGetHeight(resizedFrame) / 64.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(1, 29.76)];
    [bezierPath addCurveToPoint:CGPointMake(4.49, 33.25) controlPoint1:CGPointMake(1, 31.69) controlPoint2:CGPointMake(2.56, 33.25)];
    [bezierPath addCurveToPoint:CGPointMake(7.98, 29.76) controlPoint1:CGPointMake(6.43, 33.25) controlPoint2:CGPointMake(7.98, 31.69)];
    [bezierPath addLineToPoint:CGPointMake(7.98, 27.66)];
    [bezierPath addCurveToPoint:CGPointMake(16.68, 19.28) controlPoint1:CGPointMake(7.98, 22.61) controlPoint2:CGPointMake(11.47, 19.28)];
    [bezierPath addLineToPoint:CGPointMake(40.61, 19.28)];
    [bezierPath addLineToPoint:CGPointMake(40.61, 25.92)];
    [bezierPath addCurveToPoint:CGPointMake(43.47, 28.71) controlPoint1:CGPointMake(40.61, 27.63) controlPoint2:CGPointMake(41.72, 28.71)];
    [bezierPath addCurveToPoint:CGPointMake(45.62, 27.91) controlPoint1:CGPointMake(44.23, 28.71) controlPoint2:CGPointMake(45.02, 28.42)];
    [bezierPath addLineToPoint:CGPointMake(57.62, 18.01)];
    [bezierPath addCurveToPoint:CGPointMake(57.62, 13.76) controlPoint1:CGPointMake(59.05, 16.87) controlPoint2:CGPointMake(59.02, 14.97)];
    [bezierPath addLineToPoint:CGPointMake(45.62, 3.79)];
    [bezierPath addCurveToPoint:CGPointMake(43.47, 3) controlPoint1:CGPointMake(45.02, 3.32) controlPoint2:CGPointMake(44.23, 3)];
    [bezierPath addCurveToPoint:CGPointMake(40.61, 5.82) controlPoint1:CGPointMake(41.72, 3) controlPoint2:CGPointMake(40.61, 4.11)];
    [bezierPath addLineToPoint:CGPointMake(40.61, 12.39)];
    [bezierPath addLineToPoint:CGPointMake(17.35, 12.39)];
    [bezierPath addCurveToPoint:CGPointMake(1, 27.15) controlPoint1:CGPointMake(7.35, 12.39) controlPoint2:CGPointMake(1, 18.14)];
    [bezierPath addLineToPoint:CGPointMake(1, 29.76)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(30.74, 38.26)];
    [bezierPath addLineToPoint:CGPointMake(30.74, 44.83)];
    [bezierPath addLineToPoint:CGPointMake(54.67, 44.83)];
    [bezierPath addCurveToPoint:CGPointMake(63.37, 36.45) controlPoint1:CGPointMake(59.87, 44.83) controlPoint2:CGPointMake(63.37, 41.47)];
    [bezierPath addLineToPoint:CGPointMake(63.37, 34.36)];
    [bezierPath addCurveToPoint:CGPointMake(66.86, 30.83) controlPoint1:CGPointMake(63.37, 32.39) controlPoint2:CGPointMake(64.92, 30.83)];
    [bezierPath addCurveToPoint:CGPointMake(70.35, 34.36) controlPoint1:CGPointMake(68.79, 30.83) controlPoint2:CGPointMake(70.35, 32.39)];
    [bezierPath addLineToPoint:CGPointMake(70.35, 36.96)];
    [bezierPath addCurveToPoint:CGPointMake(54, 51.72) controlPoint1:CGPointMake(70.35, 45.94) controlPoint2:CGPointMake(64, 51.72)];
    [bezierPath addLineToPoint:CGPointMake(30.74, 51.72)];
    [bezierPath addLineToPoint:CGPointMake(30.74, 58.35)];
    [bezierPath addCurveToPoint:CGPointMake(27.88, 61.14) controlPoint1:CGPointMake(30.74, 60.07) controlPoint2:CGPointMake(29.66, 61.14)];
    [bezierPath addCurveToPoint:CGPointMake(25.92, 60.48) controlPoint1:CGPointMake(27.19, 61.14) controlPoint2:CGPointMake(26.47, 60.91)];
    [bezierPath addLineToPoint:CGPointMake(13.86, 50.39)];
    [bezierPath addCurveToPoint:CGPointMake(13.76, 46.13) controlPoint1:CGPointMake(12.3, 49.18) controlPoint2:CGPointMake(12.33, 47.31)];
    [bezierPath addLineToPoint:CGPointMake(25.76, 36.23)];
    [bezierPath addCurveToPoint:CGPointMake(27.88, 35.47) controlPoint1:CGPointMake(26.33, 35.75) controlPoint2:CGPointMake(27.12, 35.47)];
    [bezierPath addCurveToPoint:CGPointMake(30.74, 38.26) controlPoint1:CGPointMake(29.66, 35.47) controlPoint2:CGPointMake(30.74, 36.55)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

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


#import "ACStatusIconQuestionView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconQuestionView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconQuestionView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 76, 74) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 76.0, CGRectGetHeight(resizedFrame) / 74.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(30.56, 68.4)];
    [bezierPath addCurveToPoint:CGPointMake(43.85, 68.34) controlPoint1:CGPointMake(34.48, 72.31) controlPoint2:CGPointMake(39.94, 72.25)];
    [bezierPath addLineToPoint:CGPointMake(68.34, 43.85)];
    [bezierPath addCurveToPoint:CGPointMake(68.4, 30.56) controlPoint1:CGPointMake(72.25, 39.94) controlPoint2:CGPointMake(72.31, 34.45)];
    [bezierPath addLineToPoint:CGPointMake(43.73, 5.86)];
    [bezierPath addCurveToPoint:CGPointMake(30.44, 5.99) controlPoint1:CGPointMake(39.81, 1.98) controlPoint2:CGPointMake(34.36, 2.07)];
    [bezierPath addLineToPoint:CGPointMake(5.99, 30.44)];
    [bezierPath addCurveToPoint:CGPointMake(5.86, 43.73) controlPoint1:CGPointMake(2.07, 34.36) controlPoint2:CGPointMake(1.98, 39.81)];
    [bezierPath addLineToPoint:CGPointMake(30.56, 68.4)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(36.21, 45.43)];
    [bezierPath addCurveToPoint:CGPointMake(33.62, 42.9) controlPoint1:CGPointMake(34.54, 45.43) controlPoint2:CGPointMake(33.62, 44.56)];
    [bezierPath addLineToPoint:CGPointMake(33.62, 42.47)];
    [bezierPath addCurveToPoint:CGPointMake(37.66, 35.96) controlPoint1:CGPointMake(33.62, 39.29) controlPoint2:CGPointMake(35.34, 37.56)];
    [bezierPath addLineToPoint:CGPointMake(38.47, 35.4)];
    [bezierPath addCurveToPoint:CGPointMake(41.88, 30.69) controlPoint1:CGPointMake(40.78, 33.78) controlPoint2:CGPointMake(41.88, 32.69)];
    [bezierPath addCurveToPoint:CGPointMake(37.01, 26.59) controlPoint1:CGPointMake(41.88, 28.25) controlPoint2:CGPointMake(39.97, 26.59)];
    [bezierPath addCurveToPoint:CGPointMake(32.23, 29.42) controlPoint1:CGPointMake(34.85, 26.59) controlPoint2:CGPointMake(33.22, 27.67)];
    [bezierPath addCurveToPoint:CGPointMake(29.05, 31.61) controlPoint1:CGPointMake(31.18, 30.66) controlPoint2:CGPointMake(30.9, 31.61)];
    [bezierPath addCurveToPoint:CGPointMake(26.83, 29.39) controlPoint1:CGPointMake(27.97, 31.61) controlPoint2:CGPointMake(26.83, 30.84)];
    [bezierPath addCurveToPoint:CGPointMake(27.08, 27.79) controlPoint1:CGPointMake(26.83, 28.84) controlPoint2:CGPointMake(26.92, 28.31)];
    [bezierPath addCurveToPoint:CGPointMake(37.19, 22.18) controlPoint1:CGPointMake(27.91, 24.8) controlPoint2:CGPointMake(31.64, 22.18)];
    [bezierPath addCurveToPoint:CGPointMake(47.49, 30.44) controlPoint1:CGPointMake(42.71, 22.18) controlPoint2:CGPointMake(47.49, 25.07)];
    [bezierPath addCurveToPoint:CGPointMake(42.13, 38.3) controlPoint1:CGPointMake(47.49, 34.33) controlPoint2:CGPointMake(45.24, 36.18)];
    [bezierPath addCurveToPoint:CGPointMake(38.8, 42.74) controlPoint1:CGPointMake(39.88, 39.81) controlPoint2:CGPointMake(38.8, 40.92)];
    [bezierPath addLineToPoint:CGPointMake(38.8, 43.14)];
    [bezierPath addCurveToPoint:CGPointMake(36.21, 45.43) controlPoint1:CGPointMake(38.8, 44.41) controlPoint2:CGPointMake(37.84, 45.43)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(36.33, 54.71)];
    [bezierPath addCurveToPoint:CGPointMake(32.85, 51.38) controlPoint1:CGPointMake(34.54, 54.71) controlPoint2:CGPointMake(32.85, 53.29)];
    [bezierPath addCurveToPoint:CGPointMake(36.33, 48.05) controlPoint1:CGPointMake(32.85, 49.47) controlPoint2:CGPointMake(34.51, 48.05)];
    [bezierPath addCurveToPoint:CGPointMake(39.78, 51.38) controlPoint1:CGPointMake(38.12, 48.05) controlPoint2:CGPointMake(39.78, 49.43)];
    [bezierPath addCurveToPoint:CGPointMake(36.33, 54.71) controlPoint1:CGPointMake(39.78, 53.32) controlPoint2:CGPointMake(38.09, 54.71)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

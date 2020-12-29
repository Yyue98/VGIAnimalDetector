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


#import "ACStatusIconPrivacyView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconPrivacyView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconPrivacyView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 55, 70) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 55.0, CGRectGetHeight(resizedFrame) / 70.0);
     
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(5, 45.54)];
    [bezierPath addLineToPoint:CGPointMake(5, 18.3)];
    [bezierPath addCurveToPoint:CGPointMake(7.99, 15.34) controlPoint1:CGPointMake(5, 16.74) controlPoint2:CGPointMake(5.97, 15.34)];
    [bezierPath addCurveToPoint:CGPointMake(10.86, 18.3) controlPoint1:CGPointMake(9.95, 15.34) controlPoint2:CGPointMake(10.86, 16.74)];
    [bezierPath addLineToPoint:CGPointMake(10.86, 36.7)];
    [bezierPath addCurveToPoint:CGPointMake(14.05, 35.05) controlPoint1:CGPointMake(11.83, 36.08) controlPoint2:CGPointMake(12.91, 35.52)];
    [bezierPath addLineToPoint:CGPointMake(14.05, 9.19)];
    [bezierPath addCurveToPoint:CGPointMake(16.98, 6.23) controlPoint1:CGPointMake(14.05, 7.63) controlPoint2:CGPointMake(15.05, 6.23)];
    [bezierPath addCurveToPoint:CGPointMake(19.91, 9.19) controlPoint1:CGPointMake(18.92, 6.23) controlPoint2:CGPointMake(19.91, 7.63)];
    [bezierPath addLineToPoint:CGPointMake(19.91, 33.41)];
    [bezierPath addCurveToPoint:CGPointMake(23.11, 33.06) controlPoint1:CGPointMake(20.97, 33.24) controlPoint2:CGPointMake(22.02, 33.12)];
    [bezierPath addCurveToPoint:CGPointMake(23.11, 33.06) controlPoint1:CGPointMake(20.97, 33.24) controlPoint2:CGPointMake(22.02, 33.12)];
    [bezierPath addLineToPoint:CGPointMake(23.11, 6.93)];
    [bezierPath addCurveToPoint:CGPointMake(26.04, 4) controlPoint1:CGPointMake(23.11, 5.38) controlPoint2:CGPointMake(24.07, 4)];
    [bezierPath addCurveToPoint:CGPointMake(28.96, 6.93) controlPoint1:CGPointMake(28, 4) controlPoint2:CGPointMake(28.96, 5.38)];
    [bezierPath addLineToPoint:CGPointMake(28.96, 33.27)];
    [bezierPath addCurveToPoint:CGPointMake(32.16, 33.91) controlPoint1:CGPointMake(30.14, 33.41) controlPoint2:CGPointMake(31.22, 33.65)];
    [bezierPath addLineToPoint:CGPointMake(32.16, 10.77)];
    [bezierPath addCurveToPoint:CGPointMake(35.09, 7.81) controlPoint1:CGPointMake(32.16, 9.21) controlPoint2:CGPointMake(33.12, 7.81)];
    [bezierPath addCurveToPoint:CGPointMake(38.02, 10.77) controlPoint1:CGPointMake(37.08, 7.81) controlPoint2:CGPointMake(38.02, 9.21)];
    [bezierPath addLineToPoint:CGPointMake(38.02, 39.04)];
    [bezierPath addCurveToPoint:CGPointMake(39.25, 43.73) controlPoint1:CGPointMake(38.02, 42.09) controlPoint2:CGPointMake(38.34, 43.73)];
    [bezierPath addCurveToPoint:CGPointMake(44.46, 33.74) controlPoint1:CGPointMake(40.83, 43.73) controlPoint2:CGPointMake(42.82, 37.22)];
    [bezierPath addCurveToPoint:CGPointMake(49.41, 29.43) controlPoint1:CGPointMake(45.93, 30.57) controlPoint2:CGPointMake(46.89, 29.43)];
    [bezierPath addCurveToPoint:CGPointMake(52.2, 31.8) controlPoint1:CGPointMake(50.53, 29.43) controlPoint2:CGPointMake(52.2, 30.54)];
    [bezierPath addCurveToPoint:CGPointMake(49.65, 40.39) controlPoint1:CGPointMake(52.2, 33.77) controlPoint2:CGPointMake(50.56, 37.46)];
    [bezierPath addLineToPoint:CGPointMake(49.52, 40.81)];
    [bezierPath addCurveToPoint:CGPointMake(40.74, 59.66) controlPoint1:CGPointMake(48.39, 44.73) controlPoint2:CGPointMake(46.39, 53.71)];
    [bezierPath addCurveToPoint:CGPointMake(24.16, 66.46) controlPoint1:CGPointMake(36.52, 64.122) controlPoint2:CGPointMake(31.25, 66.46)];
    [bezierPath addCurveToPoint:CGPointMake(5, 45.54) controlPoint1:CGPointMake(13, 66.46) controlPoint2:CGPointMake(5, 59.99)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
 }

@end

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


#import "ACStatusIconMoonView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconMoonView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconMoonView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 53, 52) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 53.0, CGRectGetHeight(resizedFrame) / 52.0);
        
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(40.82, 34.76)];
    [bezierPath addCurveToPoint:CGPointMake(48.45, 33.58) controlPoint1:CGPointMake(43.67, 34.76) controlPoint2:CGPointMake(46.55, 34.16)];
    [bezierPath addLineToPoint:CGPointMake(48.74, 33.49)];
    [bezierPath addCurveToPoint:CGPointMake(49.79, 33.27) controlPoint1:CGPointMake(49.2, 33.34) controlPoint2:CGPointMake(49.47, 33.27)];
    [bezierPath addCurveToPoint:CGPointMake(51.23, 34.78) controlPoint1:CGPointMake(50.47, 33.27) controlPoint2:CGPointMake(51.23, 33.88)];
    [bezierPath addLineToPoint:CGPointMake(51.22, 34.95)];
    [bezierPath addCurveToPoint:CGPointMake(50.96, 36.15) controlPoint1:CGPointMake(51.2, 35.24) controlPoint2:CGPointMake(51.14, 35.7)];
    [bezierPath addCurveToPoint:CGPointMake(28.28, 50.5) controlPoint1:CGPointMake(47.93, 44.12) controlPoint2:CGPointMake(38.81, 50.5)];
    [bezierPath addCurveToPoint:CGPointMake(3, 25.86) controlPoint1:CGPointMake(13.95, 50.5) controlPoint2:CGPointMake(3, 40.23)];
    [bezierPath addCurveToPoint:CGPointMake(18.11, 2.27) controlPoint1:CGPointMake(3, 15.62) controlPoint2:CGPointMake(9.06, 5.89)];
    [bezierPath addCurveToPoint:CGPointMake(19.5, 2) controlPoint1:CGPointMake(18.65, 2.07) controlPoint2:CGPointMake(19.23, 2)];
    [bezierPath addCurveToPoint:CGPointMake(20.94, 3.39) controlPoint1:CGPointMake(20.45, 2) controlPoint2:CGPointMake(20.94, 2.73)];
    [bezierPath addCurveToPoint:CGPointMake(20.67, 4.54) controlPoint1:CGPointMake(20.94, 3.64) controlPoint2:CGPointMake(20.89, 3.98)];
    [bezierPath addCurveToPoint:CGPointMake(19.13, 13.22) controlPoint1:CGPointMake(19.79, 6.57) controlPoint2:CGPointMake(19.13, 10.48)];
    [bezierPath addCurveToPoint:CGPointMake(40.82, 34.76) controlPoint1:CGPointMake(19.13, 26.47) controlPoint2:CGPointMake(27.59, 34.76)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

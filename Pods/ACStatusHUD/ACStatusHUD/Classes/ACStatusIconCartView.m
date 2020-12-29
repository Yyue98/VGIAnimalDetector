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


#import "ACStatusIconCartView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconCartView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconCartView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 72, 62) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 72.0, CGRectGetHeight(resizedFrame) / 62.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(3, 6.12)];
    [bezierPath addCurveToPoint:CGPointMake(5.09, 8.27) controlPoint1:CGPointMake(3, 7.28) controlPoint2:CGPointMake(3.96, 8.27)];
    [bezierPath addLineToPoint:CGPointMake(14.65, 8.27)];
    [bezierPath addLineToPoint:CGPointMake(19.18, 39.32)];
    [bezierPath addCurveToPoint:CGPointMake(25.99, 45.85) controlPoint1:CGPointMake(19.77, 43.34) controlPoint2:CGPointMake(21.89, 45.85)];
    [bezierPath addLineToPoint:CGPointMake(58.99, 45.85)];
    [bezierPath addCurveToPoint:CGPointMake(61.06, 43.73) controlPoint1:CGPointMake(60.1, 45.85) controlPoint2:CGPointMake(61.06, 44.95)];
    [bezierPath addCurveToPoint:CGPointMake(58.99, 41.61) controlPoint1:CGPointMake(61.06, 42.52) controlPoint2:CGPointMake(60.1, 41.61)];
    [bezierPath addLineToPoint:CGPointMake(26.47, 41.61)];
    [bezierPath addCurveToPoint:CGPointMake(23.62, 38.76) controlPoint1:CGPointMake(24.86, 41.61) controlPoint2:CGPointMake(23.87, 40.48)];
    [bezierPath addLineToPoint:CGPointMake(23.16, 35.79)];
    [bezierPath addLineToPoint:CGPointMake(59.05, 35.79)];
    [bezierPath addCurveToPoint:CGPointMake(65.85, 29.46) controlPoint1:CGPointMake(63.09, 35.79) controlPoint2:CGPointMake(65.2, 33.35)];
    [bezierPath addLineToPoint:CGPointMake(68.16, 14.24)];
    [bezierPath addCurveToPoint:CGPointMake(68.27, 13.16) controlPoint1:CGPointMake(68.21, 13.87) controlPoint2:CGPointMake(68.27, 13.42)];
    [bezierPath addCurveToPoint:CGPointMake(65.7, 10.87) controlPoint1:CGPointMake(68.27, 11.81) controlPoint2:CGPointMake(67.25, 10.87)];
    [bezierPath addLineToPoint:CGPointMake(19.54, 10.87)];
    [bezierPath addLineToPoint:CGPointMake(19.98, 7.28)];
    [bezierPath addCurveToPoint:CGPointMake(15.02, 4) controlPoint1:CGPointMake(18.7, 5.1) controlPoint2:CGPointMake(17.9, 4)];
    [bezierPath addLineToPoint:CGPointMake(5.09, 4)];
    [bezierPath addCurveToPoint:CGPointMake(3, 6.12) controlPoint1:CGPointMake(3.96, 4) controlPoint2:CGPointMake(3, 4.99)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(23.62, 55.02)];
    [bezierPath addCurveToPoint:CGPointMake(28.23, 59.6) controlPoint1:CGPointMake(23.62, 57.59) controlPoint2:CGPointMake(25.65, 59.6)];
    [bezierPath addCurveToPoint:CGPointMake(32.81, 55.02) controlPoint1:CGPointMake(30.77, 59.6) controlPoint2:CGPointMake(32.81, 57.59)];
    [bezierPath addCurveToPoint:CGPointMake(28.23, 50.44) controlPoint1:CGPointMake(32.81, 52.47) controlPoint2:CGPointMake(30.77, 50.44)];
    [bezierPath addCurveToPoint:CGPointMake(23.62, 55.02) controlPoint1:CGPointMake(25.65, 50.44) controlPoint2:CGPointMake(23.62, 52.47)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(50.06, 55.02)];
    [bezierPath addCurveToPoint:CGPointMake(54.67, 50.44) controlPoint1:CGPointMake(50.06, 52.47) controlPoint2:CGPointMake(52.12, 50.44)];
    [bezierPath addCurveToPoint:CGPointMake(59.28, 55.02) controlPoint1:CGPointMake(57.24, 50.44) controlPoint2:CGPointMake(59.28, 52.47)];
    [bezierPath addCurveToPoint:CGPointMake(54.67, 59.6) controlPoint1:CGPointMake(59.28, 57.59) controlPoint2:CGPointMake(57.24, 59.6)];
    [bezierPath addCurveToPoint:CGPointMake(50.06, 55.02) controlPoint1:CGPointMake(52.12, 59.6) controlPoint2:CGPointMake(50.06, 57.59)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

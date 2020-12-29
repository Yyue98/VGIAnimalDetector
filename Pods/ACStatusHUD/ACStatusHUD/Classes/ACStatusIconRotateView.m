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


#import "ACStatusIconRotateView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconRotateView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconRotateView

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
    [bezierPath moveToPoint:CGPointMake(7.69, 32.39)];
    [bezierPath addCurveToPoint:CGPointMake(8.52, 30.88) controlPoint1:CGPointMake(8.28, 32.09) controlPoint2:CGPointMake(8.58, 31.63)];
    [bezierPath addCurveToPoint:CGPointMake(7.37, 24.98) controlPoint1:CGPointMake(8.47, 29.91) controlPoint2:CGPointMake(7.37, 28.56)];
    [bezierPath addCurveToPoint:CGPointMake(16.61, 15.16) controlPoint1:CGPointMake(7.37, 19.31) controlPoint2:CGPointMake(10.94, 15.29)];
    [bezierPath addLineToPoint:CGPointMake(16.95, 15.15)];
    [bezierPath addLineToPoint:CGPointMake(16.95, 18.87)];
    [bezierPath addCurveToPoint:CGPointMake(20.11, 20.37) controlPoint1:CGPointMake(16.95, 20.94) controlPoint2:CGPointMake(18.56, 21.45)];
    [bezierPath addLineToPoint:CGPointMake(27.62, 14.91)];
    [bezierPath addCurveToPoint:CGPointMake(27.62, 12.06) controlPoint1:CGPointMake(28.83, 14.02) controlPoint2:CGPointMake(28.83, 12.97)];
    [bezierPath addLineToPoint:CGPointMake(20.224, 6.67)];
    [bezierPath addCurveToPoint:CGPointMake(16.95, 8.1) controlPoint1:CGPointMake(18.62, 5.43) controlPoint2:CGPointMake(16.95, 5.91)];
    [bezierPath addLineToPoint:CGPointMake(16.95, 12.06)];
    [bezierPath addLineToPoint:CGPointMake(16.87, 12.06)];
    [bezierPath addCurveToPoint:CGPointMake(4, 24.96) controlPoint1:CGPointMake(9.14, 12.06) controlPoint2:CGPointMake(4, 17.25)];
    [bezierPath addCurveToPoint:CGPointMake(5.4, 31.63) controlPoint1:CGPointMake(4, 27.84) controlPoint2:CGPointMake(4.59, 30.21)];
    [bezierPath addCurveToPoint:CGPointMake(7.69, 32.39) controlPoint1:CGPointMake(5.89, 32.42) controlPoint2:CGPointMake(6.85, 32.79)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(51.05, 66)];
    [bezierPath addLineToPoint:CGPointMake(24.33, 66)];
    [bezierPath addCurveToPoint:CGPointMake(17.44, 59.08) controlPoint1:CGPointMake(19.73, 66) controlPoint2:CGPointMake(17.44, 63.79)];
    [bezierPath addLineToPoint:CGPointMake(17.44, 32.44)];
    [bezierPath addCurveToPoint:CGPointMake(24.33, 25.52) controlPoint1:CGPointMake(17.44, 27.73) controlPoint2:CGPointMake(19.73, 25.52)];
    [bezierPath addLineToPoint:CGPointMake(51.05, 25.52)];
    [bezierPath addCurveToPoint:CGPointMake(57.94, 32.44) controlPoint1:CGPointMake(55.66, 25.52) controlPoint2:CGPointMake(57.94, 27.73)];
    [bezierPath addLineToPoint:CGPointMake(57.94, 59.08)];
    [bezierPath addCurveToPoint:CGPointMake(51.05, 66) controlPoint1:CGPointMake(57.94, 63.79) controlPoint2:CGPointMake(55.66, 66)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

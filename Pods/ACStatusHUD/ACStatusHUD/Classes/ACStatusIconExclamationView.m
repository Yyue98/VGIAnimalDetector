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

#import "ACStatusIconExclamationView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconExclamationView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconExclamationView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 58, 52) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 58.0, CGRectGetHeight(resizedFrame) / 52.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(9.05, 50)];
    [bezierPath addLineToPoint:CGPointMake(48.02, 50)];
    [bezierPath addCurveToPoint:CGPointMake(54.07, 43.95) controlPoint1:CGPointMake(51.74, 50) controlPoint2:CGPointMake(54.07, 47.32)];
    [bezierPath addCurveToPoint:CGPointMake(53.27, 40.97) controlPoint1:CGPointMake(54.07, 42.93) controlPoint2:CGPointMake(53.82, 41.91)];
    [bezierPath addLineToPoint:CGPointMake(33.75, 6.05)];
    [bezierPath addCurveToPoint:CGPointMake(28.55, 3) controlPoint1:CGPointMake(32.64, 4.04) controlPoint2:CGPointMake(30.58, 3)];
    [bezierPath addCurveToPoint:CGPointMake(23.31, 6.05) controlPoint1:CGPointMake(26.49, 3) controlPoint2:CGPointMake(24.43, 4.04)];
    [bezierPath addLineToPoint:CGPointMake(3.82, 41)];
    [bezierPath addCurveToPoint:CGPointMake(3, 43.95) controlPoint1:CGPointMake(3.27, 41.94) controlPoint2:CGPointMake(3, 42.93)];
    [bezierPath addCurveToPoint:CGPointMake(9.05, 50) controlPoint1:CGPointMake(3, 47.32) controlPoint2:CGPointMake(5.33, 50)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(28.55, 33.01)];
    [bezierPath addCurveToPoint:CGPointMake(26.46, 30.93) controlPoint1:CGPointMake(27.23, 33.01) controlPoint2:CGPointMake(26.51, 32.27)];
    [bezierPath addLineToPoint:CGPointMake(26.12, 18.67)];
    [bezierPath addCurveToPoint:CGPointMake(28.52, 16.34) controlPoint1:CGPointMake(26.07, 17.34) controlPoint2:CGPointMake(27.11, 16.34)];
    [bezierPath addCurveToPoint:CGPointMake(30.93, 18.7) controlPoint1:CGPointMake(29.91, 16.34) controlPoint2:CGPointMake(30.98, 17.36)];
    [bezierPath addLineToPoint:CGPointMake(30.58, 30.93)];
    [bezierPath addCurveToPoint:CGPointMake(28.55, 33.01) controlPoint1:CGPointMake(30.53, 32.29) controlPoint2:CGPointMake(29.79, 33.01)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(28.55, 42.16)];
    [bezierPath addCurveToPoint:CGPointMake(25.77, 39.48) controlPoint1:CGPointMake(27.11, 42.16) controlPoint2:CGPointMake(25.77, 41.02)];
    [bezierPath addCurveToPoint:CGPointMake(28.55, 36.81) controlPoint1:CGPointMake(25.77, 37.95) controlPoint2:CGPointMake(27.08, 36.81)];
    [bezierPath addCurveToPoint:CGPointMake(31.32, 39.48) controlPoint1:CGPointMake(29.98, 36.81) controlPoint2:CGPointMake(31.32, 37.92)];
    [bezierPath addCurveToPoint:CGPointMake(28.55, 42.16) controlPoint1:CGPointMake(31.32, 41.05) controlPoint2:CGPointMake(29.96, 42.16)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

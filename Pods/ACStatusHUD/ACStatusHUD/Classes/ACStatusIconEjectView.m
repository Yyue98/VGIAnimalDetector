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


#import "ACStatusIconEjectView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconEjectView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconEjectView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 60, 60) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 60.0, CGRectGetHeight(resizedFrame) / 60.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(52.91, 34.64)];
    [bezierPath addCurveToPoint:CGPointMake(57.54, 30.39) controlPoint1:CGPointMake(55.73, 34.64) controlPoint2:CGPointMake(57.54, 32.88)];
    [bezierPath addCurveToPoint:CGPointMake(56.01, 26.96) controlPoint1:CGPointMake(57.54, 29.26) controlPoint2:CGPointMake(56.98, 27.98)];
    [bezierPath addLineToPoint:CGPointMake(34.16, 4.58)];
    [bezierPath addCurveToPoint:CGPointMake(29.33, 2) controlPoint1:CGPointMake(32.35, 2.88) controlPoint2:CGPointMake(31.06, 2)];
    [bezierPath addCurveToPoint:CGPointMake(24.53, 4.58) controlPoint1:CGPointMake(27.63, 2) controlPoint2:CGPointMake(26.28, 2.91)];
    [bezierPath addLineToPoint:CGPointMake(2.85, 26.76)];
    [bezierPath addCurveToPoint:CGPointMake(1.12, 30.39) controlPoint1:CGPointMake(1.76, 27.81) controlPoint2:CGPointMake(1.09, 29.19)];
    [bezierPath addCurveToPoint:CGPointMake(5.75, 34.64) controlPoint1:CGPointMake(1.122, 32.88) controlPoint2:CGPointMake(2.93, 34.64)];
    [bezierPath addLineToPoint:CGPointMake(52.91, 34.64)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(51.86, 40.73)];
    [bezierPath addCurveToPoint:CGPointMake(57.69, 46.41) controlPoint1:CGPointMake(55.49, 40.73) controlPoint2:CGPointMake(57.69, 42.87)];
    [bezierPath addLineToPoint:CGPointMake(57.69, 52.42)];
    [bezierPath addCurveToPoint:CGPointMake(51.86, 58.13) controlPoint1:CGPointMake(57.69, 56.11) controlPoint2:CGPointMake(55.49, 58.13)];
    [bezierPath addLineToPoint:CGPointMake(6.86, 58.13)];
    [bezierPath addCurveToPoint:CGPointMake(1, 52.42) controlPoint1:CGPointMake(3.223, 58.13) controlPoint2:CGPointMake(1, 56.08)];
    [bezierPath addLineToPoint:CGPointMake(1, 46.41)];
    [bezierPath addCurveToPoint:CGPointMake(6.86, 40.73) controlPoint1:CGPointMake(1, 42.87) controlPoint2:CGPointMake(3.23, 40.73)];
    [bezierPath addLineToPoint:CGPointMake(51.86, 40.73)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

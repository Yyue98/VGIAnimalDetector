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

#import "ACStatusIconBoltView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconBoltView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconBoltView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 47, 71) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 47.0, CGRectGetHeight(resizedFrame) / 71.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(4.16, 42.19)];
    [bezierPath addCurveToPoint:CGPointMake(2, 40.16) controlPoint1:CGPointMake(2.9, 42.19) controlPoint2:CGPointMake(2, 41.33)];
    [bezierPath addCurveToPoint:CGPointMake(2.81, 38.24) controlPoint1:CGPointMake(2, 39.6) controlPoint2:CGPointMake(2.3, 38.9)];
    [bezierPath addLineToPoint:CGPointMake(30, 4.25)];
    [bezierPath addCurveToPoint:CGPointMake(34.07, 6.44) controlPoint1:CGPointMake(32.04, 1.71) controlPoint2:CGPointMake(35.221, 3.35)];
    [bezierPath addLineToPoint:CGPointMake(25.12, 30.69)];
    [bezierPath addLineToPoint:CGPointMake(42.07, 30.69)];
    [bezierPath addCurveToPoint:CGPointMake(44.2, 32.73) controlPoint1:CGPointMake(43.33, 30.69) controlPoint2:CGPointMake(44.2, 31.59)];
    [bezierPath addCurveToPoint:CGPointMake(43.42, 34.65) controlPoint1:CGPointMake(44.2, 33.42) controlPoint2:CGPointMake(43.93, 34.02)];
    [bezierPath addLineToPoint:CGPointMake(16.23, 68.67)];
    [bezierPath addCurveToPoint:CGPointMake(12.15, 66.45) controlPoint1:CGPointMake(14.19, 71.18) controlPoint2:CGPointMake(10.98, 69.54)];
    [bezierPath addLineToPoint:CGPointMake(21.11, 42.19)];
    [bezierPath addLineToPoint:CGPointMake(4.16, 42.19)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

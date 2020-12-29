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


#import "ACStatusIconFlagView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconFlagView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconFlagView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 51, 55) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 51.0, CGRectGetHeight(resizedFrame) / 55.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(3.94, 53)];
    [bezierPath addCurveToPoint:CGPointMake(2, 51.09) controlPoint1:CGPointMake(2.89, 53) controlPoint2:CGPointMake(2, 52.13)];
    [bezierPath addLineToPoint:CGPointMake(2, 8.73)];
    [bezierPath addCurveToPoint:CGPointMake(4.91, 4.3) controlPoint1:CGPointMake(2, 6.41) controlPoint2:CGPointMake(3.15, 5.09)];
    [bezierPath addLineToPoint:CGPointMake(5.25, 4.15)];
    [bezierPath addCurveToPoint:CGPointMake(12.32, 3) controlPoint1:CGPointMake(7.03, 3.38) controlPoint2:CGPointMake(8.59, 3)];
    [bezierPath addCurveToPoint:CGPointMake(36.63, 7.61) controlPoint1:CGPointMake(21.78, 3) controlPoint2:CGPointMake(27.66, 7.61)];
    [bezierPath addCurveToPoint:CGPointMake(44.61, 6.54) controlPoint1:CGPointMake(41.02, 7.61) controlPoint2:CGPointMake(43.36, 6.54)];
    [bezierPath addCurveToPoint:CGPointMake(47.26, 8.71) controlPoint1:CGPointMake(46.09, 6.54) controlPoint2:CGPointMake(47.26, 7.33)];
    [bezierPath addLineToPoint:CGPointMake(47.26, 34.57)];
    [bezierPath addCurveToPoint:CGPointMake(44.35, 39.03) controlPoint1:CGPointMake(47.26, 36.92) controlPoint2:CGPointMake(46.11, 38.24)];
    [bezierPath addLineToPoint:CGPointMake(44.01, 39.19)];
    [bezierPath addCurveToPoint:CGPointMake(36.96, 40.33) controlPoint1:CGPointMake(42.23, 39.95) controlPoint2:CGPointMake(40.7, 40.33)];
    [bezierPath addCurveToPoint:CGPointMake(12.65, 35.72) controlPoint1:CGPointMake(27.99, 40.33) controlPoint2:CGPointMake(22.08, 35.72)];
    [bezierPath addCurveToPoint:CGPointMake(5.87, 36.92) controlPoint1:CGPointMake(8.91, 35.72) controlPoint2:CGPointMake(6.51, 36.64)];
    [bezierPath addLineToPoint:CGPointMake(5.87, 51.09)];
    [bezierPath addCurveToPoint:CGPointMake(3.94, 53) controlPoint1:CGPointMake(5.87, 52.16) controlPoint2:CGPointMake(5.01, 53)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

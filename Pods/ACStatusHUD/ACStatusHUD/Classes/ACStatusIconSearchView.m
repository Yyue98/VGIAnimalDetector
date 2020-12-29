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


#import "ACStatusIconSearchView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconSearchView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconSearchView

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
    [bezierPath moveToPoint:CGPointMake(24.46, 49.92)];
    [bezierPath addCurveToPoint:CGPointMake(38.1, 45.53) controlPoint1:CGPointMake(29.56, 49.92) controlPoint2:CGPointMake(34.26, 48.28)];
    [bezierPath addLineToPoint:CGPointMake(52.56, 59.99)];
    [bezierPath addCurveToPoint:CGPointMake(55.06, 61) controlPoint1:CGPointMake(53.23, 60.66) controlPoint2:CGPointMake(54.12, 61)];
    [bezierPath addCurveToPoint:CGPointMake(58.45, 57.52) controlPoint1:CGPointMake(57.05, 61) controlPoint2:CGPointMake(58.45, 59.47)];
    [bezierPath addCurveToPoint:CGPointMake(57.47, 55.08) controlPoint1:CGPointMake(58.45, 56.61) controlPoint2:CGPointMake(58.15, 55.75)];
    [bezierPath addLineToPoint:CGPointMake(43.1, 40.68)];
    [bezierPath addCurveToPoint:CGPointMake(47.92, 26.46) controlPoint1:CGPointMake(46.12, 36.71) controlPoint2:CGPointMake(47.92, 31.8)];
    [bezierPath addCurveToPoint:CGPointMake(24.46, 3) controlPoint1:CGPointMake(47.92, 13.56) controlPoint2:CGPointMake(37.37, 3)];
    [bezierPath addCurveToPoint:CGPointMake(1, 26.46) controlPoint1:CGPointMake(11.56, 3) controlPoint2:CGPointMake(1, 13.56)];
    [bezierPath addCurveToPoint:CGPointMake(24.46, 49.92) controlPoint1:CGPointMake(1, 39.37) controlPoint2:CGPointMake(11.56, 49.92)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(24.46, 44.86)];
    [bezierPath addCurveToPoint:CGPointMake(6.06, 26.46) controlPoint1:CGPointMake(14.39, 44.86) controlPoint2:CGPointMake(6.06, 36.53)];
    [bezierPath addCurveToPoint:CGPointMake(24.46, 8.06) controlPoint1:CGPointMake(6.06, 16.39) controlPoint2:CGPointMake(14.39, 8.06)];
    [bezierPath addCurveToPoint:CGPointMake(42.86, 26.46) controlPoint1:CGPointMake(34.53, 8.06) controlPoint2:CGPointMake(42.86, 16.39)];
    [bezierPath addCurveToPoint:CGPointMake(24.46, 44.86) controlPoint1:CGPointMake(42.86, 36.53) controlPoint2:CGPointMake(34.53, 44.86)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

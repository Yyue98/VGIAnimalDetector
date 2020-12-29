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


#import "ACStatusIconShuffleView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconShuffleView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconShuffleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 76, 60) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 76.0, CGRectGetHeight(resizedFrame) / 60.0);
        
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(1, 46.28)];
    [bezierPath addCurveToPoint:CGPointMake(4.62, 42.94) controlPoint1:CGPointMake(1, 44.32) controlPoint2:CGPointMake(2.47, 42.94)];
    [bezierPath addLineToPoint:CGPointMake(11.73, 42.94)];
    [bezierPath addCurveToPoint:CGPointMake(19.06, 39.01) controlPoint1:CGPointMake(14.65, 42.94) controlPoint2:CGPointMake(16.52, 41.93)];
    [bezierPath addLineToPoint:CGPointMake(26.39, 30.46)];
    [bezierPath addLineToPoint:CGPointMake(19.06, 21.93)];
    [bezierPath addCurveToPoint:CGPointMake(11.73, 18.01) controlPoint1:CGPointMake(16.55, 19.02) controlPoint2:CGPointMake(14.68, 18.01)];
    [bezierPath addLineToPoint:CGPointMake(4.62, 18.01)];
    [bezierPath addCurveToPoint:CGPointMake(1, 14.66) controlPoint1:CGPointMake(2.47, 18.01) controlPoint2:CGPointMake(1, 16.63)];
    [bezierPath addCurveToPoint:CGPointMake(4.62, 11.32) controlPoint1:CGPointMake(1, 12.67) controlPoint2:CGPointMake(2.44, 11.32)];
    [bezierPath addLineToPoint:CGPointMake(11.58, 11.32)];
    [bezierPath addCurveToPoint:CGPointMake(23.88, 17.33) controlPoint1:CGPointMake(16.88, 11.32) controlPoint2:CGPointMake(20.04, 12.89)];
    [bezierPath addLineToPoint:CGPointMake(30.74, 25.37)];
    [bezierPath addLineToPoint:CGPointMake(37.64, 17.33)];
    [bezierPath addCurveToPoint:CGPointMake(49.94, 11.32) controlPoint1:CGPointMake(41.42, 12.89) controlPoint2:CGPointMake(44.61, 11.32)];
    [bezierPath addLineToPoint:CGPointMake(55.58, 11.32)];
    [bezierPath addLineToPoint:CGPointMake(55.58, 4.7)];
    [bezierPath addCurveToPoint:CGPointMake(58.31, 2) controlPoint1:CGPointMake(55.58, 3.04) controlPoint2:CGPointMake(56.63, 2)];
    [bezierPath addCurveToPoint:CGPointMake(60.4, 2.77) controlPoint1:CGPointMake(59.05, 2) controlPoint2:CGPointMake(59.81, 2.28)];
    [bezierPath addLineToPoint:CGPointMake(71.99, 12.4)];
    [bezierPath addCurveToPoint:CGPointMake(71.99, 16.5) controlPoint1:CGPointMake(73.37, 13.56) controlPoint2:CGPointMake(73.37, 15.37)];
    [bezierPath addLineToPoint:CGPointMake(60.4, 26.07)];
    [bezierPath addCurveToPoint:CGPointMake(58.31, 26.84) controlPoint1:CGPointMake(59.81, 26.56) controlPoint2:CGPointMake(59.05, 26.84)];
    [bezierPath addCurveToPoint:CGPointMake(55.58, 24.14) controlPoint1:CGPointMake(56.63, 26.84) controlPoint2:CGPointMake(55.58, 25.8)];
    [bezierPath addLineToPoint:CGPointMake(55.58, 17.98)];
    [bezierPath addLineToPoint:CGPointMake(50.12, 17.98)];
    [bezierPath addCurveToPoint:CGPointMake(42.72, 21.66) controlPoint1:CGPointMake(47.04, 17.98) controlPoint2:CGPointMake(45.1, 18.93)];
    [bezierPath addLineToPoint:CGPointMake(35.16, 30.46)];
    [bezierPath addLineToPoint:CGPointMake(42.49, 39.01)];
    [bezierPath addCurveToPoint:CGPointMake(50.12, 42.94) controlPoint1:CGPointMake(44.97, 41.93) controlPoint2:CGPointMake(46.94, 42.94)];
    [bezierPath addLineToPoint:CGPointMake(55.58, 42.94)];
    [bezierPath addLineToPoint:CGPointMake(55.58, 36.99)];
    [bezierPath addCurveToPoint:CGPointMake(58.31, 34.29) controlPoint1:CGPointMake(55.58, 35.33) controlPoint2:CGPointMake(56.63, 34.29)];
    [bezierPath addCurveToPoint:CGPointMake(60.4, 35.06) controlPoint1:CGPointMake(59.05, 34.29) controlPoint2:CGPointMake(59.81, 34.57)];
    [bezierPath addLineToPoint:CGPointMake(71.99, 44.69)];
    [bezierPath addCurveToPoint:CGPointMake(71.99, 48.79) controlPoint1:CGPointMake(73.37, 45.82) controlPoint2:CGPointMake(73.37, 47.66)];
    [bezierPath addLineToPoint:CGPointMake(60.4, 58.36)];
    [bezierPath addCurveToPoint:CGPointMake(58.31, 59.13) controlPoint1:CGPointMake(59.81, 58.85) controlPoint2:CGPointMake(59.05, 59.13)];
    [bezierPath addCurveToPoint:CGPointMake(55.58, 56.43) controlPoint1:CGPointMake(56.63, 59.13) controlPoint2:CGPointMake(55.58, 58.09)];
    [bezierPath addLineToPoint:CGPointMake(55.58, 49.62)];
    [bezierPath addLineToPoint:CGPointMake(49.94, 49.62)];
    [bezierPath addCurveToPoint:CGPointMake(37.9, 43.91) controlPoint1:CGPointMake(44.73, 49.62) controlPoint2:CGPointMake(41.56, 48.13)];
    [bezierPath addLineToPoint:CGPointMake(30.74, 35.58)];
    [bezierPath addLineToPoint:CGPointMake(23.88, 43.61)];
    [bezierPath addCurveToPoint:CGPointMake(11.58, 49.59) controlPoint1:CGPointMake(20.04, 48.06) controlPoint2:CGPointMake(16.88, 49.59)];
    [bezierPath addLineToPoint:CGPointMake(4.62, 49.59)];
    [bezierPath addCurveToPoint:CGPointMake(1, 46.28) controlPoint1:CGPointMake(2.44, 49.59) controlPoint2:CGPointMake(1, 48.24)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

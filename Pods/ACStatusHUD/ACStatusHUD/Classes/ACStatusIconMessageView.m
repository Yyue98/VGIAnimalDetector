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


#import "ACStatusIconMessageView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconMessageView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconMessageView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 60, 56) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 60.0, CGRectGetHeight(resizedFrame) / 56.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(17.07, 54.63)];
    [bezierPath addCurveToPoint:CGPointMake(19.56, 53.4) controlPoint1:CGPointMake(17.93, 54.63) controlPoint2:CGPointMake(18.6, 54.24)];
    [bezierPath addLineToPoint:CGPointMake(29.14, 44.64)];
    [bezierPath addLineToPoint:CGPointMake(46.29, 44.66)];
    [bezierPath addCurveToPoint:CGPointMake(57.9, 33.05) controlPoint1:CGPointMake(53.85, 44.69) controlPoint2:CGPointMake(57.9, 40.48)];
    [bezierPath addLineToPoint:CGPointMake(57.9, 13.62)];
    [bezierPath addCurveToPoint:CGPointMake(46.29, 2) controlPoint1:CGPointMake(57.9, 6.19) controlPoint2:CGPointMake(53.85, 2)];
    [bezierPath addLineToPoint:CGPointMake(13.62, 2)];
    [bezierPath addCurveToPoint:CGPointMake(2, 13.62) controlPoint1:CGPointMake(6.06, 2) controlPoint2:CGPointMake(2, 6.16)];
    [bezierPath addLineToPoint:CGPointMake(2, 33.05)];
    [bezierPath addCurveToPoint:CGPointMake(13.62, 44.64) controlPoint1:CGPointMake(2, 40.5) controlPoint2:CGPointMake(6.06, 44.66)];
    [bezierPath addLineToPoint:CGPointMake(14.81, 44.64)];
    [bezierPath addLineToPoint:CGPointMake(14.81, 52.02)];
    [bezierPath addCurveToPoint:CGPointMake(17.07, 54.63) controlPoint1:CGPointMake(14.81, 53.59) controlPoint2:CGPointMake(15.62, 54.63)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(15.75, 16.2)];
    [bezierPath addCurveToPoint:CGPointMake(14.12, 14.56) controlPoint1:CGPointMake(14.86, 16.2) controlPoint2:CGPointMake(14.12, 15.49)];
    [bezierPath addCurveToPoint:CGPointMake(15.75, 12.98) controlPoint1:CGPointMake(14.12, 13.72) controlPoint2:CGPointMake(14.86, 12.98)];
    [bezierPath addLineToPoint:CGPointMake(44.16, 12.98)];
    [bezierPath addCurveToPoint:CGPointMake(45.78, 14.56) controlPoint1:CGPointMake(45.04, 12.98) controlPoint2:CGPointMake(45.78, 13.72)];
    [bezierPath addCurveToPoint:CGPointMake(44.16, 16.2) controlPoint1:CGPointMake(45.78, 15.49) controlPoint2:CGPointMake(45.04, 16.2)];
    [bezierPath addLineToPoint:CGPointMake(15.75, 16.2)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(15.75, 25.29)];
    [bezierPath addCurveToPoint:CGPointMake(14.12, 23.66) controlPoint1:CGPointMake(14.86, 25.29) controlPoint2:CGPointMake(14.12, 24.58)];
    [bezierPath addCurveToPoint:CGPointMake(15.75, 22.06) controlPoint1:CGPointMake(14.12, 22.8) controlPoint2:CGPointMake(14.86, 22.06)];
    [bezierPath addLineToPoint:CGPointMake(44.16, 22.06)];
    [bezierPath addCurveToPoint:CGPointMake(45.78, 23.66) controlPoint1:CGPointMake(45.04, 22.06) controlPoint2:CGPointMake(45.78, 22.8)];
    [bezierPath addCurveToPoint:CGPointMake(44.16, 25.29) controlPoint1:CGPointMake(45.78, 24.58) controlPoint2:CGPointMake(45.04, 25.29)];
    [bezierPath addLineToPoint:CGPointMake(15.75, 25.29)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(15.75, 34.39)];
    [bezierPath addCurveToPoint:CGPointMake(14.12, 32.77) controlPoint1:CGPointMake(14.86, 34.39) controlPoint2:CGPointMake(14.12, 33.66)];
    [bezierPath addCurveToPoint:CGPointMake(15.75, 31.14) controlPoint1:CGPointMake(14.12, 31.83) controlPoint2:CGPointMake(14.86, 31.14)];
    [bezierPath addLineToPoint:CGPointMake(34.24, 31.14)];
    [bezierPath addCurveToPoint:CGPointMake(35.84, 32.77) controlPoint1:CGPointMake(35.1, 31.14) controlPoint2:CGPointMake(35.84, 31.83)];
    [bezierPath addCurveToPoint:CGPointMake(34.24, 34.39) controlPoint1:CGPointMake(35.84, 33.66) controlPoint2:CGPointMake(35.1, 34.39)];
    [bezierPath addLineToPoint:CGPointMake(15.75, 34.39)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

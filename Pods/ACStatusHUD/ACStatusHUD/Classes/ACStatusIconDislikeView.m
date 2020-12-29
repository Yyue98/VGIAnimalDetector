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


#import "ACStatusIconDislikeView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconDislikeView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconDislikeView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 61, 64) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 61.0, CGRectGetHeight(resizedFrame) / 64.0);
    CGContextSaveGState(context);
    
    CGContextBeginTransparencyLayer(context, nil);
    
    UIBezierPath *clipPath = [UIBezierPath bezierPath];
    [clipPath moveToPoint:CGPointMake(11.03, 4.6)];
    [clipPath addLineToPoint:CGPointMake(10.83, 4.64)];
    [clipPath addCurveToPoint:CGPointMake(6.47, 9.26) controlPoint1:CGPointMake(8.65, 5.18) controlPoint2:CGPointMake(6.47, 6.57)];
    [clipPath addCurveToPoint:CGPointMake(7.14, 11.74) controlPoint1:CGPointMake(6.47, 10.35) controlPoint2:CGPointMake(6.75, 11.13)];
    [clipPath addCurveToPoint:CGPointMake(7.08, 12.49) controlPoint1:CGPointMake(7.35, 12.08) controlPoint2:CGPointMake(7.34, 12.34)];
    [clipPath addLineToPoint:CGPointMake(7, 12.53)];
    [clipPath addCurveToPoint:CGPointMake(3.76, 17.14) controlPoint1:CGPointMake(5.24, 13.31) controlPoint2:CGPointMake(3.76, 14.9)];
    [clipPath addCurveToPoint:CGPointMake(4.61, 20.17) controlPoint1:CGPointMake(3.76, 18.33) controlPoint2:CGPointMake(4.07, 19.38)];
    [clipPath addLineToPoint:CGPointMake(4.74, 20.35)];
    [clipPath addCurveToPoint:CGPointMake(4.52, 21.42) controlPoint1:CGPointMake(5.07, 20.77) controlPoint2:CGPointMake(4.99, 21.14)];
    [clipPath addCurveToPoint:CGPointMake(2.36, 25.61) controlPoint1:CGPointMake(3.2, 22.14) controlPoint2:CGPointMake(2.36, 23.76)];
    [clipPath addCurveToPoint:CGPointMake(3.42, 28.88) controlPoint1:CGPointMake(2.36, 26.84) controlPoint2:CGPointMake(2.73, 28.14)];
    [clipPath addLineToPoint:CGPointMake(3.57, 29.02)];
    [clipPath addCurveToPoint:CGPointMake(3.52, 30) controlPoint1:CGPointMake(3.96, 29.38) controlPoint2:CGPointMake(3.91, 29.65)];
    [clipPath addLineToPoint:CGPointMake(3.43, 30.08)];
    [clipPath addCurveToPoint:CGPointMake(2, 33.71) controlPoint1:CGPointMake(2.5, 30.78) controlPoint2:CGPointMake(2, 32.12)];
    [clipPath addCurveToPoint:CGPointMake(6.89, 38.69) controlPoint1:CGPointMake(2, 36.45) controlPoint2:CGPointMake(4.12, 38.69)];
    [clipPath addLineToPoint:CGPointMake(16.87, 38.69)];
    [clipPath addCurveToPoint:CGPointMake(21.09, 42.07) controlPoint1:CGPointMake(19.41, 38.69) controlPoint2:CGPointMake(21.09, 39.97)];
    [clipPath addCurveToPoint:CGPointMake(16.34, 57.86) controlPoint1:CGPointMake(21.09, 45.9) controlPoint2:CGPointMake(16.34, 52.83)];
    [clipPath addCurveToPoint:CGPointMake(20.25, 62) controlPoint1:CGPointMake(16.34, 60.46) controlPoint2:CGPointMake(18.04, 62)];
    [clipPath addCurveToPoint:CGPointMake(24.39, 58.48) controlPoint1:CGPointMake(22.26, 62) controlPoint2:CGPointMake(23.3, 60.6)];
    [clipPath addCurveToPoint:CGPointMake(38.48, 37.96) controlPoint1:CGPointMake(28.53, 50.26) controlPoint2:CGPointMake(34.17, 43.66)];
    [clipPath addCurveToPoint:CGPointMake(43.98, 22.34) controlPoint1:CGPointMake(42.11, 33.13) controlPoint2:CGPointMake(43.9, 29.02)];
    [clipPath addCurveToPoint:CGPointMake(23.02, 4.06) controlPoint1:CGPointMake(44.12, 12.1) controlPoint2:CGPointMake(35.93, 4.3)];
    [clipPath addLineToPoint:CGPointMake(18.74, 4)];
    [clipPath addCurveToPoint:CGPointMake(11.03, 4.6) controlPoint1:CGPointMake(15.23, 3.98) controlPoint2:CGPointMake(12.61, 4.23)];
    [clipPath addLineToPoint:CGPointMake(11.03, 4.6)];
    [clipPath closePath];
    
    [clipPath moveToPoint:CGPointMake(57.73, 22.11)];
    [clipPath addCurveToPoint:CGPointMake(46.55, 37.63) controlPoint1:CGPointMake(57.73, 30.83) controlPoint2:CGPointMake(52.87, 37.63)];
    [clipPath addLineToPoint:CGPointMake(42.44, 37.63)];
    [clipPath addCurveToPoint:CGPointMake(47.78, 22.39) controlPoint1:CGPointMake(44.93, 34.55) controlPoint2:CGPointMake(47.67, 29.49)];
    [clipPath addCurveToPoint:CGPointMake(40.52, 6.71) controlPoint1:CGPointMake(47.9, 16.02) controlPoint2:CGPointMake(45.58, 10.43)];
    [clipPath addLineToPoint:CGPointMake(45.52, 6.71)];
    [clipPath addCurveToPoint:CGPointMake(57.73, 22.11) controlPoint1:CGPointMake(52.51, 6.71) controlPoint2:CGPointMake(57.73, 13.73)];
    [clipPath closePath];
    [clipPath addClip];
    
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(-3.02, -1, 65.75, 68)];
    [color setFill];
    [rectanglePath fill];
    
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
}

@end

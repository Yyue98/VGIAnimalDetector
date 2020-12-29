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


#import "ACStatusIconLikeView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconLikeView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconLikeView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 62, 65) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 62.0, CGRectGetHeight(resizedFrame) / 65.0);
    
    CGContextSaveGState(context);
    CGContextBeginTransparencyLayer(context, nil);
    
    UIBezierPath *clipPath = [UIBezierPath bezierPath];
    [clipPath moveToPoint:CGPointMake(49.72, 61.4)];
    [clipPath addLineToPoint:CGPointMake(49.9, 61.36)];
    [clipPath addCurveToPoint:CGPointMake(54.26, 56.74) controlPoint1:CGPointMake(52.08, 60.85) controlPoint2:CGPointMake(54.26, 59.43)];
    [clipPath addCurveToPoint:CGPointMake(53.68, 54.41) controlPoint1:CGPointMake(54.26, 55.74) controlPoint2:CGPointMake(54.02, 55.02)];
    [clipPath addLineToPoint:CGPointMake(53.59, 54.26)];
    [clipPath addCurveToPoint:CGPointMake(53.73, 53.47) controlPoint1:CGPointMake(53.37, 53.89) controlPoint2:CGPointMake(53.42, 53.61)];
    [clipPath addCurveToPoint:CGPointMake(56.97, 48.86) controlPoint1:CGPointMake(55.49, 52.69) controlPoint2:CGPointMake(56.97, 51.13)];
    [clipPath addCurveToPoint:CGPointMake(56.12, 45.83) controlPoint1:CGPointMake(56.97, 47.69) controlPoint2:CGPointMake(56.66, 46.62)];
    [clipPath addLineToPoint:CGPointMake(55.99, 45.65)];
    [clipPath addCurveToPoint:CGPointMake(56.25, 44.58) controlPoint1:CGPointMake(55.66, 45.23) controlPoint2:CGPointMake(55.74, 44.89)];
    [clipPath addCurveToPoint:CGPointMake(58.37, 40.39) controlPoint1:CGPointMake(57.53, 43.86) controlPoint2:CGPointMake(58.37, 42.24)];
    [clipPath addCurveToPoint:CGPointMake(57.17, 36.98) controlPoint1:CGPointMake(58.37, 39.11) controlPoint2:CGPointMake(57.95, 37.68)];
    [clipPath addCurveToPoint:CGPointMake(57.34, 35.92) controlPoint1:CGPointMake(56.75, 36.59) controlPoint2:CGPointMake(56.83, 36.31)];
    [clipPath addCurveToPoint:CGPointMake(58.73, 32.29) controlPoint1:CGPointMake(58.23, 35.22) controlPoint2:CGPointMake(58.73, 33.88)];
    [clipPath addCurveToPoint:CGPointMake(53.84, 27.34) controlPoint1:CGPointMake(58.73, 29.55) controlPoint2:CGPointMake(56.61, 27.34)];
    [clipPath addLineToPoint:CGPointMake(43.86, 27.34)];
    [clipPath addCurveToPoint:CGPointMake(39.64, 23.96) controlPoint1:CGPointMake(41.32, 27.34) controlPoint2:CGPointMake(39.64, 26.03)];
    [clipPath addCurveToPoint:CGPointMake(44.4, 8.16) controlPoint1:CGPointMake(39.64, 20.1) controlPoint2:CGPointMake(44.4, 13.17)];
    [clipPath addCurveToPoint:CGPointMake(40.48, 4) controlPoint1:CGPointMake(44.4, 5.57) controlPoint2:CGPointMake(42.69, 4)];
    [clipPath addCurveToPoint:CGPointMake(36.35, 7.52) controlPoint1:CGPointMake(38.47, 4) controlPoint2:CGPointMake(37.44, 5.4)];
    [clipPath addCurveToPoint:CGPointMake(22.26, 28.04) controlPoint1:CGPointMake(32.21, 15.74) controlPoint2:CGPointMake(26.56, 22.36)];
    [clipPath addCurveToPoint:CGPointMake(16.75, 43.69) controlPoint1:CGPointMake(18.62, 32.9) controlPoint2:CGPointMake(16.84, 36.98)];
    [clipPath addCurveToPoint:CGPointMake(38.11, 61.97) controlPoint1:CGPointMake(16.61, 54) controlPoint2:CGPointMake(24.97, 61.86)];
    [clipPath addLineToPoint:CGPointMake(41.99, 62)];
    [clipPath addCurveToPoint:CGPointMake(49.72, 61.4) controlPoint1:CGPointMake(45.51, 62.02) controlPoint2:CGPointMake(48.13, 61.77)];
    [clipPath addLineToPoint:CGPointMake(49.72, 61.4)];
    [clipPath closePath];
    
    [clipPath moveToPoint:CGPointMake(3, 43.89)];
    [clipPath addCurveToPoint:CGPointMake(14.18, 28.37) controlPoint1:CGPointMake(3, 35.19) controlPoint2:CGPointMake(7.86, 28.37)];
    [clipPath addLineToPoint:CGPointMake(18.29, 28.37)];
    [clipPath addLineToPoint:CGPointMake(17.96, 28.79)];
    [clipPath addCurveToPoint:CGPointMake(12.95, 43.61) controlPoint1:CGPointMake(15.56, 31.9) controlPoint2:CGPointMake(13.06, 36.82)];
    [clipPath addCurveToPoint:CGPointMake(20.22, 59.29) controlPoint1:CGPointMake(12.84, 50.01) controlPoint2:CGPointMake(15.16, 55.6)];
    [clipPath addLineToPoint:CGPointMake(15.21, 59.29)];
    [clipPath addCurveToPoint:CGPointMake(3, 43.89) controlPoint1:CGPointMake(8.23, 59.29) controlPoint2:CGPointMake(3, 52.27)];
    [clipPath closePath];
    [clipPath addClip];
    
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(-2.02, -1, 65.75, 68)];
    [color setFill];
    [rectanglePath fill];
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
}

@end

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


#import "ACStatusIconBookmarkView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconBookmarkView () <ACStatusIconDrawable>

@end

@implementation ACStatusIconBookmarkView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 40, 53) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 40.0, CGRectGetHeight(resizedFrame) / 53.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(4.15, 52)];
    [bezierPath addCurveToPoint:CGPointMake(1, 48.46) controlPoint1:CGPointMake(2.4, 52) controlPoint2:CGPointMake(1, 50.93)];
    [bezierPath addLineToPoint:CGPointMake(1, 8.67)];
    [bezierPath addCurveToPoint:CGPointMake(8.6, 1) controlPoint1:CGPointMake(1, 3.63) controlPoint2:CGPointMake(3.61, 1)];
    [bezierPath addLineToPoint:CGPointMake(31.29, 1)];
    [bezierPath addCurveToPoint:CGPointMake(38.88, 8.67) controlPoint1:CGPointMake(36.27, 1) controlPoint2:CGPointMake(38.88, 3.63)];
    [bezierPath addLineToPoint:CGPointMake(38.88, 48.46)];
    [bezierPath addCurveToPoint:CGPointMake(35.71, 52) controlPoint1:CGPointMake(38.88, 50.93) controlPoint2:CGPointMake(37.46, 52)];
    [bezierPath addCurveToPoint:CGPointMake(32.52, 50.32) controlPoint1:CGPointMake(34.39, 52) controlPoint2:CGPointMake(33.55, 51.3)];
    [bezierPath addLineToPoint:CGPointMake(21.04, 39.35)];
    [bezierPath addCurveToPoint:CGPointMake(19.94, 38.74) controlPoint1:CGPointMake(20.56, 38.91) controlPoint2:CGPointMake(20.24, 38.74)];
    [bezierPath addCurveToPoint:CGPointMake(18.85, 39.35) controlPoint1:CGPointMake(19.64, 38.74) controlPoint2:CGPointMake(19.34, 38.88)];
    [bezierPath addLineToPoint:CGPointMake(8.5, 49.18)];
    [bezierPath addLineToPoint:CGPointMake(7.65, 49.97)];
    [bezierPath addCurveToPoint:CGPointMake(4.15, 52) controlPoint1:CGPointMake(6.04, 51.46) controlPoint2:CGPointMake(5.31, 52)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

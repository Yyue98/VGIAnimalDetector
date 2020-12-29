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


#import "ACStatusIconDocumentView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconDocumentView () <ACStatusIconDrawable>

@end

@implementation ACStatusIconDocumentView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 70, 87) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 70.0, CGRectGetHeight(resizedFrame) / 87.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(13.73, 86.65)];
    [bezierPath addLineToPoint:CGPointMake(55.38, 86.65)];
    [bezierPath addCurveToPoint:CGPointMake(68.11, 73.76) controlPoint1:CGPointMake(63.77, 86.65) controlPoint2:CGPointMake(68.11, 82.2)];
    [bezierPath addLineToPoint:CGPointMake(68.11, 38.84)];
    [bezierPath addLineToPoint:CGPointMake(38.81, 38.84)];
    [bezierPath addCurveToPoint:CGPointMake(31.59, 31.61) controlPoint1:CGPointMake(33.93, 38.84) controlPoint2:CGPointMake(31.59, 36.49)];
    [bezierPath addLineToPoint:CGPointMake(31.59, 2)];
    [bezierPath addLineToPoint:CGPointMake(13.73, 2)];
    [bezierPath addCurveToPoint:CGPointMake(1, 14.85) controlPoint1:CGPointMake(5.38, 2) controlPoint2:CGPointMake(1, 6.41)];
    [bezierPath addLineToPoint:CGPointMake(1, 73.76)];
    [bezierPath addCurveToPoint:CGPointMake(13.73, 86.65) controlPoint1:CGPointMake(1, 82.23) controlPoint2:CGPointMake(5.38, 86.65)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(39.55, 33.13)];
    [bezierPath addCurveToPoint:CGPointMake(37.29, 30.87) controlPoint1:CGPointMake(38.07, 33.13) controlPoint2:CGPointMake(37.33, 32.39)];
    [bezierPath addLineToPoint:CGPointMake(37.29, 2.39)];
    [bezierPath addCurveToPoint:CGPointMake(42.8, 5.91) controlPoint1:CGPointMake(39.09, 2.63) controlPoint2:CGPointMake(40.84, 3.95)];
    [bezierPath addLineToPoint:CGPointMake(64.16, 27.59)];
    [bezierPath addLineToPoint:CGPointMake(64.68, 28.12)];
    [bezierPath addCurveToPoint:CGPointMake(67.72, 33.13) controlPoint1:CGPointMake(66.41, 29.95) controlPoint2:CGPointMake(67.5, 31.49)];
    [bezierPath addLineToPoint:CGPointMake(39.55, 33.13)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}
 
@end

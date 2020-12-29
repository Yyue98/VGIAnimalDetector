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


#import "ACStatusIconCardView.h"
#import "ACStatusIconDrawable.h"

@interface ACStatusIconCardView () <ACStatusIconDrawable>
@end

@implementation ACStatusIconCardView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawInRect:rect resizeMode:ACStatusIconConvasResizeModeAspectFit color:self.tintColor];
}

- (void)drawInRect:(CGRect)rect resizeMode:(ACStatusIconConvasResizeMode)mode color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [ACStatusIconConvas applyRect:CGRectMake(0, 0, 67, 59) withTarget:rect resizeMode:mode];
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame) / 67.0, CGRectGetHeight(resizedFrame) / 59.0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(3, 18.02)];
    [bezierPath addLineToPoint:CGPointMake(63.06, 18.02)];
    [bezierPath addLineToPoint:CGPointMake(63.06, 15.48)];
    [bezierPath addCurveToPoint:CGPointMake(54.47, 7) controlPoint1:CGPointMake(63.06, 9.84) controlPoint2:CGPointMake(60.19, 7)];
    [bezierPath addLineToPoint:CGPointMake(11.59, 7)];
    [bezierPath addCurveToPoint:CGPointMake(3, 15.48) controlPoint1:CGPointMake(5.84, 7) controlPoint2:CGPointMake(3, 9.84)];
    [bezierPath addLineToPoint:CGPointMake(3, 18.02)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(3, 44.55)];
    [bezierPath addCurveToPoint:CGPointMake(11.59, 53) controlPoint1:CGPointMake(3, 50.18) controlPoint2:CGPointMake(5.84, 53)];
    [bezierPath addLineToPoint:CGPointMake(54.47, 53)];
    [bezierPath addCurveToPoint:CGPointMake(63.06, 44.55) controlPoint1:CGPointMake(60.19, 53) controlPoint2:CGPointMake(63.06, 50.18)];
    
    [bezierPath addLineToPoint:CGPointMake(63.06, 24.23)];
    [bezierPath addLineToPoint:CGPointMake(3, 24.23)];
    [bezierPath addLineToPoint:CGPointMake(3, 44.55)];
    [bezierPath closePath];
    
    [bezierPath moveToPoint:CGPointMake(12.13, 37.88)];
    [bezierPath addLineToPoint:CGPointMake(12.13, 32.82)];
    [bezierPath addCurveToPoint:CGPointMake(14.81, 30.19) controlPoint1:CGPointMake(12.13, 31.29) controlPoint2:CGPointMake(13.2, 30.19)];
    [bezierPath addLineToPoint:CGPointMake(21.51, 30.19)];
    [bezierPath addCurveToPoint:CGPointMake(24.2, 32.82) controlPoint1:CGPointMake(23.13, 30.19) controlPoint2:CGPointMake(24.2, 31.29)];
    [bezierPath addLineToPoint:CGPointMake(24.22, 37.88)];
    [bezierPath addCurveToPoint:CGPointMake(21.51, 40.5) controlPoint1:CGPointMake(24.2, 39.44) controlPoint2:CGPointMake(23.13, 40.5)];
    [bezierPath addLineToPoint:CGPointMake(14.81, 40.5)];
    [bezierPath addCurveToPoint:CGPointMake(12.13, 37.88) controlPoint1:CGPointMake(13.2, 40.5) controlPoint2:CGPointMake(12.13, 39.44)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    CGContextRestoreGState(context);
}

@end

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


#import "ACStatusIconConvas.h"

@implementation ACStatusIconConvas

+ (CGRect)applyRect:(CGRect)rect withTarget:(CGRect)target resizeMode:(ACStatusIconConvasResizeMode)mode {
    if (CGRectEqualToRect(rect, target) || CGRectEqualToRect(target, CGRectZero)) {
        return rect;
    }
    
    CGSize scales = CGSizeZero;
    scales.width = fabs(CGRectGetWidth(target) / CGRectGetWidth(rect));
    scales.height = fabs(CGRectGetHeight(target) / CGRectGetHeight(rect));
    
    switch (mode) {
        case ACStatusIconConvasResizeModeAspectFit: {
            scales.width = MIN(scales.width, scales.height);
            scales.height = scales.width;
        }
            break;
        case ACStatusIconConvasResizeModeAspectFill: {
            scales.width = MAX(scales.width, scales.height);
            scales.height = scales.width;
        }
            break;
        case ACStatusIconConvasResizeModeStretch:   break;
        case ACStatusIconConvasResizeModeCenter: {
            scales.width = 1;
            scales.height = 1;
        }
            break;
    }
    
    CGRect result = CGRectStandardize(rect);
    result.size.width *= scales.width;
    result.size.height *= scales.height;
    result.origin.x = CGRectGetMinX(target) + (CGRectGetWidth(target) - CGRectGetWidth(result)) / 2;
    result.origin.y = CGRectGetMinY(target) + (CGRectGetHeight(target) - CGRectGetHeight(result)) / 2;
    return result;
}

@end

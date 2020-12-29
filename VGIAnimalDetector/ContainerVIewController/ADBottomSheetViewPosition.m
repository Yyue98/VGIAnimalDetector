//
//  ADBottomSheetViewPosition.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADBottomSheetViewPosition.h"

@implementation ADBottomSheetViewPosition

- (instancetype)initWithPosition:(ADBottomSheetPosition)position edgeInsets:(UIEdgeInsets)insets {
    self = [super init];
    if (self) {
        _position = position;
        _edgeInsets = insets;
    }
    
    return self;
}

@end

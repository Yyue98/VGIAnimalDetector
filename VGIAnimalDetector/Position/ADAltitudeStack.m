//
//  ADAltitudeStack.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADAltitudeStack.h"

@interface ADAltitudeStack ()
@property (nonatomic, assign)   NSUInteger  stackSize;
@property (nonatomic, strong)   NSMutableArray  *stack;
@end

@implementation ADAltitudeStack

- (instancetype)initWithSize:(NSUInteger)size {
    self = [super init];
    if (self) {
        _stackSize = size;
        _stack = @[].mutableCopy;
    }
    
    return self;
}
- (void)addAltitudeRelativeValue:(NSNumber *)value {
    if ([_stack count] == _stackSize) {
        [_stack removeObjectAtIndex:0];
    }
    
    [_stack addObject:value];
}

- (BOOL)readyForOutput {
    return [_stack count] == _stackSize;
}

- (double)meanAltitudeValue {
    double sum = 0;
    for (NSNumber *number in _stack) {
        sum += [number doubleValue];
    }
    
    return sum / _stackSize;
}

@end

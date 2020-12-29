//
//  NSPointerArray+Helper.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "NSPointerArray+Helper.h"

@implementation NSPointerArray (Helper)
- (NSUInteger)indexOfObject:(id)object {
    if (!object) return NSNotFound;
    
    NSPointerArray *array = [self copy];
    for (NSUInteger i = 0; i < array.count; i++) {
        if ([array pointerAtIndex:i] == (__bridge void *)object) {
            return i;
        }
    }
    
    return NSNotFound;
}

- (BOOL)containsObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    return index != NSNotFound;
}

- (void)addObject:(id)object {
    if (![self containsObject:object]) {
        [self addPointer:(__bridge void *)object];
    }
}

- (void)removeObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    if (index != NSNotFound) {
        [self removePointerAtIndex:index];
    }
}

- (void)quickCompact {
    [self addPointer:NULL];
    [self compact];
}

@end

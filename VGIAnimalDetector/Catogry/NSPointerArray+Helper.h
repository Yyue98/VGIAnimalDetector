//
//  NSPointerArray+Helper.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSPointerArray (Helper)

- (NSUInteger)indexOfObject:(id)object;
- (BOOL)containsObject:(id)object;
- (void)addObject:(id)object;
- (void)removeObject:(id)object;
- (void)quickCompact;

@end

NS_ASSUME_NONNULL_END

//
//  ADTileCollectionChanges.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADTileCollectionChanges.h"

@implementation ADTileCollectionChanges
- (instancetype)initWithEntered:(NSArray<NSString *> *)entered exited:(NSArray<NSString *> *)exited remained:(NSArray<NSString *> *)remained {
    self = [super init];
    if (!self) return nil;
    
    _entered = entered;
    _exited = exited;
    _remained = remained;
    return self;
}

@end

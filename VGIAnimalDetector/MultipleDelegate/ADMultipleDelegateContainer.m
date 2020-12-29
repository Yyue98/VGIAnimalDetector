//
//  ADMultipleDelegateContainer.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "ADMultipleDelegateContainer.h"
#import "NSPointerArray+Helper.h"
#import <QMUIKit/NSObject+QMUIMultipleDelegates.h>

@interface ADMultipleDelegateContainer () <ADMultipleDelegateDestruction>
@property (nonatomic, strong)   NSPointerArray  *delegates;
@end

@implementation ADMultipleDelegateContainer

- (instancetype)init {
    self = [super init];
    if (self) {
        _delegates = [NSPointerArray strongObjectsPointerArray];
    }
    
    return self;
}

+ (instancetype)sharedContainer {
    static dispatch_once_t onceToken;
    static ADMultipleDelegateContainer *_container = nil;
    dispatch_once(&onceToken, ^{
        _container = [ADMultipleDelegateContainer new];
    });
    
    return _container;
}

- (void)storeMultipleDelegate:(ADMultipleDelegate *)delegate {
    [_delegates addObject:delegate];
    delegate.destructionDelegate = self;
}

- (void)removeMultipleDelegate:(ADMultipleDelegate *)delegate {
    [_delegates removeObject:delegate];
}

#pragma mark - ADMultipleDelegateDestruction
- (void)multipleDelegateDidRemoveAllDelegates:(ADMultipleDelegate *)delegate {
    [self removeMultipleDelegate:delegate];
}

@end


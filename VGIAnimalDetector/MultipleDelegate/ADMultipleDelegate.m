//
//  ADMultipleDelegate.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "ADMultipleDelegate.h"
#import "NSPointerArray+Helper.h"
#import <QMUIKit/NSObject+QMUIMultipleDelegates.h>

@interface ADMultipleDelegate ()
@property (nonatomic, strong)   Protocol    *protocol;
@property (nonatomic, strong)   NSPointerArray  *delegates;
@property (nonatomic, strong)   NSInvocation    *forwardingInvocation;
@end

@implementation ADMultipleDelegate

- (instancetype)initWithProtocol:(Protocol *)protocol {
    NSAssert(protocol, @"Protocol should not be nil");
    self = [super init];
    if (self) {
        _protocol = protocol;
        _delegates = [NSPointerArray weakObjectsPointerArray];
    }
    
    return self;
}

- (void)addDelegate:(id)delegate {
    if ([delegate conformsToProtocol:self.protocol]) {
        [_delegates addObject:delegate];
    }
}

- (void)removeDelegate:(id)delegate {
    [_delegates removeObject:delegate];
    
    if ([_delegates count]) return;
    if (self.destructionDelegate && [self.destructionDelegate respondsToSelector:@selector(multipleDelegateDidRemoveAllDelegates:)]) {
        [self.destructionDelegate multipleDelegateDidRemoveAllDelegates:self];
    }
}

- (void)removeAllDelegates {
    for (NSInteger i = self.delegates.count - 1; i >= 0; i--) {
        [self.delegates removePointerAtIndex:i];
    }
    
    if (self.destructionDelegate && [self.destructionDelegate respondsToSelector:@selector(multipleDelegateDidRemoveAllDelegates:)]) {
        [self.destructionDelegate multipleDelegateDidRemoveAllDelegates:self];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = anInvocation.selector;
    
    // https://github.com/Tencent/QMUI_iOS/issues/970
    if (self.forwardingInvocation.selector != NULL && self.forwardingInvocation.selector == selector) {
        NSUInteger returnLength = anInvocation.methodSignature.methodReturnLength;
        if (returnLength) {
            void *buffer = (void *)malloc(returnLength);
            [self.forwardingInvocation getReturnValue:buffer];
            [anInvocation setReturnValue:buffer];
            free(buffer);
        }
        return;
    }
    
    NSPointerArray *delegates = self.delegates.copy;
    for (id delegate in delegates) {
        if ([delegate respondsToSelector:selector]) {
            self.forwardingInvocation = anInvocation;
            [anInvocation invokeWithTarget:delegate];
        }
    }

    self.forwardingInvocation = nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *result = nil;
    NSPointerArray *delegates = self.delegates.copy;
    for (id delegate in delegates) {
        result = [delegate methodSignatureForSelector:aSelector];
        if (result && [delegate respondsToSelector:aSelector]) {
            return result;
        }
    }
    
    return [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    
    NSPointerArray *delegates = self.delegates.copy;
    for (id delegate in delegates) {
        if (class_respondsToSelector(self.class, aSelector)) {
            return YES;
        }
        
        // https://github.com/Tencent/QMUI_iOS/issues/357
        BOOL delegateCanRespondToSelector = [delegate isKindOfClass:[ADMultipleDelegate class]] ? [delegate respondsToSelector:aSelector] : class_respondsToSelector(object_getClass(delegate), aSelector);
        if (delegateCanRespondToSelector) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    BOOL result = [super conformsToProtocol:aProtocol];
    if (result) return YES;
        
    NSPointerArray *delegates = self.delegates.copy;
    for (id delegate in delegates) {
        if ([delegate conformsToProtocol:aProtocol]) return YES;
    }
    
    return NO;
}

@end

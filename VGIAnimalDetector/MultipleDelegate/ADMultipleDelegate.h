//
//  ADMultipleDelegate.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@class ADMultipleDelegate;
@protocol ADMultipleDelegateDestruction <NSObject>

- (void)multipleDelegateDidRemoveAllDelegates:(ADMultipleDelegate *)delegate;

@end

@interface ADMultipleDelegate : NSObject

@property (nonatomic, weak) id <ADMultipleDelegateDestruction>  destructionDelegate;

- (instancetype)initWithProtocol:(Protocol *)protocol;
- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;
- (void)removeAllDelegates;

@end

NS_ASSUME_NONNULL_END

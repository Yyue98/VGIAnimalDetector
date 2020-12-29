//
//  ADMultipleDelegateContainer.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import <Foundation/Foundation.h>
#import "ADMultipleDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADMultipleDelegateContainer : NSObject

@property (class, readonly, strong) ADMultipleDelegateContainer *sharedContainer;

- (void)storeMultipleDelegate:(ADMultipleDelegate *)delegate;
- (void)removeMultipleDelegate:(ADMultipleDelegate *)delegate;

@end

NS_ASSUME_NONNULL_END

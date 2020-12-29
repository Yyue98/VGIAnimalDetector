//
//  ADTileCollectionChanges.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import "ADTileRegion.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADTileCollectionChanges : NSObject

@property (nonatomic, copy) NSArray <NSString *>    *entered;
@property (nonatomic, copy) NSArray <NSString *>    *exited;
@property (nonatomic, copy) NSArray <NSString *>    *remained;

- (instancetype)initWithEntered:(NSArray <NSString *> *)entered
                         exited:(NSArray <NSString *> *)exited
                       remained:(NSArray <NSString *> *)remained;

@end

NS_ASSUME_NONNULL_END

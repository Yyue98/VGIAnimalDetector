//
//  ADMapImplement.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import "ADMapService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADMapImplement : NSObject <ADMapService>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end

NS_ASSUME_NONNULL_END

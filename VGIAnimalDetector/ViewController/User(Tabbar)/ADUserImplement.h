//
//  ADUserImplement.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ADUserService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADUserImplement : NSObject <ADUserService>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end

NS_ASSUME_NONNULL_END

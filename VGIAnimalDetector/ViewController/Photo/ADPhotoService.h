//
//  ADPhotoService.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ADContainerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ADPhotoService <NSObject>

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(nullable void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END

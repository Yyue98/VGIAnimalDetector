//
//  ADLoginService.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ADLoginService <NSObject>

- (void)pushViewModel:(id)viewModel;
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)flag completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END

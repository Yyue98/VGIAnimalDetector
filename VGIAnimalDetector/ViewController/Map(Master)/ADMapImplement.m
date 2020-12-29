//
//  ADMapImplement.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADMapImplement.h"
#import "UIViewController+ADContainerViewController.h"

@interface ADMapImplement ()
@property (nonatomic, weak) UINavigationController  *navigationController;
@end

@implementation ADMapImplement

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        _navigationController = navigationController;
    }
    
    return self;
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    [_navigationController presentViewController:viewController animated:animated completion:completion];
}
@end

//
//  ADLoginImplement.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADLoginImplement.h"
//#import "ADRegisterViewModel.h"
//#import "ADRegisterViewController.h"

@interface ADLoginImplement ()
@property (nonatomic, weak) UINavigationController  *navigationController;
@end

@implementation ADLoginImplement

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        _navigationController = navigationController;
    }
    
    return self;
}

- (void)pushViewModel:(id)viewModel {
//    if ([viewModel isKindOfClass:[SPRegisterViewModel class]]) {
//        SPRegisterViewController *viewController = [[SPRegisterViewController alloc] initWithViewModel:viewModel];
//        [_navigationController pushViewController:viewController animated:YES];
//    }
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)flag completion:(void (^)(void))completion {
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [_navigationController presentViewController:viewController animated:flag completion:completion];
}

@end

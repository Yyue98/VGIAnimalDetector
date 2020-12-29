//
//  ADUserImplement.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADUserImplement.h"
#import "ADCatViewModel.h"
#import "ADCatViewController.h"
#import "ADRecordViewModel.h"
#import "ADRecordViewController.h"
#import "ADLoginViewModel.h"
#import "ADLoginViewController.h"

@interface ADUserImplement ()
@property (nonatomic, weak) UINavigationController  *navigationController;
@end

@implementation ADUserImplement

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        _navigationController = navigationController;
    }
    
    return self;
}

- (void)pushViewModel:(id)viewModel {
    if ([viewModel isKindOfClass:[ADCatViewModel class]]) {
        ADCatViewController *viewController = [[ADCatViewController alloc] initWithViewModel:viewModel];
        [_navigationController pushViewController:viewController animated:YES];
    } else if ([viewModel isKindOfClass:[ADRecordViewModel class]]) {
        ADRecordViewController *viewController = [[ADRecordViewController alloc] initWithViewModel:viewModel];
        [_navigationController pushViewController:viewController animated:YES];
    } else if ([viewModel isKindOfClass:[ADLoginViewModel class]]) {
        ADLoginViewController *viewController = [[ADLoginViewController alloc] initWithViewModel:viewModel];
        [_navigationController pushViewController:viewController animated:YES];
    }
}
@end

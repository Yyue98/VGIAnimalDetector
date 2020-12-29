//
//  ADPhotoImplement.m
//  SmartParking
//
//  Created by Wenzhi WU on 3/2/2020.
//  Copyright © 2020 Wenzhi WU. All rights reserved.
//

#import "ADPhotoImplement.h"
#import "UIViewController+ADContainerViewController.h"

@interface ADPhotoImplement ()
@property (nonatomic, weak) UINavigationController  *navigationController;
@end

@implementation ADPhotoImplement

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

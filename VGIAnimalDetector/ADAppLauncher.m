//
//  ADAppLauncher.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADAppLauncher.h"
#import <YYKit/UIImage+YYAdd.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <ChameleonFramework/Chameleon.h>
#import <QMUIKit/QMUIKit.h>
//#import "ACNotificationCenter.h"
#import "ADMapImplement.h"
#import "ADMapViewModel.h"
#import "ADMapViewController.h"
#import "ADUserImplement.h"
#import "ADUserViewModel.h"
#import "ADUserViewController.h"
#import "ADPhotoImplement.h"
#import "ADPhotoViewModel.h"
#import "ADPhotoViewController.h"
#import "ADAppSceneManager.h"
//#import "ACNewAPIManager.h"
//#import "ACStyleLayerManager.h"
#import "ADMapboxController.h"


@interface ADAppLauncher ()

@end

@implementation ADAppLauncher

+ (instancetype)sharedLauncher {
    static ADAppLauncher *_launcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _launcher = [ADAppLauncher new];
    });
    
    return _launcher;
}

- (instancetype)init {
    self = [super init];
    if (self) {
//        _accountManager = [ADAccountManager new];
    }
    
    return self;
}

- (void)launchApplicationWithWindow:(UIWindow *)window {
    
    _window = window;
    _sceneManager = [ADAppSceneManager new];
    

    [self enterMapViewController];
    [_window makeKeyAndVisible];
}

- (void)logout {
    [self cleanUp];
}


- (void)enterMapViewController {
    UIViewController *masterViewController = [self masterViewController];
//    UIViewController <ADBottomSheetController> *bottomSheetController = [self searchViewController];

    ADContainerViewController *containerViewController = [[ADContainerViewController alloc]     initWithMasterViewController:masterViewController navigationBarController:nil bottomSheetController:nil];

    NSArray *viewControllers = @[containerViewController,
                                 [self photoViewController],
                                 [self userViewController]];
    NSArray *attributes = @[@{CYLTabBarItemTitle : NSLocalizedString(@"地图", nil),
                              CYLTabBarItemImage : [self mapImageSelected:NO],
                              CYLTabBarItemSelectedImage : [self mapImageSelected:YES]},
                            @{CYLTabBarItemTitle : NSLocalizedString(@"拍照", nil),
                              CYLTabBarItemImage : [self carImageSelected:NO],
                              CYLTabBarItemSelectedImage : [self carImageSelected:YES]},
                            @{CYLTabBarItemTitle : NSLocalizedString(@"图鉴", nil),
                              CYLTabBarItemImage : [self userImageSelected:NO],
                              CYLTabBarItemSelectedImage : [self userImageSelected:YES]}];
    CYLTabBarController *tabbarController = [[CYLTabBarController alloc] initWithViewControllers:viewControllers tabBarItemsAttributes:attributes];
    tabbarController.tabBarHeight = [self tabBarHeight];
    [tabbarController.tabBar setBarTintColor:[UIColor whiteColor]];
    tabbarController.viewControllers = @[containerViewController,
                                         [self photoViewController],
                                         [self userViewController]];
    _window.rootViewController = tabbarController;
    _tabBarController = tabbarController;
    _containerViewController = containerViewController;
}

- (void)cleanUp {
//    [[ACStyleLayerManager sharedManager] removeFromMapView];
    [[ADMapboxController sharedController] removeFromMapView];
    _containerViewController = nil;
}

- (CGFloat)tabBarHeight {
    CGFloat height = 60;
    if (_window.safeAreaInsets.bottom) {
        return height += _window.safeAreaInsets.bottom;
    }
    
    return height;
}

- (UIViewController *)masterViewController {
    UINavigationController *navigationController = [UINavigationController new];
    ADMapImplement *service = [[ADMapImplement alloc] initWithNavigationController:navigationController];
    ADMapViewModel *viewModel = [[ADMapViewModel alloc] initWithService:service];
    ADMapViewController *controller = [[ADMapViewController alloc] initWithViewModel:viewModel];
    [navigationController pushViewController:controller animated:NO];
    return navigationController;
}



- (UIViewController *)photoViewController {
    UINavigationController *navigationController = [UINavigationController new];
    ADPhotoImplement *service = [[ADPhotoImplement alloc] initWithNavigationController:navigationController];
    ADPhotoViewModel *viewModel = [[ADPhotoViewModel alloc] initWithService:service];
    ADPhotoViewController *viewController = [[ADPhotoViewController alloc] initWithViewModel:viewModel];
    [navigationController pushViewController:viewController animated:NO];
    return navigationController;
}

- (UIViewController *)userViewController {
    UINavigationController *navigationController = [UINavigationController new];
    ADUserImplement *service = [[ADUserImplement alloc] initWithNavigationController:navigationController];
    ADUserViewModel *viewModel = [[ADUserViewModel alloc] initWithService:service];
    ADUserViewController *viewController = [[ADUserViewController alloc] initWithViewModel:viewModel];
    [navigationController pushViewController:viewController animated:NO];
    return navigationController;
}

- (UIImage *)mapImageSelected:(BOOL)selected {
    CGFloat size = 36;
    UIColor *color = selected ? [UIColor systemBlueColor] : [UIColor lightGrayColor];
    FAKMaterialIcons *icon = [FAKMaterialIcons mapIconWithSize:size];
    [icon addAttribute:NSForegroundColorAttributeName value:color];

    return [icon imageWithSize:CGSizeMake(size, size)];
}

- (UIImage *)carImageSelected:(BOOL)selected {
    CGFloat size = 36;
    UIColor *color = selected ? [UIColor systemBlueColor] : [UIColor lightGrayColor];
    FAKMaterialIcons *icon = [FAKMaterialIcons imageIconWithSize:size];
    [icon addAttribute:NSForegroundColorAttributeName value:color];
    return [icon imageWithSize:CGSizeMake(size, size)];
}

- (UIImage *)userImageSelected:(BOOL)selected {
    CGFloat size = 36;
    UIColor *color = selected ? [UIColor systemBlueColor] : [UIColor lightGrayColor];
    FAKMaterialIcons *icon = [FAKMaterialIcons homeIconWithSize:size];
    [icon addAttribute:NSForegroundColorAttributeName value:color];
    return [icon imageWithSize:CGSizeMake(size, size)];
}

@end

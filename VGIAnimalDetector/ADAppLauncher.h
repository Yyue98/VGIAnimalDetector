//
//  ADAppLauncher.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CYLTabBarController/CYLTabBarController.h>
#import "ADContainerViewController.h"
#import "ADAppSceneManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADAppLauncher : NSObject

@property (nonatomic, assign)   BOOL    notificationGranted;
@property (nonatomic, weak) UIWindow    *window;
@property (nonatomic, weak) ADContainerViewController   *containerViewController;
@property (nonatomic, weak) CYLTabBarController *tabBarController;
@property (nonatomic, strong)   ADAppSceneManager   *sceneManager;

+ (instancetype)sharedLauncher;
- (void)launchApplicationWithWindow:(UIWindow *)window;


@end

NS_ASSUME_NONNULL_END

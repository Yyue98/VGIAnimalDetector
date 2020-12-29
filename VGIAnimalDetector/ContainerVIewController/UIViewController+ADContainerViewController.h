//
//  UIViewController+ADContainerViewController.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>
#import "ADContainerViewController.h"

@interface UIViewController (ADContainerViewController)

/// Get container viewController recursively
- (ADContainerViewController *)ad_containerViewController;

@end

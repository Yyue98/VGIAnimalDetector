//
//  UIViewController+ADContainerViewController.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "UIViewController+ADContainerViewController.h"

@implementation UIViewController (ADContainerViewController)

- (ADContainerViewController *)ad_containerViewController {
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController) {
        if([parentViewController isKindOfClass:[ADContainerViewController class]]) {
            return (ADContainerViewController *)parentViewController;
        }
        
        parentViewController = parentViewController.parentViewController;
    }
    
    return nil;
}
@end

//
//  ADLoginViewController.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//


#import <UIKit/UIKit.h>
#import "ADLoginViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADLoginViewController : UITableViewController

- (instancetype)initWithViewModel:(ADLoginViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END

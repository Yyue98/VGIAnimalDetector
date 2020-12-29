//
//  ADUserViewController.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>
#import "ADUserViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADUserViewController : UITableViewController

- (instancetype)initWithViewModel:(ADUserViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END

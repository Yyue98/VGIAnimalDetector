//
//  ADCatViewController.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>
#import "ADCatViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADCatViewController : UITableViewController

- (instancetype)initWithViewModel:(ADCatViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END

//
//  ADRecordViewController.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>
#import "ADRecordViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADRecordViewController : UITableViewController

- (instancetype)initWithViewModel:(ADRecordViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END

//
//  ADPhotoViewController.h
//   VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>
#import "ADPhotoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADPhotoViewController : UITableViewController

- (instancetype)initWithViewModel:(ADPhotoViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END

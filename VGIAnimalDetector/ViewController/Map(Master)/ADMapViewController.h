//
//  ADMapViewController.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>
#import "ADMapViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADMapViewController : UIViewController

- (instancetype)initWithViewModel:(ADMapViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END

//
//  ADInformationTableViewHelper.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ADPhotoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADInformationTableViewHelper : NSObject


@property (nonatomic, strong) RACCommand  *submitCommand;

- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)selectionCommand ViewModel:(ADPhotoViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END

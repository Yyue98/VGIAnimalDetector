//
//  ADRecordTableViewHelper.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ADRecordViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADRecordTableViewHelper : NSObject
- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)selection viewModel:(ADRecordViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END

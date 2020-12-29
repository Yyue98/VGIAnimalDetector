//
//  ADUserTableHelper.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ADUserService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADUserTableViewHelper : NSObject

- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)selectionCommand service:(id<ADUserService>)service;

@end

NS_ASSUME_NONNULL_END

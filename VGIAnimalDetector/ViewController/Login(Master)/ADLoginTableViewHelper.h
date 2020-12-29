//
//  ADLoginTableViewHelper.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//


#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADLoginTableViewHelper : NSObject

- (instancetype)initWithTableView:(UITableView *)tableView usePassword:(RACSignal *)password submitCommand:(RACCommand *)submitCommand registerCommand:(RACCommand *)registerCommand wechatCommand:(RACCommand *)wechatCommand;

@end

NS_ASSUME_NONNULL_END

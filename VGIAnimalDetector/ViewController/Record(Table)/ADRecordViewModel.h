//
//  ADRecordViewModel.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ADRecordService.h"
#import "ADCatRecord.h"

NS_ASSUME_NONNULL_BEGIN
@class ADRecordViewModel;

@protocol ADRecordViewModelDelegate <NSObject>
@optional

- (void)recordModelDidRefresh:(ADRecordViewModel *)viewModel withRecords:(NSDictionary *)dic;

@end

@interface ADRecordViewModel : NSObject

@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSArray <ADCatRecord *>   *records;
@property (nonatomic, strong)   RACCommand  *selectionCommand;
@property (nonatomic, strong)   RACCommand  *refreshCommand;
@property (nonatomic, weak) id <ADRecordViewModelDelegate>  delegate;

- (instancetype)initWithService:(id <ADRecordService>)service;

@end

NS_ASSUME_NONNULL_END

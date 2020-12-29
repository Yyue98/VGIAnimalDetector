//
//  ADRecordViewModel.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADRecordViewModel.h"
#import "ADPositioningManager.h"
#import "ADAppLauncher.h"
#import "ADAPIManager.h"

@interface ADRecordViewModel ()
@property (nonatomic, strong)   id <ADRecordService>  service;
@end

@implementation ADRecordViewModel

- (instancetype)initWithService:(id<ADRecordService>)service {
    self = [super init];
    if (self) {
        _service = service;
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    _title = @"🐈猫咪足迹";
    _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @weakify(self);
            [[[ADAPIManager sharedManager] getRecordsForCatID:@"5fe98860014ab810588cd58d"] subscribeNext:^(id  _Nullable x) {
                    @strongify(self);
                NSDictionary *records = x;
                if (self.delegate && [self.delegate respondsToSelector:@selector(recordModelDidRefresh:withRecords:)]) {
                    [self.delegate recordModelDidRefresh:self withRecords:records];
                }
                    [subscriber sendNext:records];

                    [subscriber sendCompleted];
                
                } error:^(NSError * _Nullable error) {
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
    }];

    _selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

            [subscriber sendCompleted];
            return nil;
        }];
    }];
}


@end


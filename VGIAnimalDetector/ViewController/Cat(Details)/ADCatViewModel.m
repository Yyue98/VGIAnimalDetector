//
//  ADCatViewModel.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADCatViewModel.h"
#import "ADPositioningManager.h"
#import "ADAppLauncher.h"

@interface ADCatViewModel ()
@property (nonatomic, strong)   id <ADCatService>  service;
@end

@implementation ADCatViewModel

- (instancetype)initWithService:(id<ADCatService>)service {
    self = [super init];
    if (self) {
        _service = service;
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    _title = @"🐈猫咪信息";
//    _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            @weakify(self);
//            [[[ACAPIV2Manager sharedManager] getAllTransactionsForUserID:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]] subscribeNext:^(id  _Nullable x) {
//                @strongify(self);
//                self.transactions = x;
//                [subscriber sendNext:x];
//                [subscriber sendCompleted];
//            } error:^(NSError * _Nullable error) {
//                [subscriber sendCompleted];
//            }];
//
//            return nil;
//        }];
//    }];
//
//    _selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//            [subscriber sendCompleted];
//            return nil;
//        }];
//    }];
}


@end


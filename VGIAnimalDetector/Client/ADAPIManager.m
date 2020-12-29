//
//  ADAPIManager.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/28.
//

#import "ADAPIManager.h"
#import "ADCat.h"
#import "ADCatRecord.h"

@implementation ADAPIManager

+ (instancetype)sharedManager {
    static ADAPIManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 20;
        manager = [[ADAPIManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://47.110.86.123:8080/api/"] sessionConfiguration:configuration];
    });
    return manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(nullable NSURLSessionConfiguration *)configuration {
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:0];
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingFragmentsAllowed];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    }
    
    return self;
}

#pragma mark - Cat Information
- (RACSignal *)getAllCatsInformation {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSString *path = [NSString stringWithFormat:@"cat/info/many"];
        NSURLSessionDataTask *task = [self GET:path parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *details = responseObject[@"message"];
            if ([details isEqualToString:@"成功"]) {
                NSArray *data = responseObject[@"data"];
                NSMutableArray *mutable = @[].mutableCopy;
                for (NSDictionary *json in data) {
                    ADCat *cat = [ADCat modelWithJSON:json];
                    [mutable addObject:cat];
                }
                
                [subscriber sendNext:mutable.copy];
                [subscriber sendCompleted];
            } else {
                NSError *error = [self errorWithDetails:details];
                [subscriber sendError:error];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}
- (RACSignal *)getCatInformationForCatID:(NSString *)catID {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSString *path = [NSString stringWithFormat:@"cat/info/single/%@",catID];
        NSURLSessionDataTask *task = [self GET:path parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *details = responseObject[@"message"];
            if ([details isEqualToString:@"成功"]) {
                NSArray *data = responseObject[@"data"];
                ADCat *cat = [ADCat modelWithJSON:data];
                
                [subscriber sendNext:cat.copy];
                [subscriber sendCompleted];
            } else {
                NSError *error = [self errorWithDetails:details];
                [subscriber sendError:error];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}


#pragma mark - Cat Record
- (RACSignal *)getRecordsForCatID:(NSString *)catID {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSString *path = [NSString stringWithFormat:@"hisTrack/info/many/%@",catID];
        NSURLSessionDataTask *task = [self GET:path parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *details = responseObject[@"message"];
            if ([details isEqualToString:@"成功"]) {
                NSDictionary *data = responseObject[@"data"];
//                NSMutableArray *mutable = @[].mutableCopy;
//                for (NSDictionary *json in data) {
//                    ADCatRecord *record = [ADCatRecord modelWithJSON:json];
//                    [mutable addObject:record];
//                }
                
                [subscriber sendNext:data];
                [subscriber sendCompleted];
            } else {
                NSError *error = [self errorWithDetails:details];
                [subscriber sendError:error];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}
- (RACSignal *)addRecordWithCatRecord:(NSDictionary *)record {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSString *path = [NSString stringWithFormat:@"hisTrack/info/add/5fe98860014ab810588cd58d"];
        NSURLSessionDataTask *task = [self POST:path parameters:record headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *details = responseObject[@"message"];
            if ([details isEqualToString:@"成功"]) {
                NSArray *data = responseObject[@"data"];
                ADCatRecord *record = [ADCatRecord modelWithJSON:data];
                
                
                [subscriber sendNext:record.copy];
                [subscriber sendCompleted];
            } else {
                NSError *error = [self errorWithDetails:details];
                [subscriber sendError:error];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}


#pragma mark - Error
- (NSError *)errorWithDetails:(NSString *)details {
    return [NSError errorWithDomain:@"com.Vgi-animal-detector.api.error" code:500 userInfo:@{NSLocalizedDescriptionKey : details}];
}
@end

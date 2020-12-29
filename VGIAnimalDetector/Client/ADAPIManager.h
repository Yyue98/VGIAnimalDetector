//
//  ADAPIManager.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/28.
//

#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADAPIManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

#pragma mark - Cat Information
- (RACSignal *)getAllCatsInformation;
- (RACSignal *)getCatInformationForCatID:(NSString *)catID;


#pragma mark - Cat Record
- (RACSignal *)getRecordsForCatID:(NSString *)catID;
- (RACSignal *)addRecordWithCatRecord:(NSDictionary *)record;


@end

NS_ASSUME_NONNULL_END

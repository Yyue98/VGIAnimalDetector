//
//  ADCatRecord.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import "ADCatRecord.h"

@implementation ADCatRecord

- (instancetype)initWithcatID:(NSString *)catID
                      catName:(NSString *)name
                   coordinate:(CLLocationCoordinate2D)coordinate
                healthyStatus:(BOOL )healthy
                     needHelp:(BOOL )needHelp
                     location:(NSString *)location
                         time:(NSString *)time
                       remark:(NSString *)remark {
    self = [super init];
    if (!self) return nil;
    
    _catID = [catID copy];
    _catName = [name copy];
    _coordinate = coordinate;
    _healthyStatus = healthy;
    _needHelp = needHelp;
    _location = [location copy];
    _remark = [remark copy];
    _timestamp = [time copy];
    
    return self;
}

#pragma mark - YYModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"catID" : @"catId",
             @"catName" : @"name",
             @"location" : @"location",
             @"timestamp" : @"time",
             @"remark" : @"remark"
    };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    CLLocationDegrees latitude = [dic[@"latitude"] doubleValue];
    CLLocationDegrees longitude = [dic[@"longitude"] doubleValue];
    _coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
//    _timestamp =
    _needHelp = NO;
    _healthyStatus = YES;
    if ([[dic[@"needHelp"] stringValue] isEqualToString: @"1"]) {
        _needHelp = YES;
    }
    if ([[dic[@"healthy"] stringValue] isEqualToString: @"0"]) {
        _healthyStatus = NO;
    }
    return YES;
}


#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    ADCatRecord *copy = [[ADCatRecord allocWithZone:zone] init];

    copy.catID = _catID;
    copy.catName = _catName;
    copy.healthyStatus = _healthyStatus;
    copy.needHelp = _needHelp;
    copy.coordinate = _coordinate;
    copy.location = _location;
    copy.remark = _remark;
    copy.timestamp = _timestamp;
    return copy;
}

@end

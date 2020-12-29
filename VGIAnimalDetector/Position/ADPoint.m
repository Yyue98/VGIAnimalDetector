//
//  ADPoint.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADPoint.h"

@implementation ADPoint
- (instancetype)initWithPointID:(NSString *)pointID coordinate:(CLLocationCoordinate2D)coordinate levelCode:(NSString *)levelCode entityType:(ADEntityType)type
{
    self = [super init];
    if (!self) return nil;
    
    _pointID = [pointID copy];
    _coordinate = coordinate;
    _levelCode = [levelCode copy];
    _entityType = type;
    return self;
}

#pragma mark - YYModel
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"levelCode" : @"level",
             @"buildingID" : @"building_id",
             @"entityType" : @"weight"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    CLLocationDegrees latitude = [dic[@"lat"] doubleValue];
    CLLocationDegrees longitude = [dic[@"lon"] doubleValue];
    _coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return YES;
}

- (BOOL)isEqual:(id)object
{
    if (!object || ![object isKindOfClass:[ADPoint class]]) return NO;
    return [self isEqualToPoint:object];
}

- (BOOL)isEqualToPoint:(ADPoint *)point
{
    return self.coordinate.latitude == point.coordinate.latitude &&
    self.coordinate.longitude == point.coordinate.longitude &&
    [self.levelCode isEqualToString:point.levelCode] &&
    self.entityType == point.entityType;
}

- (NSUInteger)hash
{
    NSString *latitude = @(self.coordinate.latitude).stringValue;
    NSString *longitude = @(self.coordinate.longitude).stringValue;
    return [self.pointID hash] ^ [latitude hash] ^ [longitude hash] ^ [self.levelCode hash] ^ [@(self.entityType).stringValue hash];
}

- (id)copyWithZone:(NSZone *)zone
{
    ADPoint *copy = [[ADPoint allocWithZone:zone] initWithPointID:_pointID
                                                       coordinate:_coordinate
                                                        levelCode:_levelCode
                                                       entityType:_entityType];
    return copy;
}
@end

//
//  ADLocation.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADLocation.h"

@implementation ADLocation

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                           heading:(CLLocationDegrees)heading
                        sourceType:(ADPositioningSourceType)type
                         accuracy:(ADPositioningSourceAccuracy)accuracy
                         levelCode:(NSString *)levelCode
                         timestamp:(NSDate *)timestamp {
    self = [super init];
    if (!self) return nil;
    
    _coordinate = coordinate;
    _heading = heading;
    _sourceType = type;
    _accuracy = accuracy;
    _levelCode = [levelCode copy];
    _timestamp = [timestamp copy];
    return self;
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    ADLocation *copy = [[ADLocation allocWithZone:zone] initWithCoordinate:_coordinate
                                                                   heading:_heading
                                                                sourceType:_sourceType
                                                                 accuracy:_accuracy
                                                                 levelCode:_levelCode
                                                                 timestamp:_timestamp];
    return copy;
}

@end

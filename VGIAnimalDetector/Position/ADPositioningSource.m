//
//  ADPositioningSource.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADPositioningSource.h"

@implementation ADPositioningSource
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate sourceType:(ADPositioningSourceType)type accuracy:(ADPositioningSourceAccuracy)accuracy levelCode:(NSString *)levelCode {
    self = [super init];
    if (!self) return nil;
    
    _coordinate = coordinate;
    _type = type;
    _accuracy = accuracy;
    _levelCode = levelCode;
    return self;
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    ADPositioningSource *copy = [[ADPositioningSource alloc] initWithCoordinate:_coordinate
                                                                     sourceType:_type
                                                                       accuracy:_accuracy
                                                                      levelCode:_levelCode];
    return copy;
}

@end

//
//  ADCat.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import "ADCat.h"

@implementation ADCat

- (instancetype)initWithcatID:(NSString *)catID
                      catName:(NSString *)name
                       gender:(NSString *)gender
                     outlook:(NSString *)outlook
                   character:(NSString *)character
             scopeOfActivity:(NSString *)scopeOfActivity
                      remark:(NSString *)remark
                        image:(UIImage *)image {
    self = [super init];
    if (!self) return nil;
    
    _catID = [catID copy];
    _catName = [name copy];
    _gender = [gender copy];
    _outlook = [outlook copy];
    _character = [character copy];
    _scopeOfActivity = [scopeOfActivity copy];
    _remark = [remark copy];
    _image = [image copy];
    
    return self;
}

#pragma mark - YYModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"catID" : @"_id",
             @"catName" : @"name",
             @"gender" : @"gender",
             @"outlook" : @"outlook",
             @"character": @"character",
             @"scopeOfActivity" : @"scopeOfActivity",
             @"remark" : @"remark",
             @"image" : @"photo"
    };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    return YES;
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    ADCat *copy = [[ADCat allocWithZone:zone] init];

    copy.catID = _catID;
    copy.catName = _catName;
    copy.gender = _gender;
    copy.outlook = _outlook;
    copy.character = _character;
    copy.scopeOfActivity = _scopeOfActivity;
    copy.remark = _remark;
    copy.image = _image;
    
    return copy;
}

@end

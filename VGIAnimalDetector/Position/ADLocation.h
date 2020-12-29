//
//  ADLocation.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ADPositioningManagerTypeDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADLocation : NSObject <NSCopying>

@property (nonatomic, assign)   CLLocationDegrees   heading;
@property (nonatomic, assign)   CLLocationCoordinate2D  coordinate;
@property (nonatomic, assign)   ADPositioningSourceType  sourceType;
@property (nonatomic, assign)   ADPositioningSourceAccuracy accuracy;
@property (nonatomic, assign)   CLLocationDistance  altitude;
@property (nonatomic, copy) NSString    *levelCode;
@property (nonatomic, copy) NSDate  *timestamp;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                           heading:(CLLocationDegrees)heading
                        sourceType:(ADPositioningSourceType)type
                          accuracy:(ADPositioningSourceAccuracy)accuracy
                         levelCode:(NSString *)levelCode
                         timestamp:(NSDate *)timestamp;

@end

NS_ASSUME_NONNULL_END

//
//  ADPositioningSource.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ADPositioningManagerTypeDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADPositioningSource : NSObject <NSCopying>

@property (nonatomic, assign)   CLLocationCoordinate2D  coordinate;
@property (nonatomic, assign)   ADPositioningSourceType type;
@property (nonatomic, assign)   ADPositioningSourceAccuracy accuracy;
@property (nonatomic, assign)   CLLocationDistance  altitude;
@property (nonatomic, copy) NSString    *levelCode;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                        sourceType:(ADPositioningSourceType)type
                          accuracy:(ADPositioningSourceAccuracy)accuracy
                         levelCode:(NSString *)levelCode;

@end

NS_ASSUME_NONNULL_END

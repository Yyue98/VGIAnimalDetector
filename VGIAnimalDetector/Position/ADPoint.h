//
//  ADPoint.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <YYKit/NSObject+YYModel.h>
#import "ADEntityTypeDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADPoint : NSObject <NSCopying, YYModel>

@property (nonatomic, copy, nullable)   NSString    *pointID;
@property (nonatomic, assign)   CLLocationCoordinate2D  coordinate;
@property (nonatomic, assign)   ADEntityType entityType;
@property (nonatomic, copy) NSString    *levelCode;
@property (nonatomic, copy) NSString    *buildingID;

- (instancetype)initWithPointID:(nullable NSString *)pointID
                     coordinate:(CLLocationCoordinate2D)coordinate
                      levelCode:(NSString *)levelCode
                     entityType:(ADEntityType)type;

@end

NS_ASSUME_NONNULL_END

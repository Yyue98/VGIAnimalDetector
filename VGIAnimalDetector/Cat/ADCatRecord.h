//
//  ADCatRecord.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import <Foundation/Foundation.h>
#import <YYKit/NSObject+YYModel.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADCatRecord : NSObject <YYModel, NSCopying>

@property (nonatomic, copy) NSString    *catID;
@property (nonatomic, copy) NSString    *catName;
@property (nonatomic, assign)   BOOL    healthyStatus;  //是否健康
@property (nonatomic, assign) BOOL    needHelp;         //是否需要帮助
@property (nonatomic, assign)   CLLocationCoordinate2D  coordinate; //位置（经度，纬度）
@property (nonatomic, copy) NSString    *location;      //拍摄地点的大致描述，方便定位
@property (nonatomic, copy)   NSString  *timestamp; //记录的时间
@property (nonatomic, copy) NSString    *remark;       //其他补充

- (instancetype)initWithcatID:(NSString *)catID
                      catName:(NSString *)name
                   coordinate:(CLLocationCoordinate2D)coordinate
                healthyStatus:(BOOL )healthy
                     needHelp:(BOOL )needHelp
                     location:(NSString *)location
                         time:(NSString *)time
                       remark:(NSString *)remark;
@end

NS_ASSUME_NONNULL_END

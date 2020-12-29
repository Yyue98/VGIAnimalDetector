//
//  ADCat.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import <Foundation/Foundation.h>
#import <YYKit/NSObject+YYModel.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADCat : NSObject <YYModel, NSCopying>

@property (nonatomic, copy) NSString    *catID; //猫咪id
@property (nonatomic, copy) NSString    *catName;//猫咪名字
@property (nonatomic, copy) NSString    *gender;    //性别
@property (nonatomic, copy) NSString    *outlook;    //外表特征
@property (nonatomic, copy) NSString    *character;   //性格特征
@property (nonatomic, copy) NSString    *scopeOfActivity;      //常出现的范围
@property (nonatomic, copy) NSString    *remark;       //其他描述
@property (nonatomic, copy) UIImage    *image;       


- (instancetype)initWithcatID:(NSString *)catID
                      catName:(NSString *)name
                       gender:(NSString *)gender
                      outlook:(NSString *)appearance
                    character:(NSString *)temperament
              scopeOfActivity:(NSString *)location
                       remark:(NSString *)details
                        image:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END

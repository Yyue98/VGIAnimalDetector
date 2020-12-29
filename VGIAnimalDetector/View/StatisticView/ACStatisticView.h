//
//  ACStatisticView.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import <UIKit/UIKit.h>
#import <YYKit/YYLabel.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACStatisticView : UIView

@property (nonatomic, strong)   YYLabel *totalLabel;
@property (nonatomic, strong)   YYLabel *spaceLabel;
@property (nonatomic, copy) UIColor *themeColor;

@end

NS_ASSUME_NONNULL_END

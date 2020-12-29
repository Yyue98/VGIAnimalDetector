//
//  ADCatDetailCell.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import <UIKit/UIKit.h>
#import "SPBorderLableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADCatDetailCell : UITableViewCell
@property (nonatomic, strong)   SPBorderLableView *contentLabel;
@property (nonatomic, strong)   UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END

//
//  ADRecordSummaryCell.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADRecordSummaryCell : UITableViewCell
@property (nonatomic, strong)   UIImageView *iconView;
@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UILabel *statusLabel;
@property (nonatomic, strong)   UILabel *timeLabel;
@property (nonatomic, strong)   UILabel *locationLabel;
@property (nonatomic, strong)   UILabel *positionLabel;

@end

NS_ASSUME_NONNULL_END

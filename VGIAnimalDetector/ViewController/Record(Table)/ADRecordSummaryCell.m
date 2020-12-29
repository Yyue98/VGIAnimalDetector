//
//  ADRecordSummaryCell.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import "ADRecordSummaryCell.h"
#import <Masonry/Masonry.h>

@implementation ADRecordSummaryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconView = [UIImageView new];
        _iconView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLabel];
        
        _statusLabel = [UILabel new];
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.numberOfLines = 1;
        _statusLabel.textColor = [UIColor lightGrayColor];
        _statusLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_statusLabel];
        
        _timeLabel = [UILabel new];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.numberOfLines = 1;
        _timeLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:_timeLabel];
        
        _locationLabel = [UILabel new];
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        _locationLabel.numberOfLines = 1;
        _locationLabel.textColor = [UIColor lightGrayColor];
        _locationLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_locationLabel];
        
        _positionLabel = [UILabel new];
        _positionLabel.textAlignment = NSTextAlignmentLeft;
        _positionLabel.numberOfLines = 1;
        _positionLabel.textColor = [UIColor lightGrayColor];
        _positionLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_positionLabel];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(8);
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(12);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        }];
        
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(12);
            make.top.equalTo(self.contentView.mas_top).offset(8);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
        }];
        
        [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(12);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(4);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
        }];
        
        [_positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(12);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
            make.top.equalTo(self.locationLabel.mas_bottom).offset(4);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
        }];
    }
    
    return self;
}
@end

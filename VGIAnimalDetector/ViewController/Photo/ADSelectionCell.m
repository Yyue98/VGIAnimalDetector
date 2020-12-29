//
//  ADSelectionCell.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/26.
//

#import "ADSelectionCell.h"
#import <Masonry/Masonry.h>

@implementation ADSelectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _switchView = [UISwitch new];
        _switchView.contentMode = UIViewContentModeScaleAspectFit;
        _switchView.onTintColor = [UIColor systemGreenColor];
        _switchView.tintColor = [UIColor systemGrayColor];

//        _textFiled.delegate = self;
        [self.contentView addSubview:_switchView];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        _yesLabel = [UILabel new];
        _yesLabel.font = [UIFont systemFontOfSize:16];
        _yesLabel.textColor = [UIColor darkGrayColor];
        _yesLabel.textAlignment = NSTextAlignmentCenter;
        _yesLabel.text = @"是";
        [self.contentView addSubview:_yesLabel];
        
        _noLabel = [UILabel new];
        _noLabel.font = [UIFont systemFontOfSize:16];
        _noLabel.textColor = [UIColor lightGrayColor];
        _noLabel.textAlignment = NSTextAlignmentCenter;
        _noLabel.text = @"否";
        [self.contentView addSubview:_noLabel];
        
        _onView = [UIImageView new];
        [self.contentView addSubview:_onView];
        
        _offView = [UIImageView new];
        [self.contentView addSubview:_offView];
        
        CGFloat margin = 12;
       
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(margin);
            make.right.equalTo(self.contentView.mas_centerX).offset(-80);
            make.top.equalTo(self.contentView.mas_top).offset(margin);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-margin);
        }];
        
        [_switchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX).offset(margin*5);
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        
        [_yesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.switchView.mas_right).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(margin);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-margin);
        }];
        
        [_noLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.switchView.mas_left).offset(-20);
            make.top.equalTo(self.contentView.mas_top).offset(margin);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-margin);
        }];
        
        [_offView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.noLabel.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(36, 36));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [_onView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.yesLabel.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(36, 36));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        

    }
    
    return self;
}


@end

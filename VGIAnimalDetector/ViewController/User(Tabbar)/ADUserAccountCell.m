//
//  ADUserAccountCell.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADUserAccountCell.h"
#import <Masonry/Masonry.h>

@implementation ADUserAccountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarView = [UIImageView new];
        _avatarView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_avatarView];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        CGFloat margin = 12;
        [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(margin);
            make.size.mas_equalTo(CGSizeMake(66, 66));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarView.mas_right).offset(margin);
            make.right.equalTo(self.contentView.mas_right).offset(-margin);
            make.top.equalTo(self.contentView.mas_top).offset(margin);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-margin);
        }];
    }
    
    return self;
}

@end

//
//  ADCatItemCell.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import "ADCatItemCell.h"
#import <Masonry/Masonry.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <ChameleonFramework/Chameleon.h>

@implementation ADCatItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _contentLabel = [SPBorderLableView new];
        _contentLabel.contentMode = UIViewContentModeScaleAspectFit;
        _contentLabel.backgroundColor = [UIColor flatPinkColor];
        _contentLabel.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _contentLabel.contentInsets = UIEdgeInsetsMake(4, 12, 4, 12);
        _contentLabel.titleLabel.textColor = [UIColor whiteColor];
        _contentLabel.layer.cornerRadius = 6;
        [self.contentView addSubview:_contentLabel];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        CGFloat margin = 12;
       
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(margin);
            make.right.equalTo(self.contentView.mas_centerX).offset(-80);
            make.top.equalTo(self.contentView.mas_top).offset(margin);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-margin);
        }];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(margin);
            make.right.equalTo(self.contentView.mas_right).offset(-margin);
            make.top.equalTo(self.contentView.mas_top).offset(margin);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-margin);
            
        }];
    }
    
    return self;
}


@end

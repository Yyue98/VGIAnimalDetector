//
//  ADAddPhotoCell.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/26.
//

#import "ADAddPhotoCell.h"
#import <Masonry/Masonry.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <ChameleonFramework/Chameleon.h>
#import "ADColorCompatibility.h"

@implementation ADAddPhotoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImage *image = [UIImage imageNamed:@"icon-add-image"];
        
        _addButton = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageWithImage:image scaledToSize:CGSizeMake(66, 66)] title:nil];
        [self.contentView addSubview:_addButton];
        
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
        
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX).offset(40);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.top.equalTo(self.contentView.mas_top).offset(6);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-6);
            
        }];
    }
    
    return self;
}

@end

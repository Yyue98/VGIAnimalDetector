//
//  ADInformationCell.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/24.
//

#import "ADInformationCell.h"
#import <Masonry/Masonry.h>

@implementation ADInformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _textFiled = [UITextField new];
        _textFiled.contentMode = UIViewContentModeScaleAspectFit;
        _textFiled.font =  [UIFont systemFontOfSize:18];
        _textFiled.delegate = self;
        [self.contentView addSubview:_textFiled];
        
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
        
        [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(margin);
            make.right.equalTo(self.contentView.mas_right).offset(-margin);
            make.top.equalTo(self.contentView.mas_top).offset(margin);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-margin);
            
        }];
    }
    
    return self;
}

#pragma mark - UITextFiled Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

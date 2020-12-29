//
//  ADTextFieldTableViewCell.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADTextFieldTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation ADTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [ADInputTextField new];
        [self.contentView addSubview:_textField];
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(14);
            make.right.equalTo(self.contentView.mas_right).offset(-14);
            make.top.equalTo(self.contentView.mas_top).offset(6);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-6);
        }];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

@end

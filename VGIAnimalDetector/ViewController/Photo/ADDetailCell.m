//
//  ADDetailCell.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/26.
//

#import "ADDetailCell.h"
#import <Masonry/Masonry.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import "ADColorCompatibility.h"

@implementation ADDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textView = [UITextView new];
        self.textView.delegate = self;
        self.textView.layer.borderWidth = 1.0;//边宽
        self.textView.layer.cornerRadius = 5.0;//设置圆角
        self.textView.alpha = 1.0; // 设置透明度
        self.textView.scrollEnabled = YES;//是否可以拖动
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.textView.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_textView];
        
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
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.right.equalTo(self.contentView.mas_right).offset(-margin);
            make.top.equalTo(self.contentView.mas_top).offset(margin);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-margin);
            
        }];
    }
    
    return self;
}

#pragma mark - UITextView Delegate Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if ([text isEqualToString:@"\n"]) {

        [textView resignFirstResponder];

        return NO;

    }

    return YES;

}

@end

//
//  ADLoginHelperFooterView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADLoginHelperFooterView.h"
#import <Masonry/Masonry.h>
#import "ADColorCompatibility.h"

@interface ADLoginHelperFooterView ()
@property (nonatomic, strong)   UIView  *seperator;
@end

@implementation ADLoginHelperFooterView

- (instancetype)init {
    self = [super init];
    if (self) {
        _seperator = [UIView new];
        _seperator.backgroundColor = [ADColorCompatibility tertiarySystemFillColor];
        [self addSubview:_seperator];
        
        _forgotButton = [UIButton new];
        [_forgotButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgotButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_forgotButton setTitleColor:[ADColorCompatibility systemGrayColor] forState:UIControlStateNormal];
        [self addSubview:_forgotButton];
        
        _registerButton = [UIButton new];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_registerButton setTitleColor:[ADColorCompatibility systemGrayColor] forState:UIControlStateNormal];
        [self addSubview:_registerButton];
        
        _submitButton = [QMUIFillButton new];
        _submitButton.fillColor = [ADColorCompatibility systemBlueColor];
        _submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_submitButton setTitle:@"登录" forState:UIControlStateNormal];
        _submitButton.cornerRadius = 8;
        [self addSubview:_submitButton];
        
        _wechatButton = [QMUIFillButton new];
        _wechatButton.fillColor = [ADColorCompatibility systemGreenColor];
        _wechatButton.imageView.contentMode = UIViewContentModeCenter;
        [_wechatButton setImage:[UIImage imageNamed:@"wechat-icon"] forState:UIControlStateNormal];
        [self addSubview:_wechatButton];
        
        [_wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(52, 52));
            make.bottom.equalTo(self.mas_bottom).offset(-8);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [_seperator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(self.wechatButton.mas_top).offset(-32);
        }];
        
        [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.seperator.mas_top).offset(-32);
        }];
        
        [_forgotButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top).offset(8);
            make.bottom.equalTo(self.submitButton.mas_top).offset(-8);
        }];
        
        [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top).offset(8);
            make.bottom.equalTo(self.submitButton.mas_top).offset(-8);
        }];
    }
    
    return self;
}

@end

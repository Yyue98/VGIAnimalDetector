//
//  ACStatisticView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "ACStatisticView.h"
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@implementation ACStatisticView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.borderWidth = 1.5;
        self.layer.cornerRadius = 4;
        
        _totalLabel = [YYLabel new];
        _totalLabel.textContainerInset = UIEdgeInsetsMake(2, 6, 2, 6);
        [self addSubview:_totalLabel];
        
        _spaceLabel = [YYLabel new];
        _spaceLabel.textContainerInset = UIEdgeInsetsMake(2, 6, 2, 6);
        [self addSubview:_spaceLabel];
        
        [_spaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_greaterThanOrEqualTo(@20);
        }];
        
        [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.spaceLabel.mas_right);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_greaterThanOrEqualTo(@20);
        }];
    }
    
    return self;
}

- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    _spaceLabel.backgroundColor = themeColor;
    _totalLabel.textColor = themeColor;
    _spaceLabel.textColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:themeColor isFlat:YES];
    self.layer.borderColor = themeColor.CGColor;
}

@end

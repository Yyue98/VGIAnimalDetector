//
//  SPBorderLableView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "SPBorderLableView.h"
#import <Masonry/Masonry.h>

@implementation SPBorderLableView

- (instancetype)init {
    self = [super init];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 1;
        [self addSubview:_titleLabel];
        
        _contentInsets = UIEdgeInsetsMake(2, 4, 2, 4);
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentInsets);
        }];
    }
    
    return self;
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(contentInsets);
    }];
}

@end

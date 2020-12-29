//
//  ADCatImageCell.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import "ADCatImageCell.h"
#import <Masonry/Masonry.h>

@implementation ADCatImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _catImage = [UIImageView new];
        _catImage.contentMode = UIViewContentModeScaleAspectFit;
        _catImage.image = [UIImage imageNamed:@"小花狸"];
        [self addSubview:_catImage];
        
        [_catImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(400, 360));
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
            make.top.equalTo(self.contentView.mas_top).offset(20);
        }];
    }
    
    return self;
}


@end

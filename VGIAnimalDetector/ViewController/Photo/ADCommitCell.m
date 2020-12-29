//
//  ADCommitCell.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/26.
//

#import "ADCommitCell.h"
#import <Masonry/Masonry.h>

@implementation ADCommitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _commitButton = [UIButton new];
        _commitButton.backgroundColor = [UIColor systemGreenColor];
        
        _commitButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [self.contentView addSubview:_commitButton];

        [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(12);
            make.right.equalTo(self.contentView.mas_right).with.offset(-12);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-6);
            make.height.mas_equalTo(50);
        }];
        
    }
    
    return self;
}


@end

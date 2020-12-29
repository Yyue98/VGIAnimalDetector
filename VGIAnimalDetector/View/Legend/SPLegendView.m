//
//  SPLegendView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "SPLegendView.h"
#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

#define LIGHT_SIZE  12

@interface SPLegendView ()
@property (nonatomic, strong)   UIStackView *stackView;
@end

@implementation SPLegendView

- (instancetype)init {
    self = [super init];
    if (self) {
        UIStackView *stack = [UIStackView new];
        stack.axis = UILayoutConstraintAxisHorizontal;
        stack.alignment = UIStackViewAlignmentCenter;
        stack.distribution = UIStackViewDistributionEqualSpacing;
        stack.spacing = 6;
        _stackView = stack;
        [self addSubview:_stackView];
        
        [_stackView addArrangedSubview:[self lightWithColor:FlatSkyBlue]];
        [_stackView addArrangedSubview:[self labelWithText:NSLocalizedString(@"空闲", nil)]];
        [_stackView addArrangedSubview:[self lightWithColor:FlatYellow]];
        [_stackView addArrangedSubview:[self labelWithText:NSLocalizedString(@"紧张", nil)]];
        [_stackView addArrangedSubview:[self lightWithColor:FlatRed]];
        [_stackView addArrangedSubview:[self labelWithText:NSLocalizedString(@"满员", nil)]];
        
        [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 8, 0, 8));
        }];
    }
    
    return self;
}

- (UIView *)lightWithColor:(UIColor *)color {
    UIView *view = [UIView new];
    view.backgroundColor = color;
    view.layer.cornerRadius = LIGHT_SIZE / 2.0;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LIGHT_SIZE, LIGHT_SIZE));
    }];
    return view;
}

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [UILabel new];
    label.numberOfLines = 1;
    label.font = [UIFont boldSystemFontOfSize:14];
    label.text = text;
    [label sizeToFit];
    return label;
}

@end

//
//  UIView+Shadow.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "UIView+Shadow.h"
#import <Masonry/Masonry.h>

@implementation UIView (Shadow)

- (void)addShadowWithCornerRadius:(double)radius {
    [self addShadowWithCornerRadius:radius contentInsets:UIEdgeInsetsZero];
}

- (void)addShadowWithCornerRadius:(double)radius contentInsets:(UIEdgeInsets)insets {
    ACShadowView *shadow = [[ACShadowView alloc] initWithCornerRadius:radius
                                                          shadowColor:[UIColor lightGrayColor]
                                                         shadowOffset:CGSizeMake(0, 1)
                                                        shadowOpacity:0.6
                                                         shadowRadius:2
                                                          contentView:self];
    [shadow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(insets);
    }];
}

- (UIView *)layoutView {
    if (self.superview && [self.superview isKindOfClass:[ACShadowView class]]) {
        return self.superview;
    }
    
    return self;
}

@end

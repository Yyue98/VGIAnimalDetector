//
//  UIView+ACEffectView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//
#import "UIView+ACEffectView.h"
#import "ACEffectView.h"
#import <Masonry/Masonry.h>

@implementation UIView (ACEffectView)

- (void)addBlurEffectWithStyle:(UIBlurEffectStyle)style {
    if (self.superview) {
        NSLog(@"UIView already has superview, effect background ignored to add");
        return;
    }
    
    ACEffectView *view = [[ACEffectView alloc] initWithEffectStyle:style];
    [view.contentView addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (ACEffectView *)effectView {
    if ([self.superview.superview isKindOfClass:[ACEffectView class]]) {
        return (ACEffectView *)self.superview.superview;
    }
    
    return nil;
}

@end

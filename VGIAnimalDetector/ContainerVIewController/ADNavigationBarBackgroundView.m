//
//  ADNavigationBarBackgroundView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADNavigationBarBackgroundView.h"

@interface ADNavigationBarBackgroundView ()

/// Content view for navigation bar content
@property (nonatomic, weak) UIView  *contentView;

@end

@implementation ADNavigationBarBackgroundView

- (void)layoutContentView:(UIView *)view {
    _contentView = view;
    [self addSubview:_contentView];
    [self setNeedsLayout];
}

- (void)removeContentView {
    if (_contentView) {
        [_contentView removeFromSuperview];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_contentView) {
        _contentView.frame = self.bounds;
    }
}

@end

//
//  ADUserLocationView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/9.
//

#import "ADUserLocationView.h"
#import "ADUserLocationNormalArrow.h"
#import "ADUserLocationNavigationArrow.h"

@interface ADUserLocationView ()
@property (nonatomic, strong)   ADUserLocationNavigationArrow   *navigationArrow;
@property (nonatomic, strong)   ADUserLocationNormalArrow   *normalArrow;
@end

@implementation ADUserLocationView

- (instancetype)initWithSize:(CGFloat)size {
    self = [super init];
    if (self) {
        _normalArrow = [[ADUserLocationNormalArrow alloc] initWithSize:size];
        _navigationArrow = [[ADUserLocationNavigationArrow alloc] initWithSize:size];
        [self addSubview:_normalArrow];
        [self addSubview:_navigationArrow];
    }
    
    return self;
}

- (void)setStyleColor:(UIColor *)styleColor {
    [_normalArrow setStyleColor:styleColor];
    [_navigationArrow setStyleColor:styleColor];
}

- (void)setRotation:(CGAffineTransform)rotation {
    [_normalArrow setRotation:rotation];
    [_navigationArrow setRotation:rotation];
}

- (void)setShowHeadingIndicator:(BOOL)showHeadingIndicator {
    [_normalArrow showHeadingIndicator:showHeadingIndicator];
    [_navigationArrow showHeadingIndicator:showHeadingIndicator];
}

- (void)setNavigationMode:(BOOL)navigationMode {
    _normalArrow.hidden = navigationMode;
    _navigationArrow.hidden = !navigationMode;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat size = CGRectGetWidth(self.bounds);
    _navigationArrow.frame = CGRectMake((size - _navigationArrow.size) / 2.0,
                                        (size - _navigationArrow.size) / 2.0,
                                        _navigationArrow.size,
                                        _navigationArrow.size);
    
    _normalArrow.frame = CGRectMake((size - _normalArrow.size) / 2.0,
                                    (size - _normalArrow.size) / 2.0,
                                    _normalArrow.size,
                                    _normalArrow.size);
}


@end

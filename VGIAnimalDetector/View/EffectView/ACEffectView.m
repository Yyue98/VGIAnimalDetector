//
//  ACEffectView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//
#import "ACEffectView.h"

@implementation ACEffectView

- (instancetype)initWithEffectStyle:(UIBlurEffectStyle)style {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    self = [super initWithEffect:effect];
    if (self) {
        self.layer.cornerRadius = 4.0;
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 1);
    }
    
    return self;
}

@end

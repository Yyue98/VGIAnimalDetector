//
//  SPPositioningModeButton.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//
#import "SPPositioningModeButton.h"
#import <FontAwesomeKit/FontAwesomeKit.h>

@implementation SPPositioningModeButton

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeCenter;
        [self updateButtonIcon];
    }
    
    return self;
}

- (void)setAutomotiveMode:(BOOL)automotiveMode {
    _automotiveMode = automotiveMode;
    [self updateButtonIcon];
}

- (UIImage *)imageForPositioningMode {
    FAKIcon *icon = _automotiveMode ? [FAKMaterialIcons carIconWithSize:24] : [FAKMaterialIcons walkIconWithSize:24];
    [icon addAttribute:NSForegroundColorAttributeName value:[UIColor systemBlueColor]];
    return [icon imageWithSize:CGSizeMake(24, 24)];
}

- (void)updateButtonIcon {
    UIImage *image = [self imageForPositioningMode];
    [self setImage:image forState:UIControlStateNormal];
}


@end

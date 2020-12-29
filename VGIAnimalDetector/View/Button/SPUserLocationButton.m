//
//  SPUserLocationButton.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "SPUserLocationButton.h"
#import <ChameleonFramework/Chameleon.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import "ADColorCompatibility.h"

@implementation SPUserLocationButton

- (instancetype)initWithButtonMode:(SPUserLocationButtonMode)mode {
    self = [super init];
    if (self) {
        _buttonMode = mode;
        self.contentMode = UIViewContentModeCenter;
        self.cornerRadius = 4;
        [self updateButtonIcon];
    }

    return self;
}

- (void)setButtonMode:(SPUserLocationButtonMode)buttonMode {
    if (_buttonMode == buttonMode) return;
    
    _buttonMode = buttonMode;
    [self updateButtonIcon];
}

- (UIImage *)imageForButtonMode:(SPUserLocationButtonMode)mode {
    switch (mode) {
        case SPUserLocationButtonModeNone: {
            FAKIcon *icon = [FAKMaterialIcons compassIconWithSize:24];
            [icon addAttribute:NSForegroundColorAttributeName value:[ADColorCompatibility systemGrayColor]];
            return [icon imageWithSize:CGSizeMake(24, 24)];
        }
            break;
            
        case SPUserLocationButtonModeFollow: {
            FAKIcon *icon = [FAKMaterialIcons compassIconWithSize:24];
            [icon addAttribute:NSForegroundColorAttributeName value:[ADColorCompatibility systemBlueColor]];
            return [icon imageWithSize:CGSizeMake(24, 24)];
        }
            break;
        
        case SPUserLocationButtonModeFollowWithHeading: {
            FAKIcon *icon = [FAKMaterialIcons navigationIconWithSize:24];
            [icon addAttribute:NSForegroundColorAttributeName value:[ADColorCompatibility systemBlueColor]];
            return [icon imageWithSize:CGSizeMake(24, 24)];
        }
            break;
            
        case SPUserLocationButtonModeFollowRouteBearing: {
            FAKMaterialIcons *icon = [FAKMaterialIcons eyeIconWithSize:24];
            [icon addAttribute:NSForegroundColorAttributeName value:[ADColorCompatibility systemBlueColor]];
            return [icon imageWithSize:CGSizeMake(24, 24)];
        }
            break;
        
        case SPUserLocationButtonModeReviewNavigationContent:
        default: {
            FAKMaterialIcons *icon = [FAKMaterialIcons pinIconWithSize:24];
            [icon addAttribute:NSForegroundColorAttributeName value:[ADColorCompatibility systemBlueColor]];
            return [icon imageWithSize:CGSizeMake(24, 24)];
        }
    }
}

- (void)updateButtonIcon {
    UIImage *image = [self imageForButtonMode:_buttonMode];
    [self setImage:image forState:UIControlStateNormal];
}

@end

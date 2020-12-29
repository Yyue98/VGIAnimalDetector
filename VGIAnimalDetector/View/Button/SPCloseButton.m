//
//  SPCloseButton.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "SPCloseButton.h"
#import <FontAwesomeKit/FontAwesomeKit.h>

@implementation SPCloseButton

- (instancetype)init {
    self = [super init];
    if (self) {
        CGFloat size = 32;
        FAKIonIcons *closeIcon = [FAKIonIcons iosCloseEmptyIconWithSize:size];
        [closeIcon addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor]];
        UIImage *closeImage = [closeIcon imageWithSize:CGSizeMake(size, size)];
        
        self.fillColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        [self setImage:closeImage forState:UIControlStateNormal];
    }
    
    return self;
}

@end

// Copyright (c) 2020 mrcrow <wwz.michael@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "ACStatusView.h"
#import <CoreGraphics/CoreGraphics.h>
#import "ACStatusIconLayout.h"
#import "ACStatusIconAnimatable.h"
#import "ACStatusIconAddView.h"
#import "ACStatusIconBoltView.h"
#import "ACStatusIconBookmarkView.h"
#import "ACStatusIconCardView.h"
#import "ACStatusIconCartView.h"
#import "ACStatusIconDislikeView.h"
#import "ACStatusIconDocumentView.h"
#import "ACStatusIconDoneView.h"
#import "ACStatusIconEjectView.h"
#import "ACStatusIconErrorView.h"
#import "ACStatusIconExclamationView.h"
#import "ACStatusIconFlagView.h"
#import "ACStatusIconHeartView.h"
#import "ACStatusIconLikeView.h"
#import "ACStatusIconMessageView.h"
#import "ACStatusIconMoonView.h"
#import "ACStatusIconPrivacyView.h"
#import "ACStatusIconQuestionView.h"
#import "ACStatusIconRepeatView.h"
#import "ACStatusIconRotateView.h"
#import "ACStatusIconSearchView.h"
#import "ACStatusIconShuffleView.h"
#import "ACStatusIconStarView.h"

#define AC_BACKGROUND_WIDTH 250

@interface ACStatusView ()

/// View to disable user interaction on background.
@property (nonatomic, strong)   UIView  *noneInteractableView;
@end

@implementation ACStatusView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message iconType:(ACStatusIconType)type {
    UIView *iconView = [self viewForIconType:type];
    ACStatusIconLayout *layout = [self layoutForIconType:type];
    ACStatusHapticFeedbackType feedbackType = [self hapticFeedbackForIconType:type];
    return [self initWithTitle:title message:message iconView:iconView layout:layout hapticFeedbackType:feedbackType];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message iconImage:(UIImage *)image {
    UIImage *render = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:render];
    return [self initWithTitle:title message:message iconView:imageView layout:[ACStatusIconLayout new] hapticFeedbackType:ACStatusHapticFeedbackTypeNone];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message iconView:(UIView *)view {
    return [self initWithTitle:title message:message iconView:view layout:[ACStatusIconLayout new] hapticFeedbackType:ACStatusHapticFeedbackTypeNone];
}

- (instancetype)initWithMessage:(NSString *)message {
    return [self initWithTitle:nil message:message iconView:nil layout:[ACStatusIconLayout new] hapticFeedbackType:ACStatusHapticFeedbackTypeNone];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message iconView:(UIView *)view layout:(ACStatusIconLayout *)layout hapticFeedbackType:(ACStatusHapticFeedbackType)type {
    self = [super init];
    if (self) {
        _layout = layout;
        _iconView = view;
        _hapticFeedbackType = type;
        
        if (title && [title length]) {
            _titleLabel = [UILabel new];
            _titleLabel.text = title;
        }
        
        if (message && [message length]) {
            _subtitleLabel = [UILabel new];
            _subtitleLabel.text = message;
        }
        
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    _duration = 1.5;
    _dismissByTap = YES;
    _backgroundUserInteractable = YES;
    _keyWindow = [self presentWindow];
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
    
    BOOL darkMode = [self isDarkMode];
    UIColor *color = [self textColorForDarkMode:darkMode];
    
    _backgroundView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:darkMode ? UIBlurEffectStyleDark : UIBlurEffectStyleExtraLight]];
    _backgroundView.userInteractionEnabled = NO;
    [self addSubview:_backgroundView];
    
    if (_iconView) {
        _iconView.tintColor = color;
        _iconView.backgroundColor = [UIColor clearColor];
        [self addSubview:_iconView];
    }
    
    if (_titleLabel) {
        _titleLabel.font = [UIFont boldSystemFontOfSize:22];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = color;
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.lineSpacing = 3;
        style.alignment = NSTextAlignmentCenter;
        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:_titleLabel.text attributes:@{NSParagraphStyleAttributeName : style}];
        [self addSubview:_titleLabel];
    }
    
    if (_subtitleLabel) {
        _subtitleLabel.numberOfLines = 0;
        _subtitleLabel.textColor = color;
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.lineSpacing = 2;
        style.alignment = NSTextAlignmentCenter;
        _subtitleLabel.attributedText = [[NSAttributedString alloc] initWithString:_subtitleLabel.text attributes:@{NSParagraphStyleAttributeName : style}];
        [self addSubview:_subtitleLabel];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = AC_BACKGROUND_WIDTH;
    CGFloat sideSpace = 16;
    
    if (_iconView) {
        _iconView.frame = CGRectMake(0, _layout.topSpace, _layout.iconWidth, _layout.iconHeight);
        _iconView.center = CGPointMake(width / 2, _iconView.center.y);
    }
    
    if (_titleLabel) {
        CGFloat yPosition = (!_iconView) ? 32 : (_iconView.frame.origin.y + CGRectGetHeight(_iconView.frame) + _layout.bottomIconSpace);
        [self layoutLabel:_titleLabel x:sideSpace y:yPosition width:width - sideSpace * 2];
    }
    
    if (_subtitleLabel) {
        CGFloat yPosition = (!_titleLabel) ? 23 : _titleLabel.frame.origin.y + CGRectGetHeight(_titleLabel.frame) + 4;
        [self layoutLabel:_subtitleLabel x:sideSpace y:yPosition width:width - sideSpace * 2];
    }
    
    if (!_titleLabel && !_subtitleLabel) {
        _iconView.center = CGPointMake(width / 2, width / 2);
    }
    
    self.frame = CGRectMake(0, 0, width, [self calculateHeight]);
    self.center = CGPointMake(CGRectGetMidX(self.keyWindow.frame), CGRectGetMidY(self.keyWindow.frame));
    _backgroundView.frame = self.bounds;
}

- (void)layoutLabel:(UILabel *)label x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width {
    label.frame = CGRectMake(x, y, width, 0);
    [label sizeToFit];
    label.frame = CGRectMake(x, y, width, CGRectGetHeight(label.frame));
}

- (void)presentWithAutoHide:(BOOL)hide {
    [self generateHapticFeedback];
    [self applySubtitleFont];
    
    if (_dismissByTap) {
        UITapGestureRecognizer *tapGesterRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGesterRecognizer];
    }
    
    if (!_backgroundUserInteractable) {
        _noneInteractableView = [[UIView alloc] initWithFrame:_keyWindow.bounds];
        [_keyWindow addSubview:_noneInteractableView];
    }
    
    [_keyWindow addSubview:self];
    [self layoutIfNeeded];
    [self layoutSubviews];
    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform, 0.8, 0.8);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([self.iconView conformsToProtocol:@protocol(ACStatusIconAnimatable)]) {
            [(UIView <ACStatusIconAnimatable> *)self.iconView animate];
        }
        
        if (hide) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self dismiss];
                });
            });
        }
    }];
}

- (void)dismiss {
    if (!_backgroundUserInteractable) {
        [_noneInteractableView removeFromSuperview];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformScale(self.transform, 0.8, 0.8);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (CGFloat)calculateHeight {
    CGFloat height = 0;
    if (_subtitleLabel) {
        if (!_titleLabel) {
            height += _subtitleLabel.frame.origin.y * 2 + CGRectGetHeight(_subtitleLabel.frame);
        } else {
            height += _subtitleLabel.frame.origin.y + CGRectGetHeight(_subtitleLabel.frame) + _layout.bottomSpace;
        }
    } else {
        if (_titleLabel) {
            height += _titleLabel.frame.origin.y + CGRectGetHeight(_titleLabel.frame) + _layout.bottomSpace;
        } else {
            height = AC_BACKGROUND_WIDTH;
        }
    }
    
    return height;
}

- (BOOL)isDarkMode {
    if (@available(iOS 12.0, *)) {
        UIUserInterfaceStyle interfaceStyle = [UIApplication sharedApplication].windows.firstObject.traitCollection.userInterfaceStyle;
        return interfaceStyle == UIUserInterfaceStyleDark;
    } else {
        return NO;
    }
}

- (UIView *)presentWindow {
    if (@available(iOS 13.0, *)) {
        UIWindow *window;
        UIWindowScene *activeScene;
        for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *subWindow in scene.windows) {
                    if (subWindow.isKeyWindow) {
                        window = subWindow;
                        activeScene = scene;
                        break;
                    }
                }
            }
        }
        
        if (!window) {
            window = [[UIWindow alloc] initWithWindowScene:activeScene];
        }
        
        return window;
    } else {
        return [UIApplication sharedApplication].keyWindow;
    }
}

- (UIColor *)textColorForDarkMode:(BOOL)dark {
    return dark ?
    [UIColor colorWithRed:127 / 255 green:127 / 255 blue:129 / 255 alpha:1] :
    [UIColor colorWithRed:88 / 255 green:87 / 255 blue:88 / 255 alpha:1];
}

- (UIView *)viewForIconType:(ACStatusIconType)type {
    switch (type) {
        case ACStatusIconTypeDone:          return [ACStatusIconDoneView new];
        case ACStatusIconTypeHeart:         return [ACStatusIconHeartView new];
        case ACStatusIconTypeDocument:      return [ACStatusIconDocumentView new];
        case ACStatusIconTypeBookmark:      return [ACStatusIconBookmarkView new];
        case ACStatusIconTypeMoon:          return [ACStatusIconMoonView new];
        case ACStatusIconTypeStar:          return [ACStatusIconStarView new];
        case ACStatusIconTypeExclamation:   return [ACStatusIconExclamationView new];
        case ACStatusIconTypeFlag:          return [ACStatusIconFlagView new];
        case ACStatusIconTypeMessage:       return [ACStatusIconMessageView new];
        case ACStatusIconTypeQuestion:      return [ACStatusIconQuestionView new];
        case ACStatusIconTypeBolt:          return [ACStatusIconBoltView new];
        case ACStatusIconTypeAdd:           return [ACStatusIconAddView new];
        case ACStatusIconTypeError:         return [ACStatusIconErrorView new];
        case ACStatusIconTypeShuffle:       return [ACStatusIconShuffleView new];
        case ACStatusIconTypeRepeat:        return [ACStatusIconRepeatView new];
        case ACStatusIconTypeEject:         return [ACStatusIconEjectView new];
        case ACStatusIconTypeCard:          return [ACStatusIconCardView new];
        case ACStatusIconTypeRotate:        return [ACStatusIconRotateView new];
        case ACStatusIconTypeLike:          return [ACStatusIconLikeView new];
        case ACStatusIconTypeDislike:       return [ACStatusIconDislikeView new];
        case ACStatusIconTypePrivacy:       return [ACStatusIconPrivacyView new];
        case ACStatusIconTypeCart:          return [ACStatusIconCartView new];
        case ACStatusIconTypeSearch:        
        default:                            return [ACStatusIconSearchView new];
    }
}

- (ACStatusIconLayout *)layoutForIconType:(ACStatusIconType)type {
    ACStatusIconLayout *layout = [ACStatusIconLayout new];
    switch (type) {
        case ACStatusIconTypeDone: {
            layout.topSpace = 63;
            layout.bottomSpace = 29;
            layout.iconWidth = 112;
            layout.iconHeight = 112;
            layout.bottomIconSpace = 35;
        }
            break;
        case ACStatusIconTypeHeart: {
            layout.topSpace = 49;
            layout.bottomSpace = 25;
            layout.iconWidth = 112;
            layout.iconHeight = 77;
            layout.bottomIconSpace = 35;
        }
            break;
        case ACStatusIconTypeDocument: {
            layout.topSpace = 49;
            layout.bottomSpace = 29;
            layout.iconWidth = 112;
            layout.iconHeight = 77;
            layout.bottomIconSpace = 35;
        }
            break;
        case ACStatusIconTypeBookmark: {
            layout.topSpace = 57;
            layout.bottomSpace = 29;
            layout.iconWidth = 112;
            layout.iconHeight = 90;
            layout.bottomIconSpace = 36;
        }
            break;
        case ACStatusIconTypeMoon: {
            layout.topSpace = 49;
            layout.bottomSpace = 27;
            layout.iconWidth = 112;
            layout.iconHeight = 88;
            layout.bottomIconSpace = 35;
        }
            break;
        case ACStatusIconTypeStar: {
            layout.topSpace = 49;
            layout.bottomSpace = 31;
            layout.iconWidth = 112;
            layout.iconHeight = 92;
            layout.bottomIconSpace = 35;
        }
            break;
        case ACStatusIconTypeExclamation: {
            layout.topSpace = 46;
            layout.bottomSpace = 33;
            layout.iconWidth = 112;
            layout.iconHeight = 90;
            layout.bottomIconSpace = 31;
        }
            break;
        case ACStatusIconTypeFlag: {
            layout.topSpace = 49;
            layout.bottomSpace = 31;
            layout.iconWidth = 112;
            layout.iconHeight = 88;
            layout.bottomIconSpace = 35;
        }
            break;
        case ACStatusIconTypeMessage: {
            layout.topSpace = 46;
            layout.bottomSpace = 33;
            layout.iconWidth = 112;
            layout.iconHeight = 90;
            layout.bottomIconSpace = 31;
        }
            break;
        case ACStatusIconTypeQuestion: {
            layout.topSpace = 46;
            layout.bottomSpace = 33;
            layout.iconWidth = 112;
            layout.iconHeight = 102;
            layout.bottomIconSpace = 31;
        }
            break;
        case ACStatusIconTypeBolt: {
            layout.topSpace = 45;
            layout.bottomSpace = 27;
            layout.iconWidth = 116;
            layout.iconHeight = 116;
            layout.bottomIconSpace = 34;
        }
            break;
        case ACStatusIconTypeAdd: {
            layout.topSpace = 63;
            layout.bottomSpace = 29;
            layout.iconWidth = 106;
            layout.iconHeight = 106;
            layout.bottomIconSpace = 39;
        }
            break;
        case ACStatusIconTypeError: {
            layout.topSpace = 63;
            layout.bottomSpace = 29;
            layout.iconWidth = 100;
            layout.iconHeight = 100;
            layout.bottomIconSpace = 37;
        }
            break;
        case ACStatusIconTypeShuffle: {
            layout.topSpace = 63;
            layout.bottomSpace = 29;
            layout.iconWidth = 86;
            layout.iconHeight = 86;
            layout.bottomIconSpace = 39;
        }
            break;
        case ACStatusIconTypeRepeat: {
            layout.topSpace = 63;
            layout.bottomSpace = 29;
            layout.iconWidth = 86;
            layout.iconHeight = 86;
            layout.bottomIconSpace = 39;
        }
            break;
        case ACStatusIconTypeEject: {
            layout.topSpace = 48;
            layout.bottomSpace = 31;
            layout.iconWidth = 112;
            layout.iconHeight = 77;
            layout.bottomIconSpace = 32;
        }
            break;
        case ACStatusIconTypeCard: {
            layout.topSpace = 45;
            layout.bottomSpace = 31;
            layout.iconWidth = 108;
            layout.iconHeight = 108;
            layout.bottomIconSpace = 25;
        }
            break;
        case ACStatusIconTypeRotate: {
            layout.topSpace = 46;
            layout.bottomSpace = 29;
            layout.iconWidth = 112;
            layout.iconHeight = 112;
            layout.bottomIconSpace = 35;
        }
            break;
        case ACStatusIconTypeLike: {
            layout.topSpace = 49;
            layout.bottomSpace = 31;
            layout.iconWidth = 112;
            layout.iconHeight = 88;
            layout.bottomIconSpace = 35;
        }
            break;
        case ACStatusIconTypeDislike: {
            layout.topSpace = 49;
            layout.bottomSpace = 31;
            layout.iconWidth = 112;
            layout.iconHeight = 88;
            layout.bottomIconSpace = 35;
        }
            break;
        case ACStatusIconTypePrivacy: {
            layout.topSpace = 47;
            layout.bottomSpace = 31;
            layout.iconWidth = 106;
            layout.iconHeight = 106;
            layout.bottomIconSpace = 32;
        }
            break;
        case ACStatusIconTypeCart: {
            layout.topSpace = 45;
            layout.bottomSpace = 31;
            layout.iconWidth = 108;
            layout.iconHeight = 108;
            layout.bottomIconSpace = 25;
        }
            break;
        case ACStatusIconTypeSearch: {
            layout.topSpace = 42;
            layout.bottomSpace = 29;
            layout.iconWidth = 98;
            layout.iconHeight = 98;
            layout.bottomIconSpace = 39;
        }
            break;
    }
    
    return layout;
}

- (ACStatusHapticFeedbackType)hapticFeedbackForIconType:(ACStatusIconType)type {
    switch (type) {
        case ACStatusIconTypeDone:
        case ACStatusIconTypeHeart:
        case ACStatusIconTypeDocument:
        case ACStatusIconTypeBookmark:
        case ACStatusIconTypeMoon:
        case ACStatusIconTypeStar:
        case ACStatusIconTypeFlag:
        case ACStatusIconTypeMessage:
        case ACStatusIconTypeBolt:
        case ACStatusIconTypeAdd:
        case ACStatusIconTypeShuffle:
        case ACStatusIconTypeRepeat:
        case ACStatusIconTypeCard:
        case ACStatusIconTypeRotate:
        case ACStatusIconTypeLike:
        case ACStatusIconTypePrivacy:
        case ACStatusIconTypeCart:
        case ACStatusIconTypeSearch:        return ACStatusHapticFeedbackTypeSuccess;
        case ACStatusIconTypeExclamation:
        case ACStatusIconTypeQuestion:
        case ACStatusIconTypeEject:         return ACStatusHapticFeedbackTypeWarning;
        case ACStatusIconTypeError:
        case ACStatusIconTypeDislike:
        default:                            return ACStatusHapticFeedbackTypeError;
    }
}

- (void)applySubtitleFont {
    _subtitleLabel.font = _hightlightSubtitleLabel ? [UIFont boldSystemFontOfSize:17] : [UIFont systemFontOfSize:16];
}

- (void)generateHapticFeedback {
    switch (_hapticFeedbackType) {
        case ACStatusHapticFeedbackTypeNone:    break;
        case ACStatusHapticFeedbackTypeSuccess: {
            UINotificationFeedbackGenerator *generator = [UINotificationFeedbackGenerator new];
            [generator notificationOccurred:UINotificationFeedbackTypeSuccess];
        }
            break;
        
        case ACStatusHapticFeedbackTypeWarning: {
            UINotificationFeedbackGenerator *generator = [UINotificationFeedbackGenerator new];
            [generator notificationOccurred:UINotificationFeedbackTypeWarning];
        }
            break;
            
        case ACStatusHapticFeedbackTypeError:
        default: {
            UINotificationFeedbackGenerator *generator = [UINotificationFeedbackGenerator new];
            [generator notificationOccurred:UINotificationFeedbackTypeError];
        }
            break;
    }
}

@end

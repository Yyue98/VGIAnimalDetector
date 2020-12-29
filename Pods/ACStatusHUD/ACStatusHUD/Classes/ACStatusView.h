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


#import <UIKit/UIKit.h>
#import "ACStatusViewDefines.h"
#import "ACStatusIconLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface ACStatusView : UIView

/// Large top text on alert.
@property (nonatomic, strong)   UILabel *titleLabel;

/// Small text on alert.
@property (nonatomic, strong)   UILabel *subtitleLabel;

/// Icon view. Size for it configure in `layout` property.
@property (nonatomic, strong)   UIView  *iconView;

/// Blur view for background.
@property (nonatomic, strong)   UIVisualEffectView  *backgroundView;

/// Duration time when alert visible.
@property (nonatomic, assign)   NSTimeInterval  duration;

/// Allow dismiss by tap on alert. By default it allowed.
@property (nonatomic, assign)   BOOL    dismissByTap;

/// Vibro for this alert. Default value using for presets. If you init custom. haptic not configure.
@property (nonatomic, assign)   ACStatusHapticFeedbackType hapticFeedbackType;

/// Spacing and icon size configure here. Auto configure when you using presets.
@property (nonatomic, strong)   ACStatusIconLayout  *layout;

/// View on which present alert.
@property (nonatomic, weak) UIView  *keyWindow;

/// Highlight subtitle will use larger bold font instead of system font.
@property (nonatomic, assign)   BOOL    hightlightSubtitleLabel;

/// Background user interactable when present.
@property (nonatomic, assign)   BOOL    backgroundUserInteractable;

- (instancetype)initWithTitle:(NSString *)title message:(nullable NSString *)message iconType:(ACStatusIconType)type;
- (instancetype)initWithTitle:(NSString *)title message:(nullable NSString *)message iconView:(UIView *)view;
- (instancetype)initWithTitle:(NSString *)title message:(nullable NSString *)message iconImage:(UIImage *)image;
- (instancetype)initWithMessage:(nonnull NSString *)message;
- (void)presentWithAutoHide:(BOOL)hide;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END

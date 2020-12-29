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


#import "ACStatusHUD.h"
#import "ACStatusIconLoadingView.h"

@implementation ACStatusHUD

+ (void)presentTitle:(NSString *)title message:(nullable NSString *)message iconStyle:(ACStatusIconType)type {
    ACStatusView *hud = [[ACStatusView alloc] initWithTitle:title message:message iconType:type];
    [hud presentWithAutoHide:YES];
}

+ (void)presentTitle:(NSString *)title message:(nullable NSString *)message iconView:(UIView *)view hapticFeedback:(ACStatusHapticFeedbackType)type {
    ACStatusView *hud = [[ACStatusView alloc] initWithTitle:title message:message iconView:view];
    hud.hapticFeedbackType = type;
    [hud presentWithAutoHide:YES];
}

+ (void)presentTitle:(NSString *)title message:(nullable NSString *)message iconImage:(UIImage *)image hapticFeedback:(ACStatusHapticFeedbackType)type {
    ACStatusView *hud = [[ACStatusView alloc] initWithTitle:title message:message iconImage:image];
    hud.hapticFeedbackType = type;
    [hud presentWithAutoHide:YES];
}

+ (void)presentMessage:(NSString *)message highlight:(BOOL)highlight hapticFeedback:(ACStatusHapticFeedbackType)type {
    ACStatusView *hud = [[ACStatusView alloc] initWithMessage:message];
    hud.hapticFeedbackType = type;
    hud.hightlightSubtitleLabel = highlight;
    [hud presentWithAutoHide:YES];
}

+ (ACStatusView *)presentLoadingWithTitle:(NSString *)title message:(NSString *)message {
    ACStatusView *hud = [[ACStatusView alloc] initWithTitle:title message:message iconView:[ACStatusIconLoadingView new]];
    hud.dismissByTap = NO;
    hud.backgroundUserInteractable = NO;
    [hud presentWithAutoHide:NO];
    return hud;
}

@end

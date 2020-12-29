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
#import "ACStatusView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ACStatusHUD : NSObject

/// Present title and message with built-in icon types
/// @param title Title should not be nil
/// @param message Nullable message
/// @param type Built-in icon type
+ (void)presentTitle:(NSString *)title message:(nullable NSString *)message iconStyle:(ACStatusIconType)type;

/// Present title and message with custom view
/// @param title Title should not be nil
/// @param message Nullable message
/// @param view Custom view to display
/// @param type Haptic feedback type
+ (void)presentTitle:(NSString *)title message:(nullable NSString *)message iconView:(UIView *)view hapticFeedback:(ACStatusHapticFeedbackType)type;

/// Present title and message with custom image content
/// @param title Title should not be nil
/// @param message Nullable message
/// @param image Image will be displayed as template
/// @param type Haptic feedback type
+ (void)presentTitle:(NSString *)title message:(nullable NSString *)message iconImage:(UIImage *)image hapticFeedback:(ACStatusHapticFeedbackType)type;

/// Present only message with highlighted message
/// @param message Message should not be nil
/// @param highlight Highlight message with bold style
/// @param type Haptic feedback type
+ (void)presentMessage:(NSString *)message highlight:(BOOL)highlight hapticFeedback:(ACStatusHapticFeedbackType)type;

/// Present loading with title and message
/// @param title Title should not be nil
/// @param message Nullable message
+ (ACStatusView *)presentLoadingWithTitle:(NSString *)title message:(nullable NSString *)message;

@end

NS_ASSUME_NONNULL_END

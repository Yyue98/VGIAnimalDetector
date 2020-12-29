//
//  ADBottomSheetController.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//  Bottom position enumerator, indicates bottom viewController's position
typedef NS_ENUM(NSInteger, ADBottomSheetPosition) {
    // Determine bottom sheet controller is null
    ADBottomSheetPositionDismissed  = -1,
    
    // Determine bottom sheet controller has has been hidden
    ADBottomSheetPositionHide       = 0,
    
    // Determine bottom sheet controller on its minimum position
    ADBottomSheetPositionMinimum    = 1,
    
    // Determine bottom sheet controller on its default position
    ADBottomSheetPositionDefault    = 2,
    
    // Determine bottom sheet controller on its expend position
    ADBottomSheetPositionExpend    = 3
};

/// Container view controller bottom sheet protocol
@protocol ADBottomSheetController <NSObject>
@required

/// Control header view height on background view
- (double)headerSize;

/// Control header view upper corner radius
- (double)headerUpperCornerRadius;

/// Control header view color
- (UIColor *)headerColor;

/// Control header stroke width
- (double)headerStrokeWidth;

/// Control header view stroke style
- (UIColor *)headerStrokeColor;

@optional

/// DiADlay offset for bottom sheet viewController in bottom position to bottom edge
- (double)minimumPositionToBottom;

/// DiADlay offset for bottom sheet viewController in default position to bottom edge
- (double)defaultPositionToBottom;

/// DiADlay offset for bottom sheet viewController in expend position to top edge
- (double)expendPositionToTop;

/// Bottom sheet id for locating in view stacks
- (NSString *)bottomSheetID;

/// Should dimming background view in expend posistion
- (BOOL)shouldDimmingBackgroundWhenExpended;

/// Should curve the bottom sheet header stroke in expend position
- (BOOL)shouldCurveHeaderViewArrowWhenExpended;

/// Should hide navigation viewController in expend position
- (BOOL)shouldHideNavigationBarWhenExpended;

/// Stick bottom sheet will avoid to add pan gesture to bottom sheet background view
- (BOOL)stickBottomSheetController;

/// Default position for controller layout in push and pop
- (ADBottomSheetPosition)defaultPositionForLayoutController;

/// Hide bottom sheet background view shadow effect
- (BOOL)hideBottomSheetBackgroundShadow;

/// Dimming background view will hide by user tapping
- (void)bottomSheetDimmingBackgroundViewWillHideByTapping;

/// Invoked when bottom sheet background view add gesture recognizer for pan recognize
/// @param recognizer Pan gesture recognizer
- (void)bottomSheetControllerDidAddPanGestureRecognizer:(UIPanGestureRecognizer *)recognizer;

/// Invoked when bottom sheet background view pan gesture state changed
/// @param state Received gesture recognizer state
- (void)bottomSheetControllerPanGestureRecognizerStateDidChange:(UIGestureRecognizerState)state;

/// Invoked when bottom sheet background view position updated
/// @param position Updated bottom sheet position
- (void)bottomSheetControllerDidUpdatePosition:(ADBottomSheetPosition)position;

/// Invoked when pan gesture recognizer has will be removed from bottom sheet background view
/// @param recognizer Pan gesture recognizer
- (void)bottomSheetControllerWillRemovePanGestureRecognizer:(UIPanGestureRecognizer *)recognizer;

@end

NS_ASSUME_NONNULL_END


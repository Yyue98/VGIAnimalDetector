//
//  ADContainerViewController.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>
#import "ADNavigationBarController.h"
#import "ADBottomSheetConfiguration.h"
#import "ADBottomSheetViewPosition.h"

// Notification fires when ADContainerViewController's bottom controller will change to position with animation
extern NSString *const ADContainerViewControllerWillAnimateToPositionNotification;

// Notification fires when ADContainerViewController's bottom controller did change to position with animation
extern NSString *const ADContainerViewControllerDidAnimateToPositionNotification;

// Notification fire when ADContainerViewController's bottom controller did change to position without animation
extern NSString *const ADContainerViewControllerDidChangeToPositionNotification;

@class ADContainerViewController;

@interface ADContainerViewController : UIViewController

/// Main view controller for content diADlay
@property (nonatomic, strong)   UIViewController    *masterViewController;

/// Navigation bar controller
@property (nonatomic, strong)   UIViewController <ADNavigationBarController>    *navigationBarController;

/// Botton sheet controller
@property (nonatomic, strong)   UIViewController <ADBottomSheetController>  *bottomSheetController;

/// Position of bottom sheet view controller
@property (nonatomic, assign)   ADBottomSheetPosition   bottomSheetPosition;

/// Initialize container view controller with master view controller, navigation controller and bottom sheet controller as well, only content view controller should not be nil
/// @param viewController Content view controller
/// @param navigationBar Navigation controller on top the view
/// @param bottomSheet Bottom sheet controller on the view bottom
- (instancetype)initWithMasterViewController:(UIViewController *)viewController
                     navigationBarController:(UIViewController <ADNavigationBarController> *)navigationBar
                       bottomSheetController:(UIViewController <ADBottomSheetController> *)bottomSheet;

/// Return masked edge insets to master view controller
- (UIEdgeInsets)contentEdgeInsets;

/// Header stroke color for light style or not
/// @param light Light stroke or not
+ (UIColor *)lightStrokeColor:(BOOL)light;

/// Get bottom sheet y offset for position
/// @param position Bottom sheet position
- (CGFloat)bottomSheetYOffsetForPosition:(ADBottomSheetPosition)position;

/// Make pan gesture recognizer for bottom sheet panning
- (UIPanGestureRecognizer *)panGestureRecognizerForBottomSheetController;

/// Bottom sheet content scrollview begin dragging
/// @param scrollView Content scrollview
- (void)bottomSheetContentScrollViewWillBeginDragging:(UIScrollView *)scrollView;

/// Bottom sheet content scrollview begin to scroll
/// @param scrollView Content scrollview
- (void)bottomSheetContentScrollViewDidScroll:(UIScrollView *)scrollView;

/// Bottom sheet content scrollview stop dragging
/// @param scrollView Content scrollview
- (void)bottomSheetContentScrollViewDidEndDragging:(UIScrollView *)scrollView;

/// Return count of navigation bar controllers
- (NSUInteger)numberOfNavigationBarControllers;

/// Return count of bottom sheet controllers
- (NSUInteger)numberOfBottomSheetControllers;

/// Navigation bar identifier at index
/// @param index Navigation bar index
- (NSString *)navigationBarIDAtIndex:(NSUInteger)index;

/// Get current navigation bar id
- (NSString *)navigationBarID;

/// Bottom sheet identifier at index
/// @param index Bottom sheet index
- (NSString *)bottomSheetIDAtIndex:(NSUInteger)index;

/// get current bottom sheet id
- (NSString *)bottomSheetID;

/// Find navigation bar index with id
/// @param navigationBarID Navigation bar identifier
- (NSUInteger)backedNavigationBarIndexForID:(NSString *)navigationBarID;

/// Find bottom sheet index with id
/// @param bottomSheetID Bottom sheet identifier
- (NSUInteger)backedBottomSheetIndexForID:(NSString *)bottomSheetID;

/// Check if contains navigation bar with identifier
/// @param navigationBarID Navigation bar identifier
- (BOOL)containsBackedNavigationBarWithID:(NSString *)navigationBarID;

/// Check if contains bottom sheet with identifier
/// @param bottomSheetID Bottom sheet identifier
- (BOOL)containsBackedBottomSheetWithID:(NSString *)bottomSheetID;

/// Remove backed navigation bar with configuration to index
/// @param index Navigation bar index
- (void)removeBackedNavigationBarToIndex:(NSUInteger)index;

/// Remove backed bottom sheet with configuration to index
/// @param index Bottom sheet index
- (void)removeBackedBottomSheetToIndex:(NSUInteger)index;

/// Hide navigation viewController.
/// Navigation viewcontroller will slide up out of the screen with the offset equals to viewController view's height
/// @param hidden Hide view or not
/// @param animated Update with animation or not
/// @param completion Completion handler
- (void)setNavigationBarControllerHidden:(BOOL)hidden
                                animated:(BOOL)animated
                              completion:(void (^)(void))completion;

/// Scroll botton sheet viewController to position
/// @param position Scroll to position
/// @param animated Update with animation or not
- (void)scrollBottomSheetToPosition:(ADBottomSheetPosition)position
                           animated:(BOOL)animated;

/// Push navigationbar controller to stack and show on the front
/// @param viewController NavigationBar controller
/// @param animated Push with animation or not
/// @param completion Completion handler
- (void)pushNavigationBarController:(UIViewController <ADNavigationBarController> *)viewController
                           animated:(BOOL)animated
                         completion:(void (^)(void))completion;

/// Push navigationbar controller to stack and show on the front
/// @param viewController NavigationBar controller
/// @param remove Push and remove last navigation bar
/// @param animated Push with animation or not
/// @param completion Completion handler
- (void)pushNavigationBarController:(UIViewController <ADNavigationBarController> *)viewController
                         removeLast:(BOOL)remove
                           animated:(BOOL)animated
                         completion:(void (^)(void))completion;

/// Pop the last navigationbar controller from the stack
/// @param animated Pop with animation or not
/// @param completion Completion handler
- (void)popNavigationBarControllerAnimated:(BOOL)animated
                                completion:(void (^)(void))completion;

/// Push bottom sheet controller to the stack and show on the front
/// @param viewController Botton sheet viewController
/// @param animated Push with animation or not
/// @param completion Completion handler
- (void)pushBottomSheetController:(UIViewController <ADBottomSheetController> *)viewController
                         animated:(BOOL)animated
                       completion:(void (^)(void))completion;

/// Push bottom sheet controller to the stack and show on the front
/// @param viewController Botton sheet viewController
/// @param remove Push and remove last bottom sheet controller
/// @param animated Push with animation or not
/// @param completion Completion handler
- (void)pushBottomSheetController:(UIViewController <ADBottomSheetController> *)viewController
                       removeLast:(BOOL)remove
                         animated:(BOOL)animated
                       completion:(void (^)(void))completion;

/// Pop the last bottom sheet controller from the stack
/// @param animated Pop with animation or not
/// @param completion Completion handler
- (void)popBottomSheetControllerAnimated:(BOOL)animated
                              completion:(void (^)(void))completion;

/// Push navigationbar and bottom sheet to stacks and show on the front
/// @param navigationBar NavigationBar controller
/// @param bottomSheet Bottom sheet controller
/// @param animated Push with animation or not
/// @param completion Completion handler
- (void)pushNavigationBarController:(UIViewController <ADNavigationBarController> *)navigationBar
              bottomSheetController:(UIViewController <ADBottomSheetController> *)bottomSheet
                           animated:(BOOL)animated
                         completion:(void (^)(void))completion;

/// Push navigationbar and bottom sheet to stacks and show on the front
/// @param navigationBar NavigationBar controller
/// @param bottomSheet Bottom sheet controller
/// @param removeNavigationBar Push and remove last navigation bar controllers
/// @param removeBottomSheet Push and remove last bottom sheet controllers
/// @param animated Push with animation or not
/// @param completion Completion handler
- (void)pushNavigationBarController:(UIViewController <ADNavigationBarController> *)navigationBar
              bottomSheetController:(UIViewController <ADBottomSheetController> *)bottomSheet
            removeLastNavigationBar:(BOOL)removeNavigationBar
              removeLastBottomSheet:(BOOL)removeBottomSheet
                           animated:(BOOL)animated
                         completion:(void (^)(void))completion;

/// Pop last navigationbar controller and bottom sheet controller from stack
/// @param animated Pop with animation or not
/// @param completion Completion handler
- (void)popNavigationBarAndBottomSheetControllerAnimated:(BOOL)animated
                                              completion:(void (^)(void))completion;

/// Pop navigation bar to ADecific id for locating
/// @param navigationBarID Destinate navigation bar id
/// @param animated Pop with animation or not
/// @param completion Completion hander
- (void)popNavigationBarControllerWithID:(NSString *)navigationBarID
                                animated:(BOOL)animated
                              completion:(void (^)(void))completion;

/// Pop bottom sheet with ADecific bottom sheet id for locating
/// @param bottomSheetID Bottom sheet id
/// @param animated Pop with animation or not
/// @param completion Completion handler
- (void)popBottomSheetControllerWithID:(NSString *)bottomSheetID
                              animated:(BOOL)animated
                            completion:(void (^)(void))completion;

/// Pop both navigation bar and bottom sheet for ADecific id for locating
/// @param navigationBarID Navigation bar id
/// @param bottomSheetID Bottom sheet id
/// @param animated Pop with animation or not
/// @param completion Completion handler
- (void)popNavigationBarControllerWithID:(NSString *)navigationBarID
                 bottomSheetControllerID:(NSString *)bottomSheetID
                                animated:(BOOL)animated
                              completion:(void (^)(void))completion;

/// Pop navigation bar to ADecific index
/// @param index Navigation bar controller index
/// @param animated Pop with animation or not
/// @param completion Completion handler
- (void)popNavigationBarControllerToIndex:(NSInteger)index
                                 animated:(BOOL)animated
                               completion:(void (^)(void))completion;

/// Pop bottom sheet controller to ADecific index
/// @param index Bottom sheet controller index
/// @param animated Pop with animation or not
/// @param completion Completion handler
- (void)popBottomSheetControllerToIndex:(NSInteger)index
                               animated:(BOOL)animated
                             completion:(void (^)(void))completion;

/// Pop navigation bar and bottom sheet controller to ADecific index
/// @param navigationBarIndex Navigation bar controller index
/// @param bottomSheetIndex Bottom sheet controller index
/// @param animated Pop with animation or not
/// @param completion Completion handler
- (void)popNavigationBarControllerToIndex:(NSInteger)navigationBarIndex
             bottomSheetControllerToIndex:(NSInteger)bottomSheetIndex
                                 animated:(BOOL)animated
                               completion:(void (^)(void))completion;

@end

@interface ADContainerViewController (Property)

@end

@interface ADContainerViewController (Actions)

@end


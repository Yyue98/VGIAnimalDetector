//
//  ADContainerViewController.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADContainerViewController.h"
#import "ADNavigationBarBackgroundView.h"
#import "ADBottomSheetBackgroundView.h"
#import "ADNavigationBarConfiguration.h"
#import "ADBottomSheetConfiguration.h"
#import "UIViewController+ADContainerViewController.h"

NSString *const ADContainerViewControllerWillAnimateToPositionNotification = @"kADContainerViewControllerWillAnimateToPositionNotification";
NSString *const ADContainerViewControllerDidAnimateToPositionNotification = @"kADContainerViewControllerDidAnimateToPositionNotification";
NSString *const ADContainerViewControllerDidChangeToPositionNotification = @"kADContainerViewControllerDidChangeToPositionNotification";

@interface ADContainerViewController () <UIGestureRecognizerDelegate>

/// Bottom sheet viewController backed from push action
@property (nonatomic, strong)   NSMapTable  *backedBottomSheetControllers;

/// Bottom sheet background views for each bottom sheet controller
@property (nonatomic, strong)   NSMapTable  *backedBottemSheetBackgroundViews;

/// Bottom sheet configurations related to viewControllers
@property (nonatomic, strong)   NSMutableArray <ADBottomSheetConfiguration *>   *backedBottomSheetConfigurations;

/// Configuration of bottom sheet controller on the front
@property (nonatomic, strong)   ADBottomSheetConfiguration  *bottomSheetConfiguration;

/// Background view for bottom sheet controller
@property (nonatomic, strong)   ADBottomSheetBackgroundView *bottomSheetBackgroundView;

/// NavigationBar controller backed from push action
@property (nonatomic, strong)   NSMapTable  *backedNavigationBarControllers;

/// NavigationBar background views backed from push action
@property (nonatomic, strong)   NSMapTable  *backedNavigationBarBackgroundViews;

/// Navigation bar configurations related to viewControllers
@property (nonatomic, strong)   NSMutableArray <ADNavigationBarConfiguration *> *backedNavigationBarConfigurations;

/// Configuration of navigation bar controller on the front
@property (nonatomic, strong)   ADNavigationBarConfiguration    *navigationBarConfiguration;

/// Background view for navigation viewController
@property (nonatomic, strong)   ADNavigationBarBackgroundView   *navigationBarBackgroundView;

/// Edgeinsets for navigation viewController
@property (nonatomic, assign)   CGFloat topEdgeInsets;

/// Edgeinsets for bottom sheet controller
@property (nonatomic, assign)   CGFloat bottomEdgeInsets;

/// Dimming background view to disbale interaction on masterViewController
@property (nonatomic, strong)   UIView  *dimmingBackgroundView;

/// Indicates if container viewcontroller is animating for presenting viewController
@property (nonatomic, assign, getter=isAnimating)   BOOL    animating;

/// Indicates if navigation viewController is been hidden
@property (nonatomic, assign)   BOOL    navigationBarIsHidden;

/// Pan gesture for bottom sheet interaction
@property (nonatomic, strong)   UIPanGestureRecognizer  *panGesture;

/// Y offset for pan starting point
@property (nonatomic, assign)   CGFloat panStartYOffset;

/// Indicates if pan gesture began
@property (nonatomic, assign, getter=iADanStarted)  BOOL    panStarted;

/// Y offset for scroll starting point
@property (nonatomic, assign)   CGFloat scrollStartYOffset;

/// Indicates if scroll began
@property (nonatomic, assign, getter=isScrollStarted)   BOOL    scrollStarted;

/// Indicates if scroll should be applied to interact with bottom sheet
@property (nonatomic, assign)   BOOL    applyScroll;

@end

@implementation ADContainerViewController

- (instancetype)initWithMasterViewController:(UIViewController *)viewController
                     navigationBarController:(UIViewController<ADNavigationBarController> *)navigationBar
                       bottomSheetController:(UIViewController<ADBottomSheetController> *)bottomSheet {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        NSAssert(viewController, @"Master view controller should not be nil");
        self.edgesForExtendedLayout = UIRectEdgeNone;
        _masterViewController = viewController;
        _navigationBarController = navigationBar;
        _bottomSheetController = bottomSheet;
        _bottomSheetPosition = ADBottomSheetPositionDismissed;
        _topEdgeInsets = 0;
        _bottomEdgeInsets = 0;
        _navigationBarIsHidden = YES;
        
        _backedNavigationBarConfigurations = @[].mutableCopy;
        _backedNavigationBarControllers = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
        _backedNavigationBarBackgroundViews = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
        
        _backedBottomSheetConfigurations = @[].mutableCopy;
        _backedBottomSheetControllers = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
        _backedBottemSheetBackgroundViews = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    }

    return self;
}

#pragma mark - Setups

/// Initial setup for master viewController
- (void)initialViewHeritage {
    [_masterViewController willMoveToParentViewController:self];
    [self addChildViewController:_masterViewController];
    _masterViewController.view.frame = self.view.bounds;
    [self.view addSubview:_masterViewController.view];
    [_masterViewController didMoveToParentViewController:self];
    
    self.dimmingBackgroundView.frame = self.view.bounds;
    
    CGFloat top = 0.0;
    if (_navigationBarController) {
        ADNavigationBarBackgroundView *backgroundView = [self makeNavigationBarBackgroundView:_navigationBarController];
        [_navigationBarController willMoveToParentViewController:self];
        
        CGRect frame = backgroundView.frame;
        frame.origin.y = 0.0;
        backgroundView.frame = frame;
        top = CGRectGetHeight(frame);
        
        [self.view addSubview:backgroundView];
        _navigationBarBackgroundView = backgroundView;
        [self addChildViewController:_navigationBarController];
        [_navigationBarController didMoveToParentViewController:self];
    }
    
    CGFloat bottom = 0.0;
    if (_bottomSheetController) {
         ADBottomSheetConfiguration *configuration = [self makeBottomSheetConfiguration:_bottomSheetController];
        ADBottomSheetBackgroundView *backgroundView = [self makeBottomSheetBackgroundView:_bottomSheetController withConfiguration:configuration];
        _bottomSheetConfiguration = configuration;
        
        [_bottomSheetController willMoveToParentViewController:self];

        CGRect frame = backgroundView.frame;
        _bottomSheetPosition = ADBottomSheetPositionHide;
        
        if ([_bottomSheetController respondsToSelector:@selector(bottomSheetControllerDidUpdatePosition:)]) {
            [_bottomSheetController bottomSheetControllerDidUpdatePosition:_bottomSheetPosition];
        }
        
        frame.origin.y = [self bottomSheetYOffsetForPosition:_bottomSheetPosition];
        backgroundView.frame = frame;
        bottom = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(frame);
        
        if (_navigationBarBackgroundView) {
            [self.view insertSubview:backgroundView aboveSubview:_navigationBarBackgroundView];
        } else {
            [self.view addSubview:backgroundView];
        }
        
        _bottomSheetBackgroundView = backgroundView;
        [self addChildViewController:_bottomSheetController];
        [_bottomSheetController didMoveToParentViewController:self];
        
        if (!_bottomSheetConfiguration.stickBottomSheet && [_bottomSheetConfiguration numberOfConstrains] > 1) {
            [self addPanGustureToBottomSheetBackgroundView:backgroundView
                                  forBottomSheetController:_bottomSheetController];
        }
        
        BOOL shouldDimming = _bottomSheetPosition == ADBottomSheetPositionExpend && _bottomSheetConfiguration.shouldDimmingBackgroundWhenExpended;
        if (shouldDimming) {
            if (!self.dimmingBackgroundView.superview) {
                [self insertDimmingBackgroundView];
                self.dimmingBackgroundView.alpha = 1.0;
            }
        }
    }
    
    self.topEdgeInsets = top;
    self.bottomEdgeInsets = bottom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialViewHeritage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if (_bottomSheetController && _bottomSheetPosition == ADBottomSheetPositionHide) {
        [self scrollBottomSheetToPosition:_bottomSheetConfiguration.defaultPositionForLayout animated:YES];
    }
}

#pragma mark - Makes

- (UIView *)dimmingBackgroundView {
    if (!_dimmingBackgroundView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        view.alpha = 0.0;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDimmingBackgroundTapGestureRecognizer:)];
        [view addGestureRecognizer:tapGesture];
        _dimmingBackgroundView = view;
    }
    
    return _dimmingBackgroundView;
}

/// Make navigationBar background view with navigationBar controller
/// @param viewController NavigationBar controller
- (ADNavigationBarBackgroundView *)makeNavigationBarBackgroundView:(UIViewController <ADNavigationBarController> *)viewController {
    ADNavigationBarBackgroundView *view = [ADNavigationBarBackgroundView new];
    CGFloat height = [viewController heightForNavigationBar];
    view.frame = CGRectMake(0,
                            -height,
                            CGRectGetWidth(self.view.bounds),
                            height);
    view.backgroundColor = [UIColor clearColor];
    [view layoutContentView:viewController.view];
    
    return view;
}

/// Make bottom sheet background view with bottom sheet controller
/// @param viewController Bottom sheet controller
- (ADBottomSheetBackgroundView *)makeBottomSheetBackgroundView:(UIViewController <ADBottomSheetController> *)viewController withConfiguration:(ADBottomSheetConfiguration *)configuration {
    BOOL hideShadow = NO;
    if ([viewController respondsToSelector:@selector(hideBottomSheetBackgroundShadow)]) {
        hideShadow = [viewController hideBottomSheetBackgroundShadow];
    }
    
    ADBottomSheetBackgroundView *view = [[ADBottomSheetBackgroundView alloc]
                                         initWithHeaderHeight:[viewController headerSize]
                                         upperCornerRadius:[viewController headerUpperCornerRadius]
                                         hideShadow:hideShadow];
    view.headerView.strokeWidth = [viewController headerStrokeWidth];
    view.headerView.backgroundColor = [viewController headerColor];
    view.headerView.strokeColor = [viewController headerStrokeColor];
        
    ADBottomSheetPosition layoutPosition = [[configuration constrainPositions].lastObject integerValue];
    CGFloat height = 0;
    switch (layoutPosition) {
        case ADBottomSheetPositionMinimum: {
            height = configuration.minimumPositionConstrain.distance + configuration.headerSize;
        }
            break;
        case ADBottomSheetPositionDefault: {
            height = configuration.defaultPositionConstrain.distance + configuration.headerSize;
        }
            break;
        case ADBottomSheetPositionExpend:
        default: {
            height = CGRectGetHeight(self.view.bounds) - configuration.expendPositionConstrain.distance;
        }
            break;
    }
    
    view.frame = CGRectMake(0,
                            CGRectGetMaxY(self.view.bounds),
                            CGRectGetWidth(self.view.bounds),
                            height);
    [view layoutContentView:viewController.view];
    
    return view;
}

/// Make bottom sheet configuration with bottom sheet controller
/// @param viewController Bottom sheet controller
- (ADBottomSheetConfiguration *)makeBottomSheetConfiguration:(UIViewController <ADBottomSheetController> *)viewController {
    ADBottomSheetConfiguration *configuration = [ADBottomSheetConfiguration new];
    configuration.headerSize = [viewController headerSize];
    
    if ([viewController respondsToSelector:@selector(minimumPositionToBottom)]) {
        [configuration addConstrainToPosition:ADBottomSheetPositionMinimum withDistance:[viewController minimumPositionToBottom]];
    }
    
    if ([viewController respondsToSelector:@selector(defaultPositionToBottom)]) {
        [configuration addConstrainToPosition:ADBottomSheetPositionDefault withDistance:[viewController defaultPositionToBottom]];
    }
    
    if ([viewController respondsToSelector:@selector(expendPositionToTop)]) {
        [configuration addConstrainToPosition:ADBottomSheetPositionExpend withDistance:[viewController expendPositionToTop]];
    }
    
    [configuration makeDefaultLayoutPosition];
    
    if ([viewController respondsToSelector:@selector(defaultPositionForLayoutController)]) {
        configuration.defaultPositionForLayout = [viewController defaultPositionForLayoutController];
    }

    if ([viewController respondsToSelector:@selector(bottomSheetID)]) {
        configuration.bottomSheetID = [viewController bottomSheetID];
    } else {
        configuration.bottomSheetID = [NSUUID UUID].UUIDString;
    }
    
    if ([viewController respondsToSelector:@selector(shouldDimmingBackgroundWhenExpended)]) {
        configuration.shouldDimmingBackgroundWhenExpended = [viewController shouldDimmingBackgroundWhenExpended];
    }
    
    if ([viewController respondsToSelector:@selector(shouldCurveHeaderViewArrowWhenExpended)]) {
        configuration.shouldCurveArrowWhenExpended = [viewController shouldCurveHeaderViewArrowWhenExpended];
    }
    
    if ([viewController respondsToSelector:@selector(shouldHideNavigationBarWhenExpended)]) {
        configuration.shouldHideNavigationBarWhenExpended = [viewController shouldHideNavigationBarWhenExpended];
    }
    
    if ([viewController respondsToSelector:@selector(stickBottomSheetController)]) {
        configuration.stickBottomSheet = [viewController stickBottomSheetController];
    }
    
    return configuration;
}

- (ADNavigationBarConfiguration *)makeNavigationBarConfiguration:(UIViewController <ADNavigationBarController> *)viewController {
    ADNavigationBarConfiguration *configuration = [ADNavigationBarConfiguration new];
    configuration.heightForNavigationBar = [viewController heightForNavigationBar];
    
    if ([viewController respondsToSelector:@selector(navigationBarID)]) {
        configuration.navigationBarID = [viewController navigationBarID];
    } else {
        configuration.navigationBarID = [NSUUID UUID].UUIDString;
    }

    return configuration;
}

#pragma mark - Gesture Handling

/// Gesture recognizer handler for tapping on dimming background view
/// @param gesture Tap gesture on dimming view
- (void)handleDimmingBackgroundTapGestureRecognizer:(UITapGestureRecognizer *)gesture {
    if (gesture.state != UIGestureRecognizerStateEnded) return;
    
    if ([_bottomSheetController respondsToSelector:@selector(bottomSheetDimmingBackgroundViewWillHideByTapping)]) {
        [_bottomSheetController bottomSheetDimmingBackgroundViewWillHideByTapping];
    }
    
    [self animateBottomSheetToPosition:ADBottomSheetPositionDefault animated:YES];
}

- (UIPanGestureRecognizer *)panGestureRecognizerForBottomSheetController {
    return [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleBottomSheetPanGestureRecognizer:)];
}

/// Gesture recognizer handler for panning on bottom sheet
/// @param gesture Pan gesture on bottom sheet
- (void)handleBottomSheetPanGestureRecognizer:(UIPanGestureRecognizer *)gesture {
    if ([_bottomSheetController respondsToSelector:@selector(bottomSheetControllerPanGestureRecognizerStateDidChange:)]) {
        [_bottomSheetController bottomSheetControllerPanGestureRecognizerStateDidChange:gesture.state];
    }
    
    switch (gesture.state) {
        case UIGestureRecognizerStatePossible:  return;
        case UIGestureRecognizerStateBegan: {
            _panStarted = YES;
            
            CGFloat offset = [gesture locationInView:_bottomSheetBackgroundView].y;
            _panStartYOffset = [gesture locationInView:self.view].y - offset;
        }
            break;
        
        case UIGestureRecognizerStateChanged:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed: {
            CGPoint translation = [gesture translationInView:self.view];
            CGFloat targetOffset = _panStartYOffset + translation.y;
            CGFloat validateOffset = [self validateYOffset:targetOffset];
            ADBottomSheetPosition position = [self nearestPositionForYOffset:validateOffset];
            _bottomSheetPosition = position;
            
            [self animateBottomSheetToYOffset:validateOffset
                                 withPosition:position
                                     animated:NO];
            
            if (position == ADBottomSheetPositionExpend) {
                if (_bottomSheetConfiguration.shouldCurveArrowWhenExpended && !_bottomSheetBackgroundView.headerView.isCurvedArrow) {
                    [_bottomSheetBackgroundView.headerView setCurveArrow:YES animated:YES];
                }
                
                if (_bottomSheetConfiguration.shouldHideNavigationBarWhenExpended) {
                    [self setNavigationBarControllerHidden:YES
                                                  animated:YES
                                                completion:nil];
                }
            } else {
                if (!_bottomSheetBackgroundView.headerView.isCurvedArrow) {
                     [_bottomSheetBackgroundView.headerView setCurveArrow:NO animated:YES];
                }

                if (_navigationBarIsHidden) {
                    [self setNavigationBarControllerHidden:NO
                                                  animated:YES
                                                completion:nil];
                }
            }
            
            BOOL shouldDimming = [self shouldDimmingBackgroundViewWithYOffset:validateOffset];
            if (shouldDimming) {
                if (!self.dimmingBackgroundView.superview) {
                    [self insertDimmingBackgroundView];
                }
                [self dimmingBackgroundViewForYOffset:validateOffset];
            } else {
                if (self.dimmingBackgroundView.superview) {
                     [self. dimmingBackgroundView removeFromSuperview];
                }
            }
            
            if (gesture.state == UIGestureRecognizerStateChanged) return;
    
            _panStarted = NO;
            [self animateBottomSheetToPosition:position animated:YES];
        }
            break;
    }
}

#pragma mark - Bottom Sheet Content ScrollView Handler
- (void)bottomSheetContentScrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _scrollStarted = YES;
    if (scrollView.contentOffset.y <= 0 && [scrollView.panGestureRecognizer translationInView:scrollView.superview].y > 0) {
        _applyScroll = YES;
        CGFloat offset = [scrollView.panGestureRecognizer locationInView:_bottomSheetBackgroundView].y;
        _scrollStartYOffset = [scrollView.panGestureRecognizer locationInView:self.view].y - offset;
    }
}

- (void)bottomSheetContentScrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_applyScroll) return;
    
    scrollView.contentOffset = CGPointZero;
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:self.view];
    CGFloat targetOffset = _scrollStartYOffset + translation.y;
    CGFloat validateOffset = [self validateYOffset:targetOffset];
    ADBottomSheetPosition position = [self nearestPositionForYOffset:validateOffset];
    _bottomSheetPosition = position;
    
    [self animateBottomSheetToYOffset:validateOffset
                         withPosition:position
                             animated:NO];
    
    if (position == ADBottomSheetPositionExpend) {
        if (_bottomSheetConfiguration.shouldHideNavigationBarWhenExpended) {
            [self setNavigationBarControllerHidden:YES
                                          animated:YES
                                        completion:nil];
        }
    } else {
        if (_navigationBarIsHidden) {
            [self setNavigationBarControllerHidden:NO
                                          animated:YES
                                        completion:nil];
        }
    }
    
    BOOL shouldDimming = [self shouldDimmingBackgroundViewWithYOffset:validateOffset];
    if (shouldDimming) {
        if (!self.dimmingBackgroundView.superview) {
            [self insertDimmingBackgroundView];
        }
        [self dimmingBackgroundViewForYOffset:validateOffset];
    } else {
        if (self.dimmingBackgroundView.superview) {
             [self. dimmingBackgroundView removeFromSuperview];
        }
    }
}

- (void)bottomSheetContentScrollViewDidEndDragging:(UIScrollView *)scrollView {
    _scrollStarted = NO;
    _applyScroll = NO;
    
    [self animateBottomSheetToPosition:_bottomSheetPosition animated:YES];
}

- (NSUInteger)numberOfNavigationBarControllers {
    NSUInteger count = [_backedNavigationBarConfigurations count];
    if (_navigationBarConfiguration) {
        count += 1;
    }
    
    return count;
}

- (NSUInteger)numberOfBottomSheetControllers {
    NSUInteger count = [_backedBottomSheetConfigurations count];
    if (_bottomSheetConfiguration) {
        count += 1;
    }
    
    return count;
}

- (NSString *)navigationBarIDAtIndex:(NSUInteger)index {
    NSUInteger count = [self numberOfNavigationBarControllers];
    if (index < 0 || index > count - 1) {
        return nil;
    }
    
    if (index == count - 1) {
        return _navigationBarConfiguration.navigationBarID;
    }
    
    ADNavigationBarConfiguration *configuration = _backedNavigationBarConfigurations[index];
    return configuration.navigationBarID;
}

- (NSString *)navigationBarID {
    if (!_navigationBarConfiguration) {
        return nil;
    }
    
    return _navigationBarConfiguration.navigationBarID;
}

- (NSString *)bottomSheetIDAtIndex:(NSUInteger)index {
    NSUInteger count = [self numberOfBottomSheetControllers];
    if (index < 0 || index > count - 1) {
        return nil;
    }
    
    if (index == count - 1) {
        return _bottomSheetConfiguration.bottomSheetID;
    }
    
    ADBottomSheetConfiguration *configuration = _backedBottomSheetConfigurations[index];
    return configuration.bottomSheetID;
}

- (NSString *)bottomSheetID {
    if (!_bottomSheetConfiguration) {
        return nil;
    }
    
    return _bottomSheetConfiguration.bottomSheetID;
}

- (NSUInteger)backedNavigationBarIndexForID:(NSString *)navigationBarID {
    NSArray *results = [_backedNavigationBarConfigurations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"navigationBarID == %@", navigationBarID]];
    if (![results count]) return NSNotFound;
    
    ADNavigationBarConfiguration *configuration = results.firstObject;
    NSUInteger index = [_backedNavigationBarConfigurations indexOfObject:configuration];
    return index;
}

- (NSUInteger)backedBottomSheetIndexForID:(NSString *)bottomSheetID {
    NSArray *results = [_backedBottomSheetConfigurations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"bottomSheetID == %@", bottomSheetID]];
    if (![results count]) return NSNotFound;
    
    ADBottomSheetConfiguration *configuration = results.firstObject;
    NSUInteger index = [_backedBottomSheetConfigurations indexOfObject:configuration];
    return index;
}

- (BOOL)containsBackedNavigationBarWithID:(NSString *)navigationBarID {
    NSArray *results = [_backedNavigationBarConfigurations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"navigationBarID == %@", navigationBarID]];
    return [results count] > 0;
}

- (BOOL)containsBackedBottomSheetWithID:(NSString *)bottomSheetID {
    NSArray *results = [_backedBottomSheetConfigurations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"bottomSheetID == %@", bottomSheetID]];
    return [results count] > 0;
}

- (void)removeBackedNavigationBarToIndex:(NSUInteger)index {
    while ([_backedNavigationBarConfigurations count] > index + 1) {
        ADNavigationBarConfiguration *configuration = [_backedNavigationBarConfigurations lastObject];
        [self removeBackedNavigationBarForConfiguration:configuration];
    }
}

- (void)removeBackedBottomSheetToIndex:(NSUInteger)index {
    while ([_backedBottomSheetConfigurations count] > index + 1) {
        ADBottomSheetConfiguration *configuration = [_backedBottomSheetConfigurations lastObject];
        [self removeBackedBottomSheetForConfiguration:configuration];
    }
}

#pragma mark - EdgeInsets Handling

/// Get validated top edge insets
/// @param top Top edge insets value
- (CGFloat)validateTopEdgeInsets:(CGFloat)top {
    if (@available(iOS 11.0, *)) {
        if (top < self.view.safeAreaInsets.top) {
            top = self.view.safeAreaInsets.top;
        }
    }
    
    return top;
}

/// Get validated bottom edge insets
/// @param bottom Bottom edge insets value
- (CGFloat)validateBottomEdgeInsets:(CGFloat)bottom {
    if (@available(iOS 11.0, *)) {
        if (bottom < self.view.safeAreaInsets.bottom) {
            bottom = self.view.safeAreaInsets.bottom;
        }
    }
    
    return bottom;
}

/// Get validated edge insets
- (UIEdgeInsets)getValidatedEdgeInsets {
    return UIEdgeInsetsMake([self validateTopEdgeInsets:_topEdgeInsets],
                            0,
                            [self validateBottomEdgeInsets:_bottomEdgeInsets],
                            0);
}

#pragma mark - Notification outside

/// Send notification for will change state
/// @param insets Edge insets value
/// @param position Bottom sheet position
/// @param animated Updated with animation or not
- (void)edgeInsetsWillChangeTo:(UIEdgeInsets)insets withPosition:(ADBottomSheetPosition)position animated:(BOOL)animated {
    if (!animated) return;
    
    ADBottomSheetViewPosition *value = [[ADBottomSheetViewPosition alloc] initWithPosition:position edgeInsets:insets];
    [[NSNotificationCenter defaultCenter] postNotificationName:ADContainerViewControllerWillAnimateToPositionNotification object:value userInfo:nil];
}

/// Send notification for did change state
/// @param insets Edge insets value
/// @param position Bottom sheet position
/// @param animated Updated with animation or not
- (void)edgeInsetsDidChangedTo:(UIEdgeInsets)insets withPosition:(ADBottomSheetPosition)position animated:(BOOL)animated {
    ADBottomSheetViewPosition *value = [[ADBottomSheetViewPosition alloc] initWithPosition:position edgeInsets:insets];
    NSString *key = animated ? ADContainerViewControllerDidAnimateToPositionNotification : ADContainerViewControllerDidChangeToPositionNotification;
    [[NSNotificationCenter defaultCenter] postNotificationName:key object:value userInfo:nil];
}


#pragma mark - Helper Methods

/// Dimming background view with animation
/// @param fadeIn With fade in animation
- (void)animateDimmingBackgroundView:(BOOL)fadeIn {
    if (fadeIn) {
        if (!self.dimmingBackgroundView.superview) {
            [self.view insertSubview:self.dimmingBackgroundView belowSubview:self.bottomSheetBackgroundView];
        }
        
        __weak typeof(self) weakSelf = self;
        self.dimmingBackgroundView.alpha = 0.0;
        [UIView animateWithDuration:0.3 animations:^{
            __strong typeof(weakSelf) self = weakSelf;
            self.dimmingBackgroundView.alpha = 1.0;
        }];
    } else {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            __strong typeof(weakSelf) self = weakSelf;
            self.dimmingBackgroundView.alpha = 0.0;
        } completion:^(BOOL finished) {
            __strong typeof(weakSelf) self = weakSelf;
            [self.dimmingBackgroundView removeFromSuperview];
        }];
    }
}

/// Validate y offset output
/// @param target Y offset input
- (CGFloat)validateYOffset:(CGFloat)target {
    NSArray *constrains = [_bottomSheetConfiguration constrainPositions];
    if ([constrains count] == 1) {
        ADBottomSheetPosition position = [constrains.firstObject integerValue];
        return [self bottomSheetYOffsetForPosition:position];
    } else {
        ADBottomSheetPosition minPosition = [constrains.firstObject integerValue];
        ADBottomSheetPosition maxPosition = [constrains.lastObject integerValue];
        CGFloat max = [self bottomSheetYOffsetForPosition:minPosition];
        CGFloat min = [self bottomSheetYOffsetForPosition:maxPosition];
        
        if (target > max) return max;
        if (target < min) return min;
        return target;
    }
}

- (CGFloat)bottomSheetYOffsetForPosition:(ADBottomSheetPosition)position {
    CGFloat top = 0;
    CGFloat bottom = 0;
    if (@available(iOS 11.0, *)) {
        top = self.view.safeAreaInsets.top > 20 ? self.view.safeAreaInsets.top : 0.0;
        bottom = self.view.safeAreaInsets.bottom;
    }
    
    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);
    CGFloat offset;
    switch (position) {
        case ADBottomSheetPositionExpend: {
            if (_bottomSheetConfiguration.expendPositionConstrain) {
                offset = _bottomSheetConfiguration.expendPositionConstrain.distance + top;
                break;
            }
        }
        case ADBottomSheetPositionDefault: {
            if (_bottomSheetConfiguration.defaultPositionConstrain) {
                offset = viewHeight - _bottomSheetConfiguration.defaultPositionConstrain.distance - _bottomSheetConfiguration.headerSize - bottom;
                break;
            }
        }
        case ADBottomSheetPositionMinimum: {
            if (_bottomSheetConfiguration.minimumPositionConstrain) {
                offset = viewHeight - _bottomSheetConfiguration.minimumPositionConstrain.distance - _bottomSheetConfiguration.headerSize - bottom;
                break;
            }
        }
        case ADBottomSheetPositionHide:
        case ADBottomSheetPositionDismissed:
        default: {
            offset = viewHeight + bottom;
        }
            break;
    }
    
    return offset;
}

/// Dimming background view based on y offset
/// @param offset Y offset of panning
- (void)dimmingBackgroundViewForYOffset:(CGFloat)offset {
    NSArray *constrains = [_bottomSheetConfiguration constrainPositions];
    switch ([constrains count]) {
        case 3: {
            CGFloat defaultOffset = [self bottomSheetYOffsetForPosition:ADBottomSheetPositionDefault];
            CGFloat expandOffset = [self bottomSheetYOffsetForPosition:ADBottomSheetPositionExpend];
            CGFloat progress = (offset - defaultOffset) / (expandOffset - defaultOffset);
            _dimmingBackgroundView.alpha = MIN(1, MAX(0, progress));
        }
            break;
        
        case 2: {
            ADBottomSheetPosition maxPosition = [constrains.lastObject integerValue];
            ADBottomSheetPosition minPosition = [constrains.firstObject integerValue];
            CGFloat defaultOffset = [self bottomSheetYOffsetForPosition:minPosition];
            CGFloat expandOffset = [self bottomSheetYOffsetForPosition:maxPosition];
            CGFloat progress = (offset - defaultOffset) / (expandOffset - defaultOffset);
            _dimmingBackgroundView.alpha = MIN(1, MAX(0, progress));
        }
            break;
            
        case 1:
        default: {
            _dimmingBackgroundView.alpha = 0.0;
        }
            break;
    }
}

/// Animate bottom sheet to position with animation
/// @param position Bottom sheet position
/// @param animated Update with animation or not
- (void)animateBottomSheetToPosition:(ADBottomSheetPosition)position animated:(BOOL)animated {
    if (![_bottomSheetConfiguration containsConstrainToPosition:position]) {
        NSLog(@"ADContainerViewController does not contains position: %@", @(position));
        return;
    }
    
    if (_bottomSheetConfiguration.shouldCurveArrowWhenExpended) {
        if (position == ADBottomSheetPositionExpend) {
            if (!_bottomSheetBackgroundView.headerView.isCurvedArrow) {
                [_bottomSheetBackgroundView.headerView setCurveArrow:YES animated:YES];
            }
        } else {
            if (_bottomSheetBackgroundView.headerView.isCurvedArrow) {
                [_bottomSheetBackgroundView.headerView setCurveArrow:NO animated:YES];
            }
        }
    }
    
    CGFloat offset = [self bottomSheetYOffsetForPosition:position];
    [self animateBottomSheetToYOffset:offset
                         withPosition:position
                             animated:animated];
}

/// Animate bottom sheet with y offset and position
/// @param offset Y offset to scroll
/// @param position Position of offset
/// @param animated Update with animation or not
- (void)animateBottomSheetToYOffset:(CGFloat)offset withPosition:(ADBottomSheetPosition)position animated:(BOOL)animated {
    CGRect finalFrame = _bottomSheetBackgroundView.frame;
    finalFrame.origin.y = offset;
        
    _bottomSheetPosition = position;
    _bottomEdgeInsets = CGRectGetHeight(self.view.bounds) - offset;
    
    if ([_bottomSheetController respondsToSelector:@selector(bottomSheetControllerDidUpdatePosition:)]) {
        [_bottomSheetController bottomSheetControllerDidUpdatePosition:position];
    }
    
    __weak typeof(self) weakSelf = self;
    void (^animationsBlock)(void) = ^{
        __strong typeof(weakSelf) self = weakSelf;
        self.bottomSheetBackgroundView.frame = finalFrame;
        
        if (self.bottomSheetConfiguration.shouldDimmingBackgroundWhenExpended) {
            self.dimmingBackgroundView.alpha = position == ADBottomSheetPositionExpend ? 1.0 : 0.0;
        }
        
        UIEdgeInsets insets = [self getValidatedEdgeInsets];
        [self edgeInsetsWillChangeTo:insets withPosition:position animated:animated];
    };
    
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
         __strong typeof(weakSelf) self = weakSelf;
        if (self.bottomSheetConfiguration.shouldDimmingBackgroundWhenExpended && position == ADBottomSheetPositionDefault) {
            [self.dimmingBackgroundView removeFromSuperview];
        }
        
        UIEdgeInsets insets = [self getValidatedEdgeInsets];
        [self edgeInsetsDidChangedTo:insets withPosition:position animated:animated];
    };
    
    if (animated) {
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.3
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animationsBlock
                         completion:completionBlock];
    } else {
        animationsBlock();
        completionBlock(YES);
    }
}

/// Determine whether dimming background with y offset
/// @param offset Y offset input
- (BOOL)shouldDimmingBackgroundViewWithYOffset:(CGFloat)offset {
    if (!_bottomSheetConfiguration.shouldDimmingBackgroundWhenExpended ||
        ![_bottomSheetConfiguration containsConstrainToPosition:ADBottomSheetPositionExpend]) return NO;
    if ([_bottomSheetConfiguration numberOfConstrains] == 1) return YES;
    
    ADBottomSheetPosition gapPosition = ![_bottomSheetConfiguration containsConstrainToPosition:ADBottomSheetPositionDefault] ? ADBottomSheetPositionMinimum : ADBottomSheetPositionDefault;
    CGFloat position = [self bottomSheetYOffsetForPosition:gapPosition];
    return offset < position;
}

/// Get nearest position for y offset
/// @param offset Y offset input
- (ADBottomSheetPosition)nearestPositionForYOffset:(CGFloat)offset {
    NSUInteger numberOfConstrains = [_bottomSheetConfiguration numberOfConstrains];
    NSArray *orderedPositions = [_bottomSheetConfiguration constrainPositions];
    switch (numberOfConstrains) {
        case 1: {
            ADBottomSheetPosition position = [orderedPositions.firstObject integerValue];
            return position;
        }
        
        case 2: {
            ADBottomSheetPosition firstPosition = [orderedPositions.firstObject integerValue];
            ADBottomSheetPosition secondPosition = [orderedPositions.lastObject integerValue];
            CGFloat minimumOffset = [self bottomSheetYOffsetForPosition:firstPosition];
            CGFloat expendOffset = [self bottomSheetYOffsetForPosition:secondPosition];
            
            if (offset >= expendOffset && offset < minimumOffset) {
                CGFloat center = (minimumOffset - expendOffset) / 2.0 + expendOffset;
                return offset > center ? firstPosition : secondPosition;
            }
            
            return firstPosition;
        }
        
        case 3:
        default: {
            CGFloat minimumOffset = [self bottomSheetYOffsetForPosition:ADBottomSheetPositionMinimum];
            CGFloat defaultOffset = [self bottomSheetYOffsetForPosition:ADBottomSheetPositionDefault];
            CGFloat expendOffset = [self bottomSheetYOffsetForPosition:ADBottomSheetPositionExpend];
            
            if (offset >= expendOffset && offset < defaultOffset) {
                CGFloat center = (defaultOffset - expendOffset) / 2.0 + expendOffset;
                return offset > center ? ADBottomSheetPositionDefault : ADBottomSheetPositionExpend;
            } else if (offset >= defaultOffset && offset < minimumOffset) {
                CGFloat center = (minimumOffset - defaultOffset) / 2.0 + defaultOffset;
                return offset > center ? ADBottomSheetPositionMinimum : ADBottomSheetPositionDefault;
            }
            
            return ADBottomSheetPositionMinimum;
        }
    }
}

/// Insert dimming background view to correct subview index
- (void)insertDimmingBackgroundView {
    [self.view insertSubview:_dimmingBackgroundView belowSubview:_bottomSheetBackgroundView];
}

/// Add pan gesture to bottom sheet background
/// @param view Bottom sheet background
- (void)addPanGustureToBottomSheetBackgroundView:(ADBottomSheetBackgroundView *)view forBottomSheetController:(UIViewController <ADBottomSheetController> *)viewController {
    if (_panGesture) {
        NSLog(@"ADContainerViewController: pan gesture is not been removed from previous bottom sheet");
        return;
    }
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleBottomSheetPanGestureRecognizer:)];
    gesture.minimumNumberOfTouches = 1;
    gesture.maximumNumberOfTouches = 1;
    gesture.delegate = self;
    
    _panGesture = gesture;
    [view addGestureRecognizer:gesture];
    if ([viewController respondsToSelector:@selector(bottomSheetControllerDidAddPanGestureRecognizer:)]) {
        [viewController bottomSheetControllerDidAddPanGestureRecognizer:gesture];
    }
}

/// Remove pan gesture from bottom sheet background
/// @param view Bottom sheet background
- (void)removePanGestureFromBottomSheetBackgroundView:(ADBottomSheetBackgroundView *)view forBottomSheetController:(UIViewController <ADBottomSheetController> *)viewController {
    if (![view.gestureRecognizers containsObject:_panGesture]) {
        NSLog(@"ADContainerViewController: pan gesture is not found on bottom sheet");
        return;
    }
    
    if ([viewController respondsToSelector:@selector(bottomSheetControllerWillRemovePanGestureRecognizer:)]) {
        [viewController bottomSheetControllerWillRemovePanGestureRecognizer:_panGesture];
    }
    
    [view removeGestureRecognizer:_panGesture];
    _panGesture.delegate = nil;
    _panGesture = nil;
}

#pragma mark - Outlet Methods

- (UIEdgeInsets)contentEdgeInsets {
    return [self getValidatedEdgeInsets];
}

+ (UIColor *)lightStrokeColor:(BOOL)light {
    return light ? [UIColor whiteColor] : [UIColor lightGrayColor];
}

- (void)backNavigationController:(UIViewController <ADNavigationBarController> *)navigationController
                  backgroundView:(ADNavigationBarBackgroundView *)view
                   configuration:(ADNavigationBarConfiguration *)configuration {
    [navigationController willMoveToParentViewController:nil];
    [view removeFromSuperview];
    [navigationController removeFromParentViewController];
    [navigationController didMoveToParentViewController:nil];
    
    [_backedNavigationBarControllers setObject:navigationController forKey:configuration];
    [_backedNavigationBarBackgroundViews setObject:view forKey:configuration];
    [_backedNavigationBarConfigurations addObject:configuration];
}

- (void)removeBackedNavigationBarForConfiguration:(ADNavigationBarConfiguration *)configuration {
    [_backedNavigationBarControllers removeObjectForKey:configuration];
    [_backedNavigationBarBackgroundViews removeObjectForKey:configuration];
    [_backedNavigationBarConfigurations removeObject:configuration];
}

- (void)backBottomSheetController:(UIViewController <ADBottomSheetController> *)bottomSheetController
                   backgroundView:(ADBottomSheetBackgroundView *)view
                    configuration:(ADBottomSheetConfiguration *)configuration {
    [bottomSheetController willMoveToParentViewController:nil];
    [view removeFromSuperview];
    [bottomSheetController removeFromParentViewController];
    [bottomSheetController didMoveToParentViewController:nil];
    
    [_backedBottomSheetControllers setObject:bottomSheetController forKey:configuration];
    [_backedBottemSheetBackgroundViews setObject:view forKey:configuration];
    [_backedBottomSheetConfigurations addObject:configuration];
}

- (void)removeBackedBottomSheetForConfiguration:(ADBottomSheetConfiguration *)configuration {
    [_backedBottomSheetControllers removeObjectForKey:configuration];
    [_backedBottemSheetBackgroundViews removeObjectForKey:configuration];
    [_backedBottomSheetConfigurations removeObject:configuration];
}

- (void)pushNavigationBarController:(UIViewController<ADNavigationBarController> *)viewController
                         removeLast:(BOOL)remove
                           animated:(BOOL)animated
                         completion:(void (^)(void))completion {
    if (_animating) return;
    
    _animating = YES;
    ADNavigationBarConfiguration *configuration = [self makeNavigationBarConfiguration:viewController];
    ADNavigationBarBackgroundView *backgroundView = [self makeNavigationBarBackgroundView:viewController];
    
    [viewController willMoveToParentViewController:self];
        
    if (_navigationBarBackgroundView) {
        [self.view insertSubview:backgroundView aboveSubview:_navigationBarBackgroundView];
    } else {
        if (_bottomSheetBackgroundView) {
            [self.view insertSubview:backgroundView belowSubview:_bottomSheetBackgroundView];
        } else {
            [self.view addSubview:backgroundView];
        }
    }
        
    [self addChildViewController:viewController];
    [viewController didMoveToParentViewController:self];
    
    ADNavigationBarConfiguration *previousNavigationBarConfiguration = _navigationBarConfiguration;
    UIViewController <ADNavigationBarController> *previousNavigationController = _navigationBarController;
    ADNavigationBarBackgroundView *previousBackgroundView = _navigationBarBackgroundView;
    _navigationBarController = viewController;
    _navigationBarBackgroundView = backgroundView;
    _navigationBarConfiguration = configuration;
    
    CGRect finalFrame = backgroundView.frame;
    finalFrame.origin.y = 0.0;
    
    __weak typeof(self) weakSelf = self;
    void (^animationsBlock)(void) = ^{
        __strong typeof(weakSelf) self = weakSelf;
        backgroundView.frame = finalFrame;
        
        if (previousBackgroundView) {
            CGRect frame = previousBackgroundView.frame;
            CGFloat height = CGRectGetHeight(frame);
            CGFloat finalHeight = CGRectGetHeight(finalFrame);
            
            if (height > finalHeight) {
                frame.origin.y = height - finalHeight;
                previousBackgroundView.frame = frame;
            }
        }
        
        [self setNeedsStatusBarAppearanceUpdate];
        
        CGFloat top = CGRectGetHeight(finalFrame);
        UIEdgeInsets insets = UIEdgeInsetsMake([self validateTopEdgeInsets:top],
                                               0,
                                               [self validateBottomEdgeInsets:self.bottomEdgeInsets],
                                               0);
        [self edgeInsetsWillChangeTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
    };
    
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        __strong typeof(weakSelf) self = weakSelf;
        self.topEdgeInsets = CGRectGetHeight(finalFrame);
        self.navigationBarIsHidden = NO;
        self.animating = NO;
        
        if (previousNavigationController && previousBackgroundView) {
            if (remove) {
                [previousNavigationController willMoveToParentViewController:nil];
                [previousBackgroundView removeContentView];
                [previousBackgroundView removeFromSuperview];
                [previousNavigationController removeFromParentViewController];
                [previousNavigationController didMoveToParentViewController:nil];
            } else {
                [self backNavigationController:previousNavigationController
                                backgroundView:previousBackgroundView
                                 configuration:previousNavigationBarConfiguration];
            }
        }
        
        UIEdgeInsets insets = [self getValidatedEdgeInsets];
        [self edgeInsetsDidChangedTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
        
        if (completion) {
            completion();
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.3
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animationsBlock
                         completion:completionBlock];
    } else {
        animationsBlock();
        completionBlock(YES);
    }
}

- (void)pushNavigationBarController:(UIViewController<ADNavigationBarController> *)viewController
                           animated:(BOOL)animated
                         completion:(void (^)(void))completion {
    [self pushNavigationBarController:viewController
                           removeLast:NO
                             animated:animated
                           completion:completion];
}

- (void)popNavigationBarControllerAnimated:(BOOL)animated
                                completion:(void (^)(void))completion {
    if (_animating || !_navigationBarController) return;
    
    _animating = YES;
    
    ADNavigationBarConfiguration *backedConfiguration = [_backedNavigationBarConfigurations lastObject];
    ADNavigationBarBackgroundView *backedBackgroundView = [_backedNavigationBarBackgroundViews objectForKey:backedConfiguration];
    UIViewController <ADNavigationBarController> *backedNavigationController = [_backedNavigationBarControllers objectForKey:backedConfiguration];
    if (backedBackgroundView && backedNavigationController) {
        [backedNavigationController willMoveToParentViewController:self];
        [self.view insertSubview:backedBackgroundView belowSubview:_navigationBarBackgroundView];
        [self addChildViewController:backedNavigationController];
        [backedNavigationController didMoveToParentViewController:self];
    }
    
    ADNavigationBarBackgroundView *previousBackgroundView = _navigationBarBackgroundView;
    UIViewController <ADNavigationBarController> *previousNavigationController = _navigationBarController;
    
    _navigationBarController = backedNavigationController;
    _navigationBarBackgroundView = backedBackgroundView;
    
    __weak typeof(self) weakSelf = self;
    void (^animationsBlock)(void) = ^{
        __strong typeof(weakSelf) self = weakSelf;
        CGRect previousFrame = previousBackgroundView.frame;
        previousFrame.origin.y = - CGRectGetHeight(previousFrame);
        previousBackgroundView.frame = previousFrame;
       
        CGFloat top = 0.0;
        if (backedBackgroundView) {
            CGRect frame = backedBackgroundView.frame;
            frame.origin.y = 0.0;
            backedBackgroundView.frame = frame;
            top = CGRectGetHeight(frame);
        }
        
        [self setNeedsStatusBarAppearanceUpdate];
       
        UIEdgeInsets insets = UIEdgeInsetsMake([self validateTopEdgeInsets:top],
                                               0,
                                               [self validateBottomEdgeInsets:self.bottomEdgeInsets],
                                               0);
        [self edgeInsetsWillChangeTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
    };
   
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        __strong typeof(weakSelf) self = weakSelf;
        CGFloat top = 0.0;
        if (backedBackgroundView) {
            top = CGRectGetHeight(backedBackgroundView.bounds);
        }
       
        self.topEdgeInsets = top;
        self.navigationBarIsHidden = NO;
        self.animating = NO;
       
        [previousNavigationController willMoveToParentViewController:nil];
        [previousBackgroundView removeFromSuperview];
        [previousBackgroundView removeContentView];
        [previousNavigationController removeFromParentViewController];
        [previousNavigationController didMoveToParentViewController:nil];
        
        if (backedNavigationController && backedBackgroundView) {
            [self removeBackedNavigationBarForConfiguration:backedConfiguration];
        }
       
        UIEdgeInsets insets = [self getValidatedEdgeInsets];
        [self edgeInsetsDidChangedTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
       
        if (completion) {
            completion();
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.3
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animationsBlock
                         completion:completionBlock];
    } else {
        animationsBlock();
        completionBlock(YES);
    }
}

- (void)pushBottomSheetController:(UIViewController<ADBottomSheetController> *)viewController
                       removeLast:(BOOL)remove
                         animated:(BOOL)animated
                       completion:(void (^)(void))completion {
    if (_animating) return;
    
    _animating = YES;
    ADBottomSheetConfiguration *configuration = [self makeBottomSheetConfiguration:viewController];
    ADBottomSheetBackgroundView *backgroundView = [self makeBottomSheetBackgroundView:viewController withConfiguration:configuration];
    
    [viewController willMoveToParentViewController:self];
    
    if (_bottomSheetBackgroundView) {
        [self.view insertSubview:backgroundView aboveSubview:_bottomSheetBackgroundView];
    } else {
        if (_navigationBarBackgroundView) {
            [self.view insertSubview:backgroundView aboveSubview:_navigationBarBackgroundView];
        } else {
            [self.view addSubview:backgroundView];
        }
    }
    
    [self addChildViewController:viewController];
    [viewController didMoveToParentViewController:self];
    
    UIViewController <ADBottomSheetController> *previousBottomSheet = _bottomSheetController;
    ADBottomSheetBackgroundView *previousBackgroundView = _bottomSheetBackgroundView;
    ADBottomSheetConfiguration *previousConfiguration = _bottomSheetConfiguration;
    
    _bottomSheetController = viewController;
    _bottomSheetBackgroundView = backgroundView;
    _bottomSheetConfiguration = configuration;
    _bottomSheetPosition = configuration.defaultPositionForLayout;
    
    if ([viewController respondsToSelector:@selector(bottomSheetControllerDidUpdatePosition:)]) {
        [viewController bottomSheetControllerDidUpdatePosition:_bottomSheetPosition];
    }
    
    if (previousBackgroundView && previousBottomSheet && !previousConfiguration.stickBottomSheet && [previousConfiguration numberOfConstrains] > 1) {
        [self removePanGestureFromBottomSheetBackgroundView:previousBackgroundView
                                   forBottomSheetController:previousBottomSheet];
    }
    
    if (!configuration.stickBottomSheet && [configuration numberOfConstrains] > 1) {
        [self addPanGustureToBottomSheetBackgroundView:backgroundView
                              forBottomSheetController:viewController];
    }
    
    BOOL shouldDimming = _bottomSheetPosition == ADBottomSheetPositionExpend && _bottomSheetConfiguration.shouldDimmingBackgroundWhenExpended;
    if (shouldDimming) {
        if (!self.dimmingBackgroundView.superview) {
            [self insertDimmingBackgroundView];
        }
    }
    
    CGRect finalFrame = backgroundView.frame;
    finalFrame.origin.y = [self bottomSheetYOffsetForPosition:_bottomSheetPosition];
    
    __weak typeof(self) weakSelf = self;
    void (^animationsBlock)(void) = ^{
        __strong typeof(weakSelf) self = weakSelf;
        backgroundView.frame = finalFrame;
        
        if (previousBackgroundView) {
            CGRect frame = previousBackgroundView.frame;
            CGFloat finalY = CGRectGetMinY(finalFrame);
            CGFloat frameY = CGRectGetMinY(frame);
            
            if (finalY > frameY) {
                frame.origin.y = finalY;
                previousBackgroundView.frame = frame;
            }
            
            [previousBackgroundView fadeOutShadow:YES];
        }
        
        if (shouldDimming) {
            self.dimmingBackgroundView.alpha = 1.0;
        } else {
            if (self.dimmingBackgroundView.superview) {
                self.dimmingBackgroundView.alpha = 0.0;
            }
        }
        
        [self setNeedsStatusBarAppearanceUpdate];
        
        CGFloat bottom = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(finalFrame);
        UIEdgeInsets insets = UIEdgeInsetsMake([self validateTopEdgeInsets:self.topEdgeInsets],
                                               0,
                                               [self validateBottomEdgeInsets:bottom],
                                               0);
        [self edgeInsetsWillChangeTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
    };
    
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        __strong typeof(weakSelf) self = weakSelf;
        self.bottomEdgeInsets = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(finalFrame);
        self.navigationBarIsHidden = NO;
        self.animating = NO;
        
        if (previousBottomSheet && previousBackgroundView && previousConfiguration) {
            if (remove) {
                [previousBottomSheet willMoveToParentViewController:nil];
                [previousBackgroundView removeContentView];
                [previousBackgroundView removeFromSuperview];
                [previousBottomSheet removeFromParentViewController];
                [previousBottomSheet didMoveToParentViewController:nil];
            } else {
                [self backBottomSheetController:previousBottomSheet
                                 backgroundView:previousBackgroundView
                                  configuration:previousConfiguration];
            }
        }
        
        if (!shouldDimming) {
            if (self.dimmingBackgroundView.superview) {
                [self.dimmingBackgroundView removeFromSuperview];
            }
        }
        
        UIEdgeInsets insets = [self getValidatedEdgeInsets];
        [self edgeInsetsDidChangedTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
        
        if (completion) {
            completion();
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.3
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animationsBlock
                         completion:completionBlock];
    } else {
        animationsBlock();
        completionBlock(YES);
    }
}

- (void)pushBottomSheetController:(UIViewController<ADBottomSheetController> *)viewController
                         animated:(BOOL)animated
                       completion:(void (^)(void))completion {
    [self pushBottomSheetController:viewController
                         removeLast:NO
                           animated:animated
                         completion:completion];
}

- (void)popBottomSheetControllerAnimated:(BOOL)animated
                              completion:(void (^)(void))completion {
    if (_animating || !_bottomSheetController) return;
    
    _animating = YES;
    ADBottomSheetConfiguration *backedConfiguration = [_backedBottomSheetConfigurations lastObject];
    ADBottomSheetBackgroundView *backedBackgroundView = [_backedBottemSheetBackgroundViews objectForKey:backedConfiguration];
    UIViewController <ADBottomSheetController> *backedBottomSheet = [_backedBottomSheetControllers objectForKey:backedConfiguration];
    
    if (backedBottomSheet && backedBackgroundView && backedConfiguration) {
        [backedBottomSheet willMoveToParentViewController:self];
        [self.view insertSubview:backedBackgroundView belowSubview:_bottomSheetBackgroundView];
        [self addChildViewController:backedBottomSheet];
        [backedBottomSheet didMoveToParentViewController:self];
    }
    
    ADBottomSheetBackgroundView *previousBackgroundView = _bottomSheetBackgroundView;
    UIViewController <ADBottomSheetController> *previousBottomSheet = _bottomSheetController;
    ADBottomSheetConfiguration *previousConfiguration = _bottomSheetConfiguration;
    
    _bottomSheetController = backedBottomSheet;
    _bottomSheetBackgroundView = backedBackgroundView;
    _bottomSheetConfiguration = backedConfiguration;
    
    if (previousBackgroundView && previousBottomSheet && !previousConfiguration.stickBottomSheet  && [previousConfiguration numberOfConstrains] > 1) {
        [self removePanGestureFromBottomSheetBackgroundView:previousBackgroundView
                                   forBottomSheetController:previousBottomSheet];
    }
    
    ADBottomSheetPosition position = ADBottomSheetPositionDismissed;
    if (backedBackgroundView && backedBottomSheet && backedConfiguration) {
        if (!backedConfiguration.stickBottomSheet && [backedConfiguration numberOfConstrains] > 1) {
            [self addPanGustureToBottomSheetBackgroundView:backedBackgroundView
                                  forBottomSheetController:backedBottomSheet];
        }
        
        CGFloat yOffset = backedBackgroundView.frame.origin.y;
        position = [self nearestPositionForYOffset:yOffset];
    }
    _bottomSheetPosition = position;
    
    if ([backedBottomSheet respondsToSelector:@selector(bottomSheetControllerDidUpdatePosition:)]) {
        [backedBottomSheet bottomSheetControllerDidUpdatePosition:_bottomSheetPosition];
    }
    
    BOOL shouldDimming = _bottomSheetPosition == ADBottomSheetPositionExpend && _bottomSheetConfiguration.shouldDimmingBackgroundWhenExpended;
    if (shouldDimming) {
        if (!self.dimmingBackgroundView.superview) {
            [self insertDimmingBackgroundView];
        }
    }
    
    __weak typeof(self) weakSelf = self;
     void (^animationsBlock)(void) = ^{
         __strong typeof(weakSelf) self = weakSelf;
         
         CGRect frame = previousBackgroundView.frame;
         frame.origin.y = CGRectGetHeight(self.view.bounds);
         previousBackgroundView.frame = frame;
         
         CGFloat bottom = 0.0;
         if (previousBackgroundView) {
             CGRect finalFrame = backedBackgroundView.frame;
             finalFrame.origin.y = [self bottomSheetYOffsetForPosition:self.bottomSheetPosition];
             backedBackgroundView.frame = finalFrame;
             bottom = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(finalFrame);
         }
         
         [backedBackgroundView fadeOutShadow:NO];
         
         if (shouldDimming) {
             self.dimmingBackgroundView.alpha = 1.0;
         } else {
             if (self.dimmingBackgroundView.superview) {
                 self.dimmingBackgroundView.alpha = 0.0;
             }
         }
         
         [self setNeedsStatusBarAppearanceUpdate];
        
         UIEdgeInsets insets = UIEdgeInsetsMake([self validateTopEdgeInsets:self.topEdgeInsets],
                                                0,
                                                [self validateBottomEdgeInsets:bottom],
                                                0);
         [self edgeInsetsWillChangeTo:insets
                         withPosition:self.bottomSheetPosition
                             animated:animated];
     };
    
     void (^completionBlock)(BOOL) = ^(BOOL finished) {
         __strong typeof(weakSelf) self = weakSelf;
         CGFloat bottom = 0.0;
         if (backedBackgroundView) {
             bottom = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(backedBackgroundView.frame);
         }
        
         self.bottomEdgeInsets = bottom;
         self.navigationBarIsHidden = NO;
         self.animating = NO;
        
         [previousBottomSheet willMoveToParentViewController:nil];
         [previousBackgroundView removeFromSuperview];
         [previousBackgroundView removeContentView];
         [previousBottomSheet removeFromParentViewController];
         [previousBottomSheet didMoveToParentViewController:nil];
         
         if (backedBottomSheet && backedBackgroundView && backedConfiguration) {
             [self removeBackedBottomSheetForConfiguration:backedConfiguration];
         }
         
         if (!shouldDimming) {
             if (self.dimmingBackgroundView.superview) {
                 [self.dimmingBackgroundView removeFromSuperview];
             }
         }
         
         UIEdgeInsets insets = [self getValidatedEdgeInsets];
         [self edgeInsetsDidChangedTo:insets
                         withPosition:self.bottomSheetPosition
                             animated:animated];
        
         if (completion) {
             completion();
         }
     };
     
     if (animated) {
         [UIView animateWithDuration:0.5
                               delay:0.0
              usingSpringWithDamping:0.9
               initialSpringVelocity:0.3
                             options:UIViewAnimationOptionCurveEaseInOut
                          animations:animationsBlock
                          completion:completionBlock
          ];
         animationsBlock();
         completionBlock(YES);
     }
}

- (void)pushNavigationBarController:(UIViewController<ADNavigationBarController> *)navigationBar
              bottomSheetController:(UIViewController<ADBottomSheetController> *)bottomSheet
            removeLastNavigationBar:(BOOL)removeNavigationBar
              removeLastBottomSheet:(BOOL)removeBottomSheet
                           animated:(BOOL)animated
                         completion:(void (^)(void))completion {
    if (_animating) return;
    
    _animating = YES;
    
    ADNavigationBarBackgroundView *navigationBackgroundView = [self makeNavigationBarBackgroundView:navigationBar];
    ADNavigationBarConfiguration *navigationBarConfiguration = [self makeNavigationBarConfiguration:navigationBar];
        
    [navigationBar willMoveToParentViewController:self];
    
    if (_navigationBarBackgroundView) {
        [self.view insertSubview:navigationBackgroundView aboveSubview:_navigationBarBackgroundView];
    } else {
        if (_bottomSheetBackgroundView) {
            [self.view insertSubview:navigationBackgroundView belowSubview:_bottomSheetBackgroundView];
        } else {
            [self.view addSubview:navigationBackgroundView];
        }
    }
    
    [self addChildViewController:navigationBar];
    [navigationBar didMoveToParentViewController:self];

    ADNavigationBarConfiguration *previousNavigationBarConfiguration = _navigationBarConfiguration;
    UIViewController <ADNavigationBarController> *previousNavigationController = _navigationBarController;
    ADNavigationBarBackgroundView *previousNavigationBackgroundView = _navigationBarBackgroundView;
    _navigationBarController = navigationBar;
    _navigationBarBackgroundView = navigationBackgroundView;
    _navigationBarConfiguration = navigationBarConfiguration;
    
    ADBottomSheetConfiguration *bottomSheetConfiguration = [self makeBottomSheetConfiguration:bottomSheet];
    ADBottomSheetBackgroundView *bottomSheetBackgroundView = [self makeBottomSheetBackgroundView:bottomSheet withConfiguration:bottomSheetConfiguration];
    
    [bottomSheet willMoveToParentViewController:self];
    
    if (_bottomSheetBackgroundView) {
        [self.view insertSubview:bottomSheetBackgroundView aboveSubview:_bottomSheetBackgroundView];
    } else {
        if (_navigationBarBackgroundView) {
            [self.view insertSubview:bottomSheetBackgroundView aboveSubview:bottomSheetBackgroundView];
        } else {
            [self.view addSubview:bottomSheetBackgroundView];
        }
    }
    
    [self addChildViewController:bottomSheet];
    [bottomSheet didMoveToParentViewController:self];
    
    UIViewController <ADBottomSheetController> *previousBottomSheet = _bottomSheetController;
    ADBottomSheetBackgroundView *previousBottomSheetBackgroundView = _bottomSheetBackgroundView;
    ADBottomSheetConfiguration *previousConfiguration = _bottomSheetConfiguration;
    
    _bottomSheetController = bottomSheet;
    _bottomSheetBackgroundView = bottomSheetBackgroundView;
    _bottomSheetConfiguration = bottomSheetConfiguration;
    _bottomSheetPosition = bottomSheetConfiguration.defaultPositionForLayout;
    
    if (bottomSheet && [bottomSheet respondsToSelector:@selector(bottomSheetControllerDidUpdatePosition:)]) {
        [bottomSheet bottomSheetControllerDidUpdatePosition:_bottomSheetPosition];
    }
    
    if (previousBottomSheetBackgroundView && previousBottomSheet && !previousConfiguration.stickBottomSheet && [previousConfiguration numberOfConstrains] > 1) {
        [self removePanGestureFromBottomSheetBackgroundView:previousBottomSheetBackgroundView
                                   forBottomSheetController:previousBottomSheet];
    }
    
    if (!bottomSheetConfiguration.stickBottomSheet && [bottomSheetConfiguration numberOfConstrains] > 1) {
        [self addPanGustureToBottomSheetBackgroundView:bottomSheetBackgroundView
                              forBottomSheetController:bottomSheet];
    }
    
    BOOL shouldDimming = _bottomSheetPosition == ADBottomSheetPositionExpend && _bottomSheetConfiguration.shouldDimmingBackgroundWhenExpended;
    if (shouldDimming) {
        if (!self.dimmingBackgroundView.superview) {
            [self insertDimmingBackgroundView];
        }
    }
    
    CGRect navigationFinalFrame = navigationBackgroundView.frame;
    navigationFinalFrame.origin.y = 0.0;
    
    CGRect bottomFinalFrame = bottomSheetBackgroundView.frame;
    bottomFinalFrame.origin.y = [self bottomSheetYOffsetForPosition:_bottomSheetPosition];
    
    __weak typeof(self) weakSelf = self;
    void (^animationsBlock)(void) = ^{
        __strong typeof(weakSelf) self = weakSelf;
        navigationBackgroundView.frame = navigationFinalFrame;
        bottomSheetBackgroundView.frame = bottomFinalFrame;
        
        if (previousNavigationBackgroundView) {
            CGRect frame = previousNavigationBackgroundView.frame;
            CGFloat height = CGRectGetHeight(frame);
            CGFloat finalHeight = CGRectGetHeight(navigationFinalFrame);
            
            if (height > finalHeight) {
                frame.origin.y = height - finalHeight;
                previousNavigationBackgroundView.frame = frame;
            }
        }
        
        if (previousBottomSheetBackgroundView) {
            CGRect frame = previousBottomSheetBackgroundView.frame;
            CGFloat finalY = CGRectGetMinY(bottomFinalFrame);
            CGFloat frameY = CGRectGetMinY(frame);
           
            if (finalY > frameY) {
                frame.origin.y = finalY;
                previousBottomSheetBackgroundView.frame = frame;
            }
            
            [previousBottomSheetBackgroundView fadeOutShadow:YES];
        }
        
        [self setNeedsStatusBarAppearanceUpdate];
       
        if (shouldDimming) {
            self.dimmingBackgroundView.alpha = 1.0;
        } else {
            if (self.dimmingBackgroundView.superview) {
                self.dimmingBackgroundView.alpha = 0.0;
            }
        }
        
        CGFloat bottom = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(bottomFinalFrame);
        CGFloat top = CGRectGetHeight(navigationFinalFrame);
        UIEdgeInsets insets = UIEdgeInsetsMake([self validateTopEdgeInsets:top],
                                               0,
                                               [self validateBottomEdgeInsets:bottom],
                                               0);
        [self edgeInsetsWillChangeTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
    };
   
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        __strong typeof(weakSelf) self = weakSelf;
        self.topEdgeInsets = CGRectGetHeight(navigationFinalFrame);
        self.bottomEdgeInsets = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(bottomFinalFrame);
        self.navigationBarIsHidden = NO;
        self.animating = NO;
       
        if (previousNavigationBackgroundView && previousNavigationController) {
            if (removeNavigationBar) {
                [previousNavigationController willMoveToParentViewController:nil];
                [previousNavigationBackgroundView removeContentView];
                [previousNavigationBackgroundView removeFromSuperview];
                [previousNavigationController removeFromParentViewController];
                [previousNavigationController didMoveToParentViewController:nil];
            } else {
                [self backNavigationController:previousNavigationController
                                backgroundView:previousNavigationBackgroundView
                                 configuration:previousNavigationBarConfiguration];
            }
        }
        
        if (previousBottomSheet && previousBottomSheetBackgroundView && previousConfiguration) {
            if (removeBottomSheet) {
                [previousBottomSheet willMoveToParentViewController:nil];
                [previousBottomSheetBackgroundView removeContentView];
                [previousBottomSheetBackgroundView removeFromSuperview];
                [previousBottomSheet removeFromParentViewController];
                [previousBottomSheet didMoveToParentViewController:nil];
            } else {
                [self backBottomSheetController:previousBottomSheet
                                 backgroundView:previousBottomSheetBackgroundView
                                  configuration:previousConfiguration];
            }
        }
       
        if (!shouldDimming) {
            if (self.dimmingBackgroundView.superview) {
                [self.dimmingBackgroundView removeFromSuperview];
            }
        }

        UIEdgeInsets insets = [self getValidatedEdgeInsets];
        [self edgeInsetsDidChangedTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
       
        if (completion) {
            completion();
        }
    };
   
    if (animated) {
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.3
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animationsBlock
                         completion:completionBlock];
    } else {
        animationsBlock();
        completionBlock(YES);
    }
}

- (void)pushNavigationBarController:(UIViewController<ADNavigationBarController> *)navigationBar
              bottomSheetController:(UIViewController<ADBottomSheetController> *)bottomSheet
                           animated:(BOOL)animated
                         completion:(void (^)(void))completion {
    [self pushNavigationBarController:navigationBar
                bottomSheetController:bottomSheet
              removeLastNavigationBar:NO
                removeLastBottomSheet:NO
                             animated:animated
                           completion:completion];
}

- (void)popNavigationBarAndBottomSheetControllerAnimated:(BOOL)animated
                                              completion:(void (^)(void))completion {
    if (_animating || (!_navigationBarController && !_bottomSheetController)) return;
    
    if (!_navigationBarController) {
        [self popBottomSheetControllerAnimated:animated
                                    completion:completion];
        return;
    } else if (!_bottomSheetController) {
        [self popNavigationBarControllerAnimated:animated
                                      completion:completion];
        return;
    }
    
    _animating = YES;
    
    ADNavigationBarConfiguration *backedNavigationBarConfiguration = [_backedNavigationBarConfigurations lastObject];
    ADNavigationBarBackgroundView *backedNavigationBackgroundView = [_backedNavigationBarBackgroundViews objectForKey:backedNavigationBarConfiguration];
    UIViewController <ADNavigationBarController> *backedNavigationController = [_backedNavigationBarControllers objectForKey:backedNavigationBarConfiguration];
    if (backedNavigationBarConfiguration && backedNavigationBackgroundView && backedNavigationController) {
        [backedNavigationController willMoveToParentViewController:self];
        [self.view insertSubview:backedNavigationBackgroundView belowSubview:_navigationBarBackgroundView];
        [self addChildViewController:backedNavigationController];
        [backedNavigationController didMoveToParentViewController:self];
    }
    
    ADNavigationBarBackgroundView *previousNavigationBackgroundView = _navigationBarBackgroundView;
    UIViewController <ADNavigationBarController> *previousNavigationController = _navigationBarController;
    
    _navigationBarConfiguration = backedNavigationBarConfiguration;
    _navigationBarController = backedNavigationController;
    _navigationBarBackgroundView = backedNavigationBackgroundView;
    
    ADBottomSheetConfiguration *backedBottomSheetConfiguration = [_backedBottomSheetConfigurations lastObject];
    ADBottomSheetBackgroundView *backedBottomSheetBackgroundView = [_backedBottemSheetBackgroundViews objectForKey:backedBottomSheetConfiguration];
    UIViewController <ADBottomSheetController> *backedBottomSheet = [_backedBottomSheetControllers objectForKey:backedBottomSheetConfiguration];
    
    if (backedBottomSheet && backedBottomSheetBackgroundView && backedBottomSheetConfiguration) {
        [backedBottomSheet willMoveToParentViewController:self];
        [self.view insertSubview:backedBottomSheetBackgroundView belowSubview:_bottomSheetBackgroundView];
        [self addChildViewController:backedBottomSheet];
        [backedBottomSheet didMoveToParentViewController:self];
    }
    
    ADBottomSheetBackgroundView *previousBottomSheetBackgroundView = _bottomSheetBackgroundView;
    UIViewController <ADBottomSheetController> *previousBottomSheet = _bottomSheetController;
    ADBottomSheetConfiguration *previousConfiguration = _bottomSheetConfiguration;
    
    _bottomSheetController = backedBottomSheet;
    _bottomSheetBackgroundView = backedBottomSheetBackgroundView;
    _bottomSheetConfiguration = backedBottomSheetConfiguration;
    
    if (previousBottomSheetBackgroundView && previousBottomSheet && !previousConfiguration.stickBottomSheet && [previousConfiguration numberOfConstrains] > 1) {
        [self removePanGestureFromBottomSheetBackgroundView:previousBottomSheetBackgroundView
                                   forBottomSheetController:previousBottomSheet];
    }
    
    ADBottomSheetPosition position = ADBottomSheetPositionDismissed;
    if (backedBottomSheetBackgroundView && backedBottomSheet && backedBottomSheetConfiguration) {
        if (!backedBottomSheetConfiguration.stickBottomSheet && [backedBottomSheetConfiguration numberOfConstrains] > 1) {
            [self addPanGustureToBottomSheetBackgroundView:backedBottomSheetBackgroundView
                                  forBottomSheetController:backedBottomSheet];
        }
        
        CGFloat yOffset = backedBottomSheetBackgroundView.frame.origin.y;
        position = [self nearestPositionForYOffset:yOffset];
    }
    _bottomSheetPosition = position;
    
    if ([backedBottomSheet respondsToSelector:@selector(bottomSheetControllerDidUpdatePosition:)]) {
        [backedBottomSheet bottomSheetControllerDidUpdatePosition:_bottomSheetPosition];
    }
    
    BOOL shouldDimming = _bottomSheetPosition == ADBottomSheetPositionExpend && _bottomSheetConfiguration.shouldDimmingBackgroundWhenExpended;
    if (shouldDimming) {
        if (!self.dimmingBackgroundView.superview) {
            [self insertDimmingBackgroundView];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    void (^animationsBlock)(void) = ^{
        __strong typeof(weakSelf) self = weakSelf;
        CGRect previousNavigationFrame = previousNavigationBackgroundView.frame;
        previousNavigationFrame.origin.y = - CGRectGetHeight(previousNavigationFrame);
        previousNavigationBackgroundView.frame = previousNavigationFrame;
         
        CGFloat top = 0.0;
        if (backedNavigationBackgroundView) {
            CGRect frame = backedNavigationBackgroundView.frame;
            frame.origin.y = 0.0;
            backedNavigationBackgroundView.frame = frame;
            top = CGRectGetHeight(frame);
        }
          
        CGRect previousBottomFrame = previousBottomSheetBackgroundView.frame;
        previousBottomFrame.origin.y = CGRectGetHeight(self.view.bounds);
        previousBottomSheetBackgroundView.frame = previousBottomFrame;
         
        CGFloat bottom = 0.0;
        if (backedBottomSheetBackgroundView) {
            CGRect frame = backedBottomSheetBackgroundView.frame;
            frame.origin.y = [self bottomSheetYOffsetForPosition:self.bottomSheetPosition];
            backedBottomSheetBackgroundView.frame = frame;
            bottom = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(frame);
             
            [backedBottomSheetBackgroundView fadeOutShadow:NO];
        }
         
        if (shouldDimming) {
            self.dimmingBackgroundView.alpha = 1.0;
        } else {
            if (self.dimmingBackgroundView.superview) {
                self.dimmingBackgroundView.alpha = 0.0;
            }
        }
         
        [self setNeedsStatusBarAppearanceUpdate];
        
        UIEdgeInsets insets = UIEdgeInsetsMake([self validateTopEdgeInsets:top],
                                               0,
                                               [self validateBottomEdgeInsets:bottom],
                                               0);
        [self edgeInsetsWillChangeTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
     };
    
     void (^completionBlock)(BOOL) = ^(BOOL finished) {
         __strong typeof(weakSelf) self = weakSelf;
         CGFloat top = 0.0;
         if (backedNavigationBackgroundView) {
             top = CGRectGetHeight(backedNavigationBackgroundView.bounds);
         }
         
         CGFloat bottom = 0.0;
         if (backedBottomSheetBackgroundView) {
             bottom = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(backedBottomSheetBackgroundView.frame);
         }
        
         self.topEdgeInsets = top;
         self.bottomEdgeInsets = bottom;
         self.navigationBarIsHidden = NO;
         self.animating = NO;
         
         [previousNavigationController willMoveToParentViewController:nil];
         [previousNavigationBackgroundView removeFromSuperview];
         [previousNavigationBackgroundView removeContentView];
         [previousNavigationController removeFromParentViewController];
         [previousNavigationController didMoveToParentViewController:nil];
         
         if (backedNavigationController && backedNavigationController) {
             [self removeBackedNavigationBarForConfiguration:backedNavigationBarConfiguration];
         }
         
         [previousBottomSheet willMoveToParentViewController:nil];
         [previousBottomSheetBackgroundView removeFromSuperview];
         [previousNavigationBackgroundView removeContentView];
         [previousBottomSheet removeFromParentViewController];
         [previousBottomSheet didMoveToParentViewController:nil];
         
         if (backedBottomSheet && backedBottomSheetBackgroundView && backedBottomSheetConfiguration) {
             [self removeBackedBottomSheetForConfiguration:backedBottomSheetConfiguration];
         }
         
         if (!shouldDimming) {
             if (self.dimmingBackgroundView.superview) {
                 [self.dimmingBackgroundView removeFromSuperview];
             }
         }
        
         UIEdgeInsets insets = [self getValidatedEdgeInsets];
         [self edgeInsetsDidChangedTo:insets
                         withPosition:self.bottomSheetPosition
                             animated:animated];
        
         if (completion) {
             completion();
         }
     };
     
     if (animated) {
         [UIView animateWithDuration:0.5
                               delay:0.0
              usingSpringWithDamping:0.9
               initialSpringVelocity:0.3
                             options:UIViewAnimationOptionCurveEaseInOut
                          animations:animationsBlock
                          completion:completionBlock];
     } else {
         animationsBlock();
         completionBlock(YES);
     }
}

- (void)popNavigationBarControllerWithID:(NSString *)navigationBarID
                                animated:(BOOL)animated
                              completion:(void (^)(void))completion {
    if (_animating) return;
    
    ADNavigationBarConfiguration *backedConfiguration = [_backedNavigationBarConfigurations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"navigationBarID == %@", navigationBarID]].firstObject;
    if (!backedConfiguration) return;
    
    NSInteger index = [_backedNavigationBarConfigurations indexOfObject:backedConfiguration];
    [self popNavigationBarControllerToIndex:index
                                   animated:animated
                                 completion:completion];
}

- (void)popBottomSheetControllerWithID:(NSString *)bottomSheetID
                              animated:(BOOL)animated
                            completion:(void (^)(void))completion {
    if (_animating) return;
    
    ADBottomSheetConfiguration *backedConfiguration = [_backedBottomSheetConfigurations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"bottomSheetID == %@", bottomSheetID]].firstObject;
    if (!backedConfiguration) return;
    
    NSInteger index = [_backedBottomSheetConfigurations indexOfObject:backedConfiguration];
    [self popBottomSheetControllerToIndex:index
                                 animated:animated
                               completion:completion];
}

- (void)popNavigationBarControllerWithID:(NSString *)navigationBarID
                 bottomSheetControllerID:(NSString *)bottomSheetID
                                animated:(BOOL)animated
                              completion:(void (^)(void))completion {
    if (_animating) return;
    
    ADNavigationBarConfiguration *backedNavigationBarConfiguration = [_backedNavigationBarConfigurations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"navigationBarID == %@", navigationBarID]].firstObject;
    if (!backedNavigationBarConfiguration) return;
    
    NSInteger navigationBarIndex = [_backedNavigationBarConfigurations indexOfObject:backedNavigationBarConfiguration];
    
    ADBottomSheetConfiguration *backedBottomSheetConfiguration = [_backedBottomSheetConfigurations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"bottomSheetID == %@", bottomSheetID]].firstObject;
    if (!backedBottomSheetConfiguration) return;
    
    NSInteger bottomSheetIndex = [_backedBottomSheetConfigurations indexOfObject:backedBottomSheetConfiguration];
    
    [self popNavigationBarControllerToIndex:navigationBarIndex
               bottomSheetControllerToIndex:bottomSheetIndex
                                   animated:animated
                                 completion:completion];
}

- (void)popNavigationBarControllerToIndex:(NSInteger)index
                                 animated:(BOOL)animated
                               completion:(void (^)(void))completion {
    if (_animating) return;
    
    NSUInteger total = [_backedNavigationBarControllers count];
    if (index == NSNotFound || index >= total - 1) {
        NSLog(@"ADContainerViewController: invalid navigation bar index for pop");
        return;
    }
    
    while ([_backedNavigationBarConfigurations count] > index + 1) {
        ADNavigationBarConfiguration *configuration = [_backedNavigationBarConfigurations lastObject];
        [self removeBackedNavigationBarForConfiguration:configuration];
    }
    
    [self popNavigationBarControllerAnimated:animated
                                  completion:completion];
}

- (void)popBottomSheetControllerToIndex:(NSInteger)index
                               animated:(BOOL)animated
                             completion:(void (^)(void))completion {
    if (_animating) return;
    
    NSUInteger total = [_backedBottomSheetControllers count];
    if (index == NSNotFound || index >= total - 1) {
        NSLog(@"ADContainerViewController: invalid bottom sheet index for pop");
        return;
    }
    
    while ([_backedBottomSheetConfigurations count] > index + 1) {
        ADBottomSheetConfiguration *configuration = [_backedBottomSheetConfigurations lastObject];
        [self removeBackedBottomSheetForConfiguration:configuration];
    }
    
    [self popBottomSheetControllerAnimated:animated
                                completion:completion];
}

- (void)popNavigationBarControllerToIndex:(NSInteger)navigationBarIndex
             bottomSheetControllerToIndex:(NSInteger)bottomSheetIndex
                                 animated:(BOOL)animated
                               completion:(void (^)(void))completion {
    if (_animating) return;
    
    NSUInteger navigationBarTotal = [_backedNavigationBarControllers count];
    if (navigationBarIndex == NSNotFound || navigationBarIndex >= navigationBarTotal - 1) {
        NSLog(@"ADContainerViewController: invalid navigation bar index for pop");
        return;
    }
    
    while ([_backedNavigationBarConfigurations count] > navigationBarIndex + 1) {
        ADNavigationBarConfiguration *configuration = [_backedNavigationBarConfigurations lastObject];
        [self removeBackedNavigationBarForConfiguration:configuration];
    }
    
    NSUInteger bottomSheetTotal = [_backedBottomSheetControllers count];
    if (bottomSheetIndex == NSNotFound || bottomSheetIndex >= bottomSheetTotal - 1) {
        NSLog(@"ADContainerViewController: invalid bottom sheet index for pop");
        return;
    }
    
    while ([_backedBottomSheetConfigurations count] > bottomSheetIndex + 1) {
        ADBottomSheetConfiguration *configuration = [_backedBottomSheetConfigurations lastObject];
        [self removeBackedBottomSheetForConfiguration:configuration];
    }
    
    [self popNavigationBarAndBottomSheetControllerAnimated:animated
                                                completion:completion];
}

- (void)setNavigationBarControllerHidden:(BOOL)hidden
                                animated:(BOOL)animated
                              completion:(void (^)(void))completion {
    if (_animating || !_navigationBarController) return;
    
    if (_navigationBarIsHidden == hidden) {
        if (completion) {
            completion();
        }
    }
    
    _animating = YES;
    _navigationBarIsHidden = hidden;
    
    CGRect finalFrame = self.navigationBarBackgroundView.frame;
    finalFrame.origin.y = hidden ? -CGRectGetHeight(finalFrame) : 0.0;
    _topEdgeInsets = hidden ? 0.0 : CGRectGetHeight(finalFrame);
    
    __weak typeof(self) weakSelf = self;
    void (^animationsBlock)(void) = ^{
        __strong typeof(weakSelf) self = weakSelf;
        self.navigationBarBackgroundView.frame = finalFrame;
        UIEdgeInsets insets = [self getValidatedEdgeInsets];
        
        [self edgeInsetsWillChangeTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
    };
    
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        __strong typeof(weakSelf) self = weakSelf;
        self.animating = NO;
        
        UIEdgeInsets insets = [self getValidatedEdgeInsets];
        [self edgeInsetsDidChangedTo:insets
                        withPosition:self.bottomSheetPosition
                            animated:animated];
        
        if (completion) {
            completion();
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.3
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animationsBlock
                         completion:completionBlock];
    } else {
        animationsBlock();
        completionBlock(YES);
    }
}

- (void)scrollBottomSheetToPosition:(ADBottomSheetPosition)position
                           animated:(BOOL)animated {
    if (!_bottomSheetController) return;
    
    [self animateBottomSheetToPosition:position animated:animated];
    if (position == ADBottomSheetPositionExpend) {
        if (_bottomSheetConfiguration.shouldHideNavigationBarWhenExpended) {
            [self setNavigationBarControllerHidden:YES
                                          animated:YES
                                        completion:nil];
        }
        
        if (_bottomSheetConfiguration.shouldDimmingBackgroundWhenExpended) {
            [self animateDimmingBackgroundView:YES];
        }
    } else {
        [self setNavigationBarControllerHidden:NO
                                      animated:YES
                                    completion:nil];
        if (_bottomSheetConfiguration.shouldDimmingBackgroundWhenExpended) {
            [self animateDimmingBackgroundView:NO];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSAssert(gestureRecognizer == self.panGesture, @"Unexpected gesture recognizer: %@", gestureRecognizer);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSAssert(gestureRecognizer == self.panGesture, @"Unexpected gesture recognizer: %@", gestureRecognizer);
    // Prefer all other gestures over pan gesture
    return YES;
}

#pragma mark - UIStatusBarStyle
- (UIViewController *)childViewControllerForStatusBarStyle {
    if (self.navigationBarController) {
        return self.navigationBarController;
    }
    
    return self.masterViewController;
}

@end


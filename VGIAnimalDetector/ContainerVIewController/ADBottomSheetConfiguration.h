//
//  ADBottomSheetConfiguration.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ADBottomSheetController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADBottomSheetPositionConstrain : NSObject<NSCopying>

/// Bottom sheet constrians position
@property (nonatomic, assign)   ADBottomSheetPosition   position;

/// Bottom sheet constrains distance
@property (nonatomic, assign)   double  distance;

@end

@interface ADBottomSheetConfiguration: NSObject <NSCopying>

/// Bottom sheet id for locating
@property (nonatomic, copy) NSString    *bottomSheetID;

/// Should dimming background view in expend posistion
@property (nonatomic, assign)   BOOL    shouldDimmingBackgroundWhenExpended;

/// Should curve the bottom sheet header stroke line in expend position
@property (nonatomic, assign)   BOOL    shouldCurveArrowWhenExpended;

/// Should hide navigation viewController in expend position
@property (nonatomic, assign)   BOOL    shouldHideNavigationBarWhenExpended;

/// Botton sheet controller is stick on the bottom
@property (nonatomic, assign)   BOOL    stickBottomSheet;

/// DiADlay offset for bottom sheet viewController in bottom position to bottom edge
@property (nonatomic, copy) ADBottomSheetPositionConstrain  *minimumPositionConstrain;

/// DiADlay offset for bottom sheet viewController in default position to bottom edge
@property (nonatomic, copy) ADBottomSheetPositionConstrain  *defaultPositionConstrain;

/// DiADlay offset for bottom sheet viewController in expend position to top edge
@property (nonatomic, copy) ADBottomSheetPositionConstrain  *expendPositionConstrain;

/// Default position for layout bottom sheet view controller
@property (nonatomic, assign)   ADBottomSheetPosition   defaultPositionForLayout;

/// Header view height
@property (nonatomic, assign)   double  headerSize;

/// Add constrains to position
/// @param position Bottom sheet constrains position
/// @param distance Distance of constrains
- (void)addConstrainToPosition:(ADBottomSheetPosition)position withDistance:(double)distance;

/// Determine configuration contains constrain to position or not
/// @param position Bottom sheet position
- (BOOL)containsConstrainToPosition:(ADBottomSheetPosition)position;

/// Get constrain to bottom sheet position
/// @param position Bottom sheet position
- (ADBottomSheetPositionConstrain *)constrainToPosition:(ADBottomSheetPosition)position;

/// Return number of constrains
- (NSUInteger)numberOfConstrains;

/// Get included constrain positions in ascending order
- (NSArray <NSNumber *> *)constrainPositions;

/// Make default layout position based on constrains
- (void)makeDefaultLayoutPosition;

@end

NS_ASSUME_NONNULL_END

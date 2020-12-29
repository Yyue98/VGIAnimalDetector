//
//  ADBottomSheetViewPosition.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ADBottomSheetController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADBottomSheetViewPosition : NSObject
/// Master view edge insets of signal
@property (nonatomic, assign)   UIEdgeInsets    edgeInsets;

/// Bottom sheet position of signal
@property (nonatomic, assign)   ADBottomSheetPosition   position;

/// Initialize with position and content edge insets
/// @param position Bottom sheet controller current position
/// @param insets Edge insets for content view
- (instancetype)initWithPosition:(ADBottomSheetPosition)position edgeInsets:(UIEdgeInsets)insets;

@end

NS_ASSUME_NONNULL_END

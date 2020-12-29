//
//  ADBottomSheetConfiguration.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADBottomSheetConfiguration.h"

@implementation ADBottomSheetPositionConstrain

- (instancetype)copyWithZone:(NSZone *)zone {
    ADBottomSheetPositionConstrain *copy = [[ADBottomSheetPositionConstrain allocWithZone:zone] init];
    copy.position = _position;
    copy.distance = _distance;
    return copy;
}

@end

@interface ADBottomSheetConfiguration ()
@property (nonatomic, strong)   NSMutableArray  *includedConstrainPositions;
@property (nonatomic, assign)   BOOL    ignoreMakeDefaultLayout;
@end

@implementation ADBottomSheetConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        _includedConstrainPositions = [NSMutableArray array];
    }
    
    return self;
}

- (void)addConstrainToPosition:(ADBottomSheetPosition)position withDistance:(double)distance {
    if (position < ADBottomSheetPositionMinimum) {
        NSLog(@"ADBottomSheetConfiguration: invalid constrains add to configuration (%@ | %@)", @(position), @(distance));
        return;
    }
    
    [_includedConstrainPositions addObject:@(position)];
    ADBottomSheetPositionConstrain *constrains = [ADBottomSheetPositionConstrain new];
    constrains.position = position;
    constrains.distance = distance;
    switch (position) {
        case ADBottomSheetPositionMinimum: {
            _minimumPositionConstrain = constrains;
        }
            break;
        
        case ADBottomSheetPositionDefault: {
            _defaultPositionConstrain = constrains;
        }
            break;
        
        case ADBottomSheetPositionExpend:
        default: {
            _expendPositionConstrain = constrains;
        }
            break;
    }
}

- (BOOL)containsConstrainToPosition:(ADBottomSheetPosition)position {
    return [_includedConstrainPositions containsObject:@(position)];
}

- (ADBottomSheetPositionConstrain *)constrainToPosition:(ADBottomSheetPosition)position {
    switch (position) {
        case ADBottomSheetPositionMinimum:  return _minimumPositionConstrain;
        case ADBottomSheetPositionDefault:  return _defaultPositionConstrain;
        case ADBottomSheetPositionExpend:   return _expendPositionConstrain;
        default:    return nil;
    }
}

- (NSUInteger)numberOfConstrains {
    return [_includedConstrainPositions count];
}

- (NSArray <NSNumber *> *)constrainPositions {
    return _includedConstrainPositions.copy;
}

- (void)makeDefaultLayoutPosition {
    if (_ignoreMakeDefaultLayout) return;
    NSAssert([self numberOfConstrains] > 0, @"ADBottomSheetConfiguration should contains at least one constrains");
    
    _ignoreMakeDefaultLayout = YES;
    ADBottomSheetPosition position = [_includedConstrainPositions.firstObject integerValue];
    _defaultPositionForLayout = position;
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    ADBottomSheetConfiguration *copy = [[ADBottomSheetConfiguration allocWithZone:zone] init];
    copy.includedConstrainPositions = _includedConstrainPositions.mutableCopy;
    copy.shouldDimmingBackgroundWhenExpended = _shouldDimmingBackgroundWhenExpended;
    copy.shouldCurveArrowWhenExpended = _shouldCurveArrowWhenExpended;
    copy.shouldHideNavigationBarWhenExpended = _shouldHideNavigationBarWhenExpended;
    copy.stickBottomSheet = _stickBottomSheet;
    copy.ignoreMakeDefaultLayout = _ignoreMakeDefaultLayout;
    copy.minimumPositionConstrain = _minimumPositionConstrain;
    copy.defaultPositionConstrain = _defaultPositionConstrain;
    copy.expendPositionConstrain = _expendPositionConstrain;
    copy.defaultPositionForLayout = _defaultPositionForLayout;
    copy.headerSize = _headerSize;
    return copy;
}

@end

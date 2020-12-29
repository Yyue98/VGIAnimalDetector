//
//  ADPositioningManager.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import "ADLocation.h"

NS_ASSUME_NONNULL_BEGIN

@class ADPositioningManager;

/// Delegate of ADPositioningManager
@protocol ADPositioningManagerDelegate <NSObject>
@optional

/// Invoked when new position has been generated
/// Location object contains onformation with level code, location coordinate, update source type, accuracy, etc.
///
/// @param manager ADPositioningManager object
/// @param location Updated location
- (void)positioningManager:(ADPositioningManager *)manager didUpdateLocation:(ADLocation *)location;


@end

@interface ADPositioningManager : NSObject


/// Designate singleton ADPositioningManager initializer
+ (instancetype)sharedManager;

#pragma mark - Access Methods
///=============================================================================
/// @name Access Methods
///=============================================================================

/// Add observer conform to ADPositionManagerDelegate to notification queue for location and manager state update
/// @param observer Observer conform to <ADPositionManagerDelegate>
- (void)addNotifyObserver:(id <ADPositioningManagerDelegate>)observer;

/// Remove observer conform to ADPositionManagerDelegate from notification queue
/// @param observer Observer should removed from the queue
- (void)removeNotifyObserver:(id <ADPositioningManagerDelegate>)observer;


/// Update heading object for positioning
/// @param heading Updated heading object
- (void)updateHeading:(CLHeading *)heading;

/// Get current heading
- (CLHeading *)getCurrentHeading;

/// Update location object for positioning
/// @param location Updated location object
- (void)updateLocation:(CLLocation *)location;

/// Get location record for map matching mode or not, return nil for mapmathing = YES when not in map matching mode
/// @param matching For map matching
- (ADLocation *)locationForMapMatching:(BOOL)matching;


@end

NS_ASSUME_NONNULL_END


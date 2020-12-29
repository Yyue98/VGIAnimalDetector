//
//  ADAppSceneManager.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ADAppTopBarScene) {
    ADAppTopBarSceneStateBar,
    ADAppTopBarSceneNavigationBar
};

typedef NS_ENUM(NSUInteger, ADAppBottomSheetScene) {
    ADAppBottomSheetSceneSearchBottom,
    ADAppBottomSheetSceneReviewBottom,
    ADAppBottomSheetSceneNavigationBottom,
    ADAppBottomSheetSceneParkingBottom
};

@interface ADAppSceneManager : NSObject

+ (instancetype)sharedManager;
- (BOOL)hasTopBarScene;
- (BOOL)hasBottomSheetScene;
- (BOOL)lastTopBarSceneIsEqualsTo:(ADAppTopBarScene)scene;
- (BOOL)lastBottomSheetSceneIsEqualsTo:(ADAppBottomSheetScene)scene;
- (void)pushTopBarScene:(ADAppTopBarScene)scene;
- (void)pushBottomScene:(ADAppBottomSheetScene)scene;
- (void)popTopBarScene;
- (void)popBottomSheetScene;

@end

NS_ASSUME_NONNULL_END

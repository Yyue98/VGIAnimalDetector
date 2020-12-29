//
//  ADAppSceneManager.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADAppSceneManager.h"

@interface ADAppSceneManager ()
@property (nonatomic, strong)   NSMutableArray  *topBarScenes;
@property (nonatomic, strong)   NSMutableArray  *bottomScenes;
@end

@implementation ADAppSceneManager

+ (instancetype)sharedManager {
    static ADAppSceneManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [ADAppSceneManager new];
    });
    
    return _manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _topBarScenes = @[].mutableCopy;
        _bottomScenes = @[].mutableCopy;
    }
    
    return self;
}

- (BOOL)hasTopBarScene {
    return [_topBarScenes count] > 0;
}

- (BOOL)hasBottomSheetScene {
    return [_bottomScenes count] > 0;
}

- (BOOL)lastTopBarSceneIsEqualsTo:(ADAppTopBarScene)scene {
    if (![_topBarScenes count]) return NO;
    
    ADAppTopBarScene last = [_topBarScenes.lastObject integerValue];
    return last == scene;
}

- (BOOL)lastBottomSheetSceneIsEqualsTo:(ADAppBottomSheetScene)scene {
    if (![_bottomScenes count]) return NO;
    
    ADAppBottomSheetScene last = [_bottomScenes.lastObject integerValue];
    return last == scene;
}

- (void)pushTopBarScene:(ADAppTopBarScene)scene {
    [_topBarScenes addObject:@(scene)];
}

- (void)pushBottomScene:(ADAppBottomSheetScene)scene {
    [_bottomScenes addObject:@(scene)];
}

- (void)popTopBarScene {
    [_topBarScenes removeLastObject];
}

- (void)popBottomSheetScene {
    [_bottomScenes removeLastObject];
}

@end

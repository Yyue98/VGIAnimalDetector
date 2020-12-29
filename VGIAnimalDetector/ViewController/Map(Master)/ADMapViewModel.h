//
//  ADMapViewModel.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ADMapService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADMapViewModel : NSObject

@property (nonatomic, assign)   BOOL    navigationMode;
@property (nonatomic, strong)   RACCommand  *centerCommand;

- (instancetype)initWithService:(id <ADMapService>)service;

@end

NS_ASSUME_NONNULL_END

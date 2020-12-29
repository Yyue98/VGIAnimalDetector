//
//  ADCatViewModel.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ADCatService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADCatViewModel : NSObject

@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString  *temp;
@property (nonatomic, strong)   RACCommand  *commitCommand;
@property (nonatomic, strong)   RACCommand  *selectionCommand;

- (instancetype)initWithService:(id <ADCatService>)service;

@end

NS_ASSUME_NONNULL_END

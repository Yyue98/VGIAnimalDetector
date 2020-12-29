//
//  ADLoginViewModel.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//


#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ADLoginService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADLoginViewModel : NSObject

@property (nonatomic, copy) NSString    *title;
@property (nonatomic, assign)   BOOL    loginWithPassword;
@property (nonatomic, strong)   RACCommand  *submitCommand;
@property (nonatomic, strong)   RACCommand  *registerCommand;
@property (nonatomic, strong)   RACCommand  *loginCommand;

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController service:(id <ADLoginService>)service;

@end

NS_ASSUME_NONNULL_END

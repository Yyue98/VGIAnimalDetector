//
//  ADLoginViewModel.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//


#import "ADLoginViewModel.h"
#import <ACStatusHUD/ACStatusHUD.h>

#import "ADAPIManager.h"
#import "ADAppLauncher.h"
//#import "ADRegisterImpement.h"
//#import "ADRegisterViewModel.h"
//#import "ADRegisterViewController.h"

@interface ADLoginViewModel ()
@property (nonatomic, weak) UINavigationController  *navigationController;
@property (nonatomic, strong)   id <ADLoginService> service;
@end

@implementation ADLoginViewModel

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController service:(id<ADLoginService>)service {
    self = [super init];
    if (self) {
        _navigationController = navigationController;
        _service = service;
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    @weakify(self);
    _title = @"登录";
    _submitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary *input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSString *mobile = input[@"mobile_number"];
            RACSignal *signal;
//            if (self.loginWithPassword) {
//                NSString *password = input[@"password"];
//                signal = [[ACAPIV2Manager sharedManager] loginWithMobileNumber:mobile password:password];
//            } else {
//                NSString *code = input[@"verification_code"];
//                signal = [[ACAPIV2Manager sharedManager] loginWithMobileNumber:mobile verificationCode:code];
//            }
            
            ACStatusView *view = [ACStatusHUD presentLoadingWithTitle:@"登录中" message:nil];
            [signal subscribeNext:^(id  _Nullable x) {
                [view dismiss];
                
                @strongify(self);
                [self loginWithToken:x];
                [subscriber sendCompleted];
            } error:^(NSError * _Nullable error) {
                [view dismiss];
                [ACStatusHUD presentTitle:@"登录失败" message:error.localizedDescription iconStyle:ACStatusIconTypeError];
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];
    
    _registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
//            SPRegisterImpement *service = [SPRegisterImpement new];
//            SPRegisterViewModel *viewModel = [[SPRegisterViewModel alloc] initWithNavigationController:self.navigationController service:service];
//            [self.service pushViewModel:viewModel];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            SendAuthReq *request = [SendAuthReq new];
//            request.scope = @"snsapi_userinfo";
//            request.state = @"demo";
//            [WXApi sendReq:request];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kWXAuthorizationReturnNotification object:nil];
//}

- (void)loginWithToken:(NSString *)token {
//    [[ACAPIV2Manager sharedManager] updateAuthorizationToken:token];
//    [[SPAppLauncher sharedLauncher].accountManager loginWithJWTToken:token completion:^(NSError * _Nullable error, SPAccount * _Nullable account) {
//        if (error) {
//            [ACStatusHUD presentTitle:@"获取用户信息失败" message:error.localizedDescription iconStyle:ACStatusIconTypeError];
//        } else {
//            [[SPAppLauncher sharedLauncher] login];
//        }
//    }];
}

//- (void)authorizationReturn:(NSNotification *)notification {
//    SendAuthResp *response = [notification object];
//    if (response.errCode == 0) {
//        ACStatusView *hud = [ACStatusHUD presentLoadingWithTitle:nil message:nil];
//        [[[ACAPIV2Manager sharedManager] loginWithWeChatCode:response.code] subscribeNext:^(id  _Nullable x) {
//            [hud dismiss];
//            [[SPAppLauncher sharedLauncher].accountManager loginWithJWTToken:x completion:^(NSError * _Nullable error, SPAccount * _Nullable account) {
//                if (error) {
//                    [ACStatusHUD presentTitle:@"获取用户信息失败" message:error.localizedDescription iconStyle:ACStatusIconTypeError];
//                } else {
//                    [[SPAppLauncher sharedLauncher] login];
//                }
//            }];
//        } error:^(NSError * _Nullable error) {
//            [hud dismiss];
//            [ACStatusHUD presentMessage:error.localizedDescription highlight:YES hapticFeedback:ACStatusHapticFeedbackTypeNone];
//        }];
//    } else {
//        [ACStatusHUD presentMessage:response.errStr highlight:YES hapticFeedback:ACStatusHapticFeedbackTypeNone];
//    }
//}

@end

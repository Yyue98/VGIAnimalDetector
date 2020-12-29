//
//  ADLoginTableViewHelper.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//


#import "ADLoginTableViewHelper.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <QMUIKit/QMUIKit.h>
#import <ACStatusHUD/ACStatusHUD.h>
#import <WeChatSDK-iOS/WXApi.h>
#import "ADTextFieldTableViewCell.h"
#import "ADColorCompatibility.h"
#import "ADAPIManager.h"
#import "ADLoginHelperFooterView.h"

@interface ADLoginTableViewHelper () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign)   BOOL    usePassword;
@property (nonatomic, copy) NSString    *mobileNumber;
@property (nonatomic, copy) NSString    *password;
@property (nonatomic, copy) NSString    *verificationCode;
@property (nonatomic, strong)   QMUIFillButton  *verificationButton;
@property (nonatomic, strong)   dispatch_source_t   countdownTimer;
@property (nonatomic, assign)   NSTimeInterval  verificationInterval;
@property (nonatomic, assign)   BOOL    disableVerificationButton;
@property (nonatomic, weak) RACCommand  *submitCommand;
@property (nonatomic, weak) RACCommand  *registerCommand;
@property (nonatomic, weak) RACCommand  *wechatCommand;
@property (nonatomic, strong)   RACCommand  *loginCommand;
@property (nonatomic, strong)   RACCommand  *verificationCommand;
@end

@implementation ADLoginTableViewHelper

- (instancetype)initWithTableView:(UITableView *)tableView usePassword:(RACSignal *)password submitCommand:(RACCommand *)submitCommand registerCommand:(RACCommand *)registerCommand wechatCommand:(RACCommand *)wechatCommand {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        _tableView.sectionFooterHeight = UITableViewAutomaticDimension;
        
        @weakify(self);
        [password subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.usePassword = [x boolValue];
            [self.tableView reloadData];
        }];
        
        RACSignal *disableSignal = RACObserve(self, disableVerificationButton);
        RACSignal *mobileSignal = RACObserve(self, mobileNumber);

        RACSignal *verificationEnableSignal = [RACSignal combineLatest:@[disableSignal, mobileSignal] reduce:^id(NSNumber *disable, NSString *mobile) {
            return @(![disable boolValue] && [mobile length] > 0);
        }];
        
        _submitCommand = submitCommand;
        _registerCommand = registerCommand;
        _wechatCommand = wechatCommand;
        _verificationCommand = [[RACCommand alloc] initWithEnabled:verificationEnableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                self.disableVerificationButton = YES;
                self.verificationInterval = 60;
                [self startVerificationCountdown];
                [self sendVerificationCode];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        
        RACSignal *passcodeSignal = [RACObserve(self, usePassword) flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
            if ([value boolValue]) {
                return RACObserve(self, password);
            } else {
                return RACObserve(self, verificationCode);
            }
        }];
        
        RACSignal *loginEnableSignal = [RACSignal combineLatest:@[mobileSignal, passcodeSignal] reduce:^id(NSString *mobile, NSString *passcode) {
            return @([passcode length] > 0 && [mobile length] > 0);
        }];
        _loginCommand = [[RACCommand alloc] initWithEnabled:loginEnableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                NSDictionary *paras = @{@"use_password" : @(self.usePassword),
                                        @"mobile_number" : self.mobileNumber ? self.mobileNumber : @"",
                                        @"password" : self.password ? self.password : @"",
                                        @"verification_code" : self.verificationCode ? self.verificationCode : @""};
                [[self.tableView superview] endEditing:YES];
                [self.submitCommand execute:paras];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    
    return self;
}

- (void)startVerificationCountdown {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    _countdownTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_countdownTimer,
                              dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC),
                              NSEC_PER_SEC,
                              NSEC_PER_SEC * 0.1);
    @weakify(self);
    dispatch_source_set_event_handler(_countdownTimer, ^{
        @strongify(self);
        self.verificationInterval -= 1;
        
        if (self.verificationInterval == 0) {
            [self stopVerificationCountdown];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = [NSString stringWithFormat:@"%@s", @((self.verificationInterval))];
                [self.verificationButton setTitle:title forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(_countdownTimer);
}

- (void)stopVerificationCountdown {
    self.disableVerificationButton = NO;
    [self.verificationButton setTitle:@"验证码" forState:UIControlStateNormal];
    dispatch_cancel(self.countdownTimer);
    self.countdownTimer = nil;
}

- (void)sendVerificationCode {
    [[_tableView superview] endEditing:YES];
//    [[[ACAPIV2Manager sharedManager] sendSMSWithMobileNumber:self.mobileNumber] subscribeNext:^(id  _Nullable x) {
//        [ACStatusHUD presentTitle:@"验证码" message:x[@"test_info"] iconStyle:ACStatusIconTypeMessage];
//    } error:^(NSError * _Nullable error) {
//        [ACStatusHUD presentMessage:error.localizedDescription highlight:YES hapticFeedback:ACStatusHapticFeedbackTypeError];
//    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ADLoginHelperFooterView *view = [ADLoginHelperFooterView new];
    view.forgotButton.hidden = !self.usePassword;
    view.registerButton.rac_command = _registerCommand;
    view.submitButton.rac_command = _loginCommand;
    view.wechatButton.rac_command = _wechatCommand;
    view.wechatButton.hidden = ![WXApi isWXAppInstalled];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self cellForMobileNumberAtIndexPath:indexPath];
    } else {
        if (self.usePassword) {
            return [self cellForPasswordAtIndexPath:indexPath];
        }
        
        return [self cellForVerificationCodeAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)cellForMobileNumberAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Mobile";
    ADTextFieldTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textField.font = [UIFont boldSystemFontOfSize:18];
        cell.textField.placeholder = @"手机号";
    }
    
    RAC(self, mobileNumber) = [[RACSignal concat:@[cell.textField.rac_textSignal, RACObserve(cell.textField, text)]] takeUntil:cell.rac_prepareForReuseSignal];
    cell.textField.text = _mobileNumber;
    return cell;
}

- (UITableViewCell *)cellForPasswordAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Password";
    ADTextFieldTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textField.secureTextEntry = YES;
        cell.textField.font = [UIFont boldSystemFontOfSize:18];
        cell.textField.placeholder = @"登录密码";
    }
    
    RAC(self, password) = [[RACSignal concat:@[cell.textField.rac_textSignal, RACObserve(cell.textField, text)]] takeUntil:cell.rac_prepareForReuseSignal];
    cell.textField.text = _password;
    return cell;
}

- (UITableViewCell *)cellForVerificationCodeAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Code";
    ADTextFieldTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        QMUIFillButton *actionButton = [QMUIFillButton new];
        actionButton.fillColor = [ADColorCompatibility systemBlueColor];
        actionButton.cornerRadius = 4;
        actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [actionButton setTitle:@"验证码" forState:UIControlStateNormal];
        actionButton.rac_command = _verificationCommand;
        _verificationButton = actionButton;
        
        cell.textField.font = [UIFont boldSystemFontOfSize:18];
        cell.textField.textColor = [ADColorCompatibility systemGrayColor];
        cell.textField.rightView = _verificationButton;
        cell.textField.rightViewMode = UITextFieldViewModeAlways;
        cell.textField.placeholder = @"输入验证码";
    }
    
    RAC(self, verificationCode) = [[RACSignal concat:@[cell.textField.rac_textSignal, RACObserve(cell.textField, text)]] takeUntil:cell.rac_prepareForReuseSignal];
    cell.textField.text = _verificationCode;
    return cell;
}

@end

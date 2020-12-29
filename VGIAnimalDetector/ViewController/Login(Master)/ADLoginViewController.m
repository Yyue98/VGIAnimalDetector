//
//  ADLoginViewController.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//


#import "ADLoginViewController.h"
#import "ADLoginTableViewHelper.h"
#import "ADColorCompatibility.h"
#import "ADTextFieldTableViewCell.h"

@interface ADLoginViewController ()
@property (nonatomic, strong)   ADLoginViewModel    *viewModel;
@property (nonatomic, strong)   UISegmentedControl  *selectionControl;
@property (nonatomic, strong)   ADLoginTableViewHelper  *helper;
@end

@implementation ADLoginViewController

- (instancetype)initWithViewModel:(ADLoginViewModel *)viewModel {
    self = [super initWithStyle:UITableViewStyleInsetGrouped];
    if (self) {
        _viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"验证码登录",
                                                                                     @"密码登录"]];
    segmentControl.apportionsSegmentWidthsByContent = YES;
    segmentControl.tintColor = [ADColorCompatibility secondarySystemFillColor];
    segmentControl.selectedSegmentIndex = 0;
    
    _selectionControl = segmentControl;
    self.navigationItem.titleView = _selectionControl;
    [self bindViewModel];
}

- (void)bindViewModel {
    self.title = _viewModel.title;
    RAC(self.viewModel, loginWithPassword) = [[_selectionControl rac_signalForControlEvents:UIControlEventValueChanged] map:^id _Nullable(UISegmentedControl *value) {
        return @(value.selectedSegmentIndex == 1);
    }];
    
    _helper = [[ADLoginTableViewHelper alloc] initWithTableView:self.tableView usePassword:RACObserve(self.viewModel, loginWithPassword) submitCommand:_viewModel.submitCommand registerCommand:_viewModel.registerCommand wechatCommand:_viewModel.loginCommand];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    ADTextFieldTableViewCell *cell = (ADTextFieldTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell.textField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tableView endEditing:YES];
}

@end

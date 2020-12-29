//
//  ADUserViewController.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADUserViewController.h"
#import "ADUserTableViewHelper.h"
#import "ADLoginImplement.h"
#import "ADLoginViewModel.h"
#import "ADLoginViewController.h"

@interface ADUserViewController ()
@property (nonatomic, strong)   ADUserViewModel *viewModel;
@property (nonatomic, strong)   ADUserTableViewHelper   *helper;
@property (nonatomic, strong)   UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong)   id <ADUserService>  service;

@end

@implementation ADUserViewController

- (instancetype)initWithViewModel:(ADUserViewModel *)viewModel {
    self = [super initWithStyle:UITableViewStyleInsetGrouped];
    if (self) {
        _viewModel = viewModel;
        _service = _viewModel.service;

    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(loginWithSMSorPassword)];
    self.navigationItem.rightBarButtonItem = _rightBarButtonItem;
    
    [self bindViewModel];
}

- (void)bindViewModel {
    self.title = _viewModel.title;
    _helper = [[ADUserTableViewHelper alloc] initWithTableView:self.tableView sourceSignal:RACObserve(self.viewModel, self.temp) selectionCommand:_viewModel.selectionCommand service:_viewModel.service];
}

- (void) loginWithSMSorPassword {
    UINavigationController *navigationController = [UINavigationController new];

    ADLoginImplement *service = [[ADLoginImplement alloc] initWithNavigationController:navigationController];
    ADLoginViewModel *viewModel = [[ADLoginViewModel alloc] initWithNavigationController:navigationController service:service];
    [self.service pushViewModel:viewModel];

}
@end

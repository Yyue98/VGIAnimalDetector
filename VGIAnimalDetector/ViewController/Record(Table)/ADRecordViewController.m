//
//  ADRecordViewController.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADRecordViewController.h"
#import <ACStatusHUD/ACStatusHUD.h>
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import "ADRecordTableViewHelper.h"

@interface ADRecordViewController ()
@property (nonatomic, strong)   ADRecordViewModel *viewModel;
@property (nonatomic, strong)   ADRecordTableViewHelper  *helper;

@end

@implementation ADRecordViewController

- (instancetype)initWithViewModel:(ADRecordViewModel *)viewModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [UIColor grayColor];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    self.tableView.refreshControl = refreshControl;
    [self bindViewModel];
}

- (void)bindViewModel {
    self.title = _viewModel.title;
    self.tableView.refreshControl.rac_command = _viewModel.refreshCommand;
    _helper = [[ADRecordTableViewHelper alloc] initWithTableView:self.tableView sourceSignal:RACObserve(self.viewModel, records) selectionCommand:_viewModel.selectionCommand viewModel:self.viewModel];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_viewModel.refreshCommand execute:nil];
}
@end

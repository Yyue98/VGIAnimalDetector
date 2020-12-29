//
//  ADCatViewController.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADCatViewController.h"
#import <ACStatusHUD/ACStatusHUD.h>
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import "ADCatTableViewHelper.h"

@interface ADCatViewController ()
@property (nonatomic, strong)   ADCatViewModel *viewModel;
@property (nonatomic, strong)   ADCatTableViewHelper   *helper;

@end

@implementation ADCatViewController

- (instancetype)initWithViewModel:(ADCatViewModel *)viewModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self bindViewModel];
}

- (void)bindViewModel {
    self.title = _viewModel.title;
    _helper = [[ADCatTableViewHelper alloc] initWithTableView:self.tableView sourceSignal:RACObserve(self.viewModel, self.temp) selectionCommand:_viewModel.selectionCommand];
}

@end

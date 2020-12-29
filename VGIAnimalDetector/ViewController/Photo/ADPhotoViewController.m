//
//  ADPhotoViewController.m
//   VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADPhotoViewController.h"
#import <Mapbox/Mapbox.h>
#import <ACStatusHUD/ACStatusHUD.h>
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <QMUIKit/QMUIKit.h>
#import "UIViewController+ADContainerViewController.h"
#import "ADInformationTableViewHelper.h"
#import "UIView+Shadow.h"
#import "ADAppLauncher.h"
#import "SPBorderLableView.h"

@interface ADPhotoViewController ()
@property (nonatomic, strong)   ADPhotoViewModel *viewModel;

@property (nonatomic, assign)   UIEdgeInsets    contentInsets;
@property (nonatomic, strong)   ADInformationTableViewHelper   *helper;
@property (nonatomic, strong)   UIBarButtonItem *rightBarButtonItem;


@end

@implementation ADPhotoViewController

- (instancetype)initWithViewModel:(ADPhotoViewModel *)viewModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _viewModel = viewModel;
        _contentInsets = UIEdgeInsetsZero;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentInsets = [self.ad_containerViewController contentEdgeInsets];
    
//    CGFloat size = 50;
//    UIColor *color = [UIColor systemBlueColor] ;
//    FAKMaterialIcons *icon = [FAKMaterialIcons eyeIconWithSize:size];
//    [icon addAttribute:NSForegroundColorAttributeName value:color];
//
    _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarStyleDefault target:nil action:nil];
//    _rightBarButtonItem.image = [icon imageWithSize:CGSizeMake(24, 24)];
    self.navigationItem.rightBarButtonItem = _rightBarButtonItem;
    
    [self bindViewModel];
}



- (void)bindViewModel {
    self.title = _viewModel.title;
    _helper = [[ADInformationTableViewHelper alloc] initWithTableView:self.tableView sourceSignal:RACObserve(self.viewModel, self.temp) selectionCommand:_viewModel.selectionCommand ViewModel:_viewModel];
    _rightBarButtonItem.rac_command = _helper.submitCommand;

}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


@end

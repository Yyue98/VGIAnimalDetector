//
//  ADMapViewController.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADMapViewController.h"
#import <Mapbox/Mapbox.h>
#import <ACStatusHUD/ACStatusHUD.h>
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import "UIViewController+ADContainerViewController.h"
#import "UIView+Shadow.h"
#import "ADMapboxController.h"
#import "UIView+Shadow.h"
#import "ADAppLauncher.h"
#import "SPLegendView.h"
#import "SPUserLocationButton.h"
#import "SPPositioningModeButton.h"

@interface ADMapViewController () <MGLMapViewDelegate>
@property (nonatomic, strong)   ADMapViewModel *viewModel;

//@property (nonatomic, copy) ACLocation  *location;
@property (nonatomic, strong)   MGLMapView  *mapView;
@property (nonatomic, assign)   UIEdgeInsets    contentInsets;
@property (nonatomic, strong)   SPUserLocationButton    *centerButton;
@property (nonatomic, strong)   SPPositioningModeButton *positionButton;
@property (nonatomic, strong)   SPLegendView    *legendView;

@end

@implementation ADMapViewController

- (instancetype)initWithViewModel:(ADMapViewModel *)viewModel {
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
    
    [self setupMGLMapView];
    [self setupViews];
    [self registerNotifications];
//    [self syncUserDetails];
    [self bindViewModel];
}

- (void)setupMGLMapView {
    MGLMapView *mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds styleURL:[NSURL URLWithString:@"mapbox://styles/michaelwu0204/ck7byz09i09221iqhwvfldvi5"]];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView.logoView.hidden = YES;
    mapView.attributionButton.hidden = YES;
    mapView.automaticallyAdjustsContentInset = NO;
    
    mapView.delegate = self;
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(32.081553, 118.9152222) zoomLevel:9 animated:NO];

    [[ADMapboxController sharedController] addToMapView:mapView];
    [[ADMapboxController sharedController] addNotifyObserver:self];
    [[ADPositioningManager sharedManager] addNotifyObserver:self];
    
    [self.view addSubview:mapView];
    _mapView = mapView;
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupViews {
    _centerButton = [[SPUserLocationButton alloc] initWithButtonMode:SPUserLocationButtonModeNone];
    _centerButton.titleTextColor = [UIColor flatBlackColor];
    _centerButton.fillColor = [UIColor whiteColor];
    _centerButton.highlightedBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [_centerButton addShadowWithCornerRadius:4];
    [self.view addSubview:_centerButton.layoutView];


    [_centerButton.layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.right.equalTo(self.view.mas_right).with.offset(-8);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-self.contentInsets.bottom - 8);
    }];
}

- (void)bindViewModel {
    _centerButton.rac_command = _viewModel.centerCommand;
   
}

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(containerViewControllerWillAnimate:) name:ADContainerViewControllerWillAnimateToPositionNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(containerViewControllerDidChange:) name:ADContainerViewControllerDidChangeToPositionNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ADContainerViewControllerWillAnimateToPositionNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ADContainerViewControllerDidChangeToPositionNotification object:nil];
    [[ADMapboxController sharedController] removeNotifyObserver:self];
    [[ADPositioningManager sharedManager] removeNotifyObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

@end

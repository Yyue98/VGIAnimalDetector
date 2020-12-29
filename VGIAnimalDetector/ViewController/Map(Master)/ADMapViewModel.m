//
//  ADMapViewModel.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADMapViewModel.h"
#import "ADMapboxController.h"
#import "ADContainerViewController.h"
#import "ADPositioningManager.h"
#import "ADAppLauncher.h"

@interface ADMapViewModel ()
@property (nonatomic, strong)   id <ADMapService>  service;
@end

@implementation ADMapViewModel

- (instancetype)initWithService:(id<ADMapService>)service {
    self = [super init];
    if (self) {
        _service = service;
        [self initialize];
    }
    
    return self;
}

- (void)dealloc {
    [[ADMapboxController sharedController] removeNotifyObserver:self];
}

- (void)initialize {
    [[ADMapboxController sharedController] addNotifyObserver:self];


    _centerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            ADLocation *location = [[ADPositioningManager sharedManager] locationForMapMatching:NO];
            MGLMapView *mapView = [ADMapboxController sharedController].mapView;
            MGLMapCamera *camera = [MGLMapCamera cameraLookingAtCenterCoordinate:location.coordinate altitude:mapView.camera.altitude pitch:0 heading:0];
            [mapView flyToCamera:camera withDuration:0.5 completionHandler:nil];


            [subscriber sendCompleted];
            return nil;
        }];
    }];
}


@end


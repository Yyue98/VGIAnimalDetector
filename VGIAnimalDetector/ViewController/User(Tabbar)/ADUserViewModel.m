//
//  ADUserViewModel.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADUserViewModel.h"
#import <LEEAlert/LEEAlert.h>
#import "ADAppLauncher.h"
#import "ADColorCompatibility.h"
//#import "SPAccountManager.h"


@interface ADUserViewModel ()
@end

@implementation ADUserViewModel

- (instancetype)initWithService:(id<ADUserService>)service {
    self = [super init];
    if (self) {
        _service = service;
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    _title = NSLocalizedString(@"图鉴", nil);
    
//    _centerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            ADLocation *location = [[ADPositioningManager sharedManager] locationForMapMatching:NO];
//            MGLMapView *mapView = [ADMapboxController sharedController].mapView;
//            MGLMapCamera *camera = [MGLMapCamera cameraLookingAtCenterCoordinate:location.coordinate altitude:mapView.camera.altitude pitch:0 heading:0];
//            [mapView flyToCamera:camera withDuration:0.5 completionHandler:nil];
//
//
//            [subscriber sendCompleted];
//            return nil;
//        }];
//    }];
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPAccountDetailsSyncSuccessNotification object:nil];
}

//- (void)accountUpdate:(NSNotification *)notification {
//    self.account = [notification object];
//}

@end

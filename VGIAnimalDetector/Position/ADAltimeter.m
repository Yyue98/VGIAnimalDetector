//
//  ADAltimeter.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADAltimeter.h"
#import <CoreMotion/CoreMotion.h>

@interface ADAltimeter ()
@property (nonatomic, strong)   CMAltimeter *altimeter;
@property (nonatomic, strong)   NSOperationQueue    *updateQueue;
@property (nonatomic, copy) CMAltitudeData  *altitude;
@end

@implementation ADAltimeter

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _altimeter = [CMAltimeter new];
    _updateQueue = [NSOperationQueue mainQueue];
    return self;
}

- (void)startUpdating
{
    __weak typeof(self) _self = self;
    [_altimeter startRelativeAltitudeUpdatesToQueue:_updateQueue withHandler:^(CMAltitudeData * _Nullable altitudeData, NSError * _Nullable error) {
        __strong typeof(_self) self = _self;
        if (error) return;
        self.altitude = altitudeData;
    }];
}

- (void)stopUpdating
{
    [_altimeter stopRelativeAltitudeUpdates];
    _altitude = nil;
}


@end

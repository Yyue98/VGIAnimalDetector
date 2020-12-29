//
//  ADAltitudeMonitor.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import "ADAltitudeMonitor.h"

#import <CoreMotion/CoreMotion.h>
#import "ADAltitudeStack.h"

#define AC_ALTITUDE_VALUE   2.6

@interface ADAltitudeMonitor ()
@property (nonatomic, strong)   CMAltimeter *altimeter;
@property (nonatomic, strong)   ADAltitudeStack *stack;
@property (nonatomic, copy) NSNumber    *lastValue;
@end

@implementation ADAltitudeMonitor

- (instancetype)init {
    self = [super init];
    if (self) {
        _altimeter = [CMAltimeter new];
    }
    
    return self;
}

- (void)starAltitudeMonitoring {
    if (_monitoring) return;
    
    _monitoring = YES;
    _stack = [[ADAltitudeStack alloc] initWithSize:4];
    [_altimeter startRelativeAltitudeUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAltitudeData * _Nullable altitudeData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"ADAltitudeMonitor did failed to update relative altitude: %@", error.localizedDescription);
            return;
        }
        
        [self updateAltitudeData:altitudeData];
    }];
}

- (void)stopAltitudeMonitoring {
    if (!_monitoring) return;
    
    _monitoring = NO;
    [_altimeter stopRelativeAltitudeUpdates];
    _stack = nil;
    _lastValue = nil;
}

- (void)updateAltitudeData:(CMAltitudeData *)data {
    [_stack addAltitudeRelativeValue:data.relativeAltitude];
    if (![_stack readyForOutput]) return;
    
    double meanValue = [_stack meanAltitudeValue];
    NSInteger value = floor(meanValue / AC_ALTITUDE_VALUE);
    BOOL notify = NO;
    
    if (!_lastValue) {
        notify = value != 0;
    } else if ([_lastValue doubleValue] != value) {
        notify = YES;
    }
    
    if (notify) {
        _lastValue = @(value);
        if (self.delegate && [self.delegate respondsToSelector:@selector(altitudeMonitor:didDetectSignificantAltitudeChange:)]) {
            [self.delegate altitudeMonitor:self didDetectSignificantAltitudeChange:value];
        }
    }
}
@end

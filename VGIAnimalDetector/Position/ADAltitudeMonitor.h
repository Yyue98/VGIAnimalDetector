//
//  ADAltitudeMonitor.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ADAltitudeMonitor;

@protocol ADAltitudeMonitorDelegate <NSObject>
@required

- (void)altitudeMonitor:(ADAltitudeMonitor *)monitor didDetectSignificantAltitudeChange:(double)value;

@end

@interface ADAltitudeMonitor : NSObject

@property (nonatomic, weak) id <ADAltitudeMonitorDelegate>  delegate;
@property (nonatomic, assign, readonly, getter=isMonitoring) BOOL   monitoring;

- (void)starAltitudeMonitoring;
- (void)stopAltitudeMonitoring;

@end

NS_ASSUME_NONNULL_END

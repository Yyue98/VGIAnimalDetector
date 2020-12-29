//
//  ADMGLLocationProvider.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>
#import "ADPositioningManager.h"
#import "ADSensorMonitorManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADMGLLocationProvider : NSObject <MGLLocationManager>

@property (nonatomic, strong, readonly) ADSensorMonitorManager  *sensorManager;


- (void)switchUpdatingLocationInBackground:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END

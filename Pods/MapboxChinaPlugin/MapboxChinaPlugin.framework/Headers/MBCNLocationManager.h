#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>

/**
 The class that you use to start and stop the delivery of location-related events.
 
 Instances of this class use `MBCNGCJCoordinateTransformer` to convert between
 WGS-84 to the GCJ-02 coordinate systems in China.
 */
@interface MBCNLocationManager : NSObject<MGLLocationManager>

@end

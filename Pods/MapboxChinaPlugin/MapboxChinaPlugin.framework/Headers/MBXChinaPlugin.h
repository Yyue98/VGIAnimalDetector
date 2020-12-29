
#import <Mapbox/Mapbox.h>

@interface MBXChinaPlugin : NSObject

/**
 Add the Mapbox China Plugin to a `MGLMapView`. This will:
 * Set up a transformer that will shift WGS-84 coordinates to the GCJ-02 coordinate system.
 * Switch the map's style to one of three Mapbox China styles: Mapbox Streets (the default style), Light, or Dark.
 
 @param mapView The map view whose contents will be shifted.
 */
- (void)addToMapView:(MGLMapView *)mapView;

@end

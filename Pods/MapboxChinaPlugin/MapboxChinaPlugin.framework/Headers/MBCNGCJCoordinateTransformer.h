#import <Foundation/Foundation.h>

// The name of the `MBCNGCJCoordinateTransformer`. `MGLConvertToDatumTransformerName` is registered when the China plugin is initialized.
extern NSString * const MGLConvertToDatumTransformerName;

@protocol MGLFeature;
@class MGLShape;

/**
 `MBCNGCJCoordinateTransformer` is an `NSValueTransformer` subclass that converts coordinates systems from WGS-84 to GCJ-02. The transformer shifts coordinates of `CLLocationCoordinate2D` and `MGLShape` subclass objects.
 Please note that the transformer only shifts coordinates in China.
 */
@interface MBCNGCJCoordinateTransformer : NSValueTransformer

/**
 Shift a single coordinate from the WGS-84 coordinate system to GCJ-2.
 
 @param coordinate The WGS-84 coordinate to transform.
 @return The GCJ-02 coordinate.
 */
- (CLLocationCoordinate2D)transformedCoordinate:(CLLocationCoordinate2D)coordinate;


/**
 Shifts the coordinates for objects that are subclasses of `MGLShape` from WGS-84 to GCJ-02. If the original shape is an `MGLFeature`, use `(MGLShape<MGLFeature> *)transformedFeature:(MGLShape<MGLFeature> *)feature` in order to preserve the feature's attributes.
 
 @param shape A shape with WGS-84 coordinates.
 @return A shape with GCJ-02 coordinates.
 */
- (MGLShape *)transformedShape:(MGLShape *)shape;


/**
 Shifts the coordinates for `MGLShape` objects that conform to the `MGLFeature` protociol.
 
 @param feature A feature with WGS-84 coordinates.
 @return A feature with GCJ-02 coordinates.
 */
- (MGLShape<MGLFeature> *)transformedFeature:(MGLShape<MGLFeature> *)feature;


@end

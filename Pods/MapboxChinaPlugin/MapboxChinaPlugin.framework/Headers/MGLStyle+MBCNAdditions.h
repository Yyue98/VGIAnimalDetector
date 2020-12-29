#import <Mapbox/Mapbox.h>

@interface MGLStyle (MBCNAdditions)


/**
 Returns the URL to the current version of the Mapbox Streets Chinese style as of
 publication.
 
 Streets is a general-purpose style with detailed road and transit networks.
 
 `MGLMapView` uses Mapbox Streets Chinese by default when Mapbox China Plugin is installed.
 
 @warning The return value may change in a future release of the SDK. If you use
 any feature that depends on a specific aspect of a default style – for
 instance, the minimum zoom level that includes roads – use the
 `-mbcn_streetsChineseStyleURLWithVersion:` method instead. Such details may change
 significantly from version to version.
 */
+ (NSURL *)mbcn_streetsChineseStyleURL;

/**
 Returns the URL to the given version of the Mapbox Streets Chinese style.
 
 Streets is a general-purpose style with detailed road and transit networks.
 
 Mapbox China Plugin uses Mapbox Streets Chinese when no style
 is specified explicitly.
 
 @param version A specific version of the style.
 */
+ (NSURL *)mbcn_streetsChineseStyleURLWithVersion:(NSInteger)version;

/**
 Returns the URL to the current version of the Mapbox Dark Chinese style as of
 publication.
 
 @warning The return value may change in a future release of the SDK. If you use
 any feature that depends on a specific aspect of a default style – for
 instance, the minimum zoom level that includes roads – use the
 `-mbcn_darkChineseStyleURLWithVersion:` method instead. Such details may change
 significantly from version to version.
 */
+ (NSURL *)mbcn_darkChineseStyleURL;

/**
 Returns the URL to the given version of the Mapbox Light Chinese style.
 
 @param version A specific version of the style.
 */
+ (NSURL *)mbcn_darkChineseStyleURLWithVersion:(NSInteger)version;

/**
 Returns the URL to the current version of the Mapbox Dark Chinese style as of
 publication.
 
 @warning The return value may change in a future release of the SDK. If you use
 any feature that depends on a specific aspect of a default style – for
 instance, the minimum zoom level that includes roads – use the
 `-mbcn_darkChineseStyleURLWithVersion:` method instead. Such details may change
 significantly from version to version.
 */
+ (NSURL *)mbcn_lightChineseStyleURL;

/**
 Returns the URL to the given version of the Mapbox Dark Chinese style.
 
 @param version A specific version of the style.
 */
+ (NSURL *)mbcn_lightChineseStyleURLWithVersion:(NSInteger)version;

@end

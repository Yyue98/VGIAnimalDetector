//
//  Header.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#ifndef ADGeometry_h
#define ADGeometry_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_INLINE CLLocationDistance ADMetersBetweenMapCoordinates(CLLocationCoordinate2D from, CLLocationCoordinate2D to) {
    return MKMetersBetweenMapPoints(MKMapPointForCoordinate(from), MKMapPointForCoordinate(to));
}

NS_INLINE BOOL ADMapCoordinateEqualsToCoordinate(CLLocationCoordinate2D lhs, CLLocationCoordinate2D rhs) {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude;
}

NS_INLINE double ACDegreeToRadians(CLLocationDegrees degrees) {
    return degrees * M_PI / 180.0;
}

NS_INLINE CLLocationDegrees ACRadiansToDegree(double radians) {
    return radians * 180.0 / M_PI;
}

/// Return heading direction with range from 0 to 359.9
/// ref:  https://stackoverflow.com/questions/3925942/cllocation-category-for-calculating-bearing-w-haversine-function
NS_INLINE CLLocationDirection ACDirectionAlongCoordinates(CLLocationCoordinate2D from, CLLocationCoordinate2D to) {
    double lat1 = ACDegreeToRadians(from.latitude);
    double lon1 = ACDegreeToRadians(from.longitude);

    double lat2 = ACDegreeToRadians(to.latitude);
    double lon2 = ACDegreeToRadians(to.longitude);

    double dLon = lon2 - lon1;

    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    double radiansBearing = atan2(y, x);

    CLLocationDirection direction = ACRadiansToDegree(radiansBearing);
    if (direction < 0) {
        direction += 360;
    } else if (direction > 360) {
        direction -= 360;
    }
    
    return direction;
}


#endif /* ADGeometry_h */


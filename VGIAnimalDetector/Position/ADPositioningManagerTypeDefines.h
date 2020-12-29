//
//  ADPositioningManagerTypeDefines.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#ifndef ADPositioningManagerTypeDefines_h
#define ADPositioningManagerTypeDefines_h

typedef NS_ENUM(NSUInteger, ADPositioningSourceType) {
    //  Positioning source update by beacon
    //  Corresponded accuracy is ADPositioningSourceAccuracyConfidence
    ADPositioningSourceTypeBeacon   = 0,
    
    //  Positioning source update by location
    //  Corresponded accuracy will based on horizontalAccuracy
    ADPositioningSourceTypeLocation = 1
};

typedef NS_ENUM(NSInteger, ADPositioningSourceAccuracy) {
    //  Determine positioning accuracy is invalid
    //  CLLocation horizontalAccuracy is negtive
    ADPositioningSourceAccuracyInvalid      = -1,
    
    //  Determine positioning accuracy is low
    //  CLLocation horizontalAccuracy lower than 30 meters
    ADPositioningSourceAccuracyLow          = 0,
    
    //  Determine positioning accuracy is medium
    //  CLLocation horizontalAccuracy lower than 10 meters and higher than 30 meters
    ADPositioningSourceAccuracyMedium       = 1,
    
    //  Determine positioning accuracy is high
    //  CLLocation horizontalAccuracy higher or equals to 10 meters
    ADPositioningSourceAccuracyHigh         = 2,
    
    //  Determine positioning accuracy is in confidence range
    //  Beacon confidence range is 8 meters
    ADPositioningSourceAccuracyConfidence   = 3
};

#endif /* ADPositioningManagerTypeDefines_h */

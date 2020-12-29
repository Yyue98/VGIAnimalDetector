//
//  ADUserLocationAnnotationView.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/21.
//

#import "ADUserLocationAnnotationView.h"
#import <ChameleonFramework/Chameleon.h>
#import "ADUserLocationView.h"

#define AC_ANNOTAION_SIZE   48

@interface ADUserLocationNavigationHeading : NSObject
@property (nonatomic, assign)   CLLocationDirection heading;
@end

@implementation ADUserLocationNavigationHeading
@end

@interface ADUserLocationAnnotationView ()
@property (nonatomic, strong)   ADUserLocationView  *contentView;
@property (nonatomic, assign)   CGFloat size;
@property (nonatomic, strong)   ADUserLocationNavigationHeading *navigationHeading;
@end

@implementation ADUserLocationAnnotationView

- (instancetype)init {
    self = [super init];
    if (self) {
        _contentView = [[ADUserLocationView alloc] initWithSize:AC_ANNOTAION_SIZE];
        _contentView.styleColor = FlatSkyBlue;
        [self addSubview:_contentView];
        self.bounds = CGRectMake(0, 0, AC_ANNOTAION_SIZE, AC_ANNOTAION_SIZE);
    }

    return self;
}

- (void)setState:(ADUserLocationState)state {
    if (_state == state) return;
    _state = state;
    [self update];
}

- (void)setIgnoreUserLocationHeading:(BOOL)ignoreUserLocationHeading {
    _ignoreUserLocationHeading = ignoreUserLocationHeading;
    if (!ignoreUserLocationHeading) {
        _navigationHeading = nil;
    }
}
 
- (void)layoutSubviews {
    [super layoutSubviews];
    _contentView.frame = self.bounds;
}

- (BOOL)navigationModeForState:(ADUserLocationState)state {
    switch (state) {
        case ADUserLocationStateUnknown:
        case ADUserLocationStateNormal:
        case ADUserLocationStateConfidence:
        case ADUserLocationStateDisabled:   return NO;
        case ADUserLocationStateNavigation:
        case ADUserLocationStateNavigationDisabled:
        default:                            return YES;
    }
}

- (UIColor *)styleColorForState:(ADUserLocationState)state {
    switch (state) {
        case ADUserLocationStateUnknown:    return FlatGray;
        case ADUserLocationStateNormal:     return FlatSkyBlue;
        case ADUserLocationStateConfidence: return FlatPurple;
        case ADUserLocationStateDisabled:   return FlatGray;
        case ADUserLocationStateNavigation: return FlatSkyBlue;
        case ADUserLocationStateNavigationDisabled:
        default:                            return FlatGray;
    }
}

// -update is a method inherited from MGLUserLocationAnnotationView. It updates the appearance of the user location annotation when needed. This can be called many times a second, so be careful to keep it lightweight.
- (void)update {
    if (CLLocationCoordinate2DIsValid(self.userLocation.coordinate)) {
        _contentView.navigationMode = [self navigationModeForState:_state];
        _contentView.styleColor = [self styleColorForState:_state];
        [self updateHeading];
    }
}
 
- (void)updateHeading {
    CLLocationDirection heading = 0;
    BOOL show = NO;
    if (_ignoreUserLocationHeading) {
        if (_navigationHeading) {
            heading = _navigationHeading.heading;
            show = YES;
        } else {
            show = NO;
        }
    } else {
        heading = self.userLocation.heading.trueHeading;
        show = self.userLocation.heading.trueHeading > 0;
    }
    
    if (show) {
        _contentView.showHeadingIndicator = YES;
        [self updateAnnotationViewHeading:heading];
    } else {
        _contentView.showHeadingIndicator = NO;
    }
}

- (void)updateAnnotationViewHeading:(CLLocationDirection)heading {
    CGFloat rotation = -MGLRadiansFromDegrees(self.mapView.direction - heading);
    if (fabs(rotation) > 0.01) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
            _contentView.rotation = CGAffineTransformRotate(CGAffineTransformIdentity, rotation);
        [CATransaction commit];
    }
}

- (void)updateDirectionWithNavigationHeading:(CLLocationDegrees)heading {
    if (!_navigationHeading) {
        _navigationHeading = [ADUserLocationNavigationHeading new];
    }
    
    _navigationHeading.heading = heading;
    [self updateHeading];
}

@end

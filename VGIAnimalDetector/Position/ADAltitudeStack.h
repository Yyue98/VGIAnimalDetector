//
//  ADAltitudeStack.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADAltitudeStack : NSObject
- (instancetype)initWithSize:(NSUInteger)size;
- (void)addAltitudeRelativeValue:(NSNumber *)value;
- (BOOL)readyForOutput;
- (double)meanAltitudeValue;
@end

NS_ASSUME_NONNULL_END

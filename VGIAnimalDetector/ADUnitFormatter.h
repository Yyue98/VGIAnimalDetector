//
//  ADUnitFormatter.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADUnitFormatter : NSObject
+ (instancetype)sharedFormatter;
- (NSString *)formattedStringWithTimeInterval:(NSTimeInterval)interval;
- (NSDate *)dateFromFormattedString:(NSString *)string;
- (NSDate *)dateFromTimeInterval:(NSTimeInterval)interval;
- (NSString *)stringFromDate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END

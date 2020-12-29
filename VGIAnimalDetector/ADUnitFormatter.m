//
//  ADUnitFormatter.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/28.
//

#import "ADUnitFormatter.h"

@interface ADUnitFormatter ()
@property (nonatomic, strong)   NSDateFormatter *stringFormatter;
@property (nonatomic, strong)   NSISO8601DateFormatter *dateFormatter;
@property (nonatomic, strong)   NSDateComponentsFormatter *timeFormatter;
@end

@implementation ADUnitFormatter

+ (instancetype)sharedFormatter {
    static ADUnitFormatter *_formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _formatter = [ADUnitFormatter new];
    });
    
    return _formatter;
}

- (NSDateComponentsFormatter *)timeFormatter {
    if (!_timeFormatter) {
        _timeFormatter = [NSDateComponentsFormatter new];
        _timeFormatter.allowedUnits =  NSCalendarUnitMinute | NSCalendarUnitHour;
        _timeFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleShort;
    }
    
    return _timeFormatter;
}

- (NSISO8601DateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSISO8601DateFormatter new];
        _dateFormatter.timeZone = [NSTimeZone localTimeZone];
    }
    
    return _dateFormatter;
}

- (NSDateFormatter *)stringFormatter {
    if (!_stringFormatter) {
        _stringFormatter = [NSDateFormatter new];
        _stringFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        _stringFormatter.dateFormat = @"yyyy-MM-dd a HH:mm EEEE";
    }
    
    return _stringFormatter;
}


- (NSString *)formattedStringWithTimeInterval:(NSTimeInterval)interval {
    return [self.timeFormatter stringFromTimeInterval:interval];
}

- (NSDate *)dateFromFormattedString:(NSString *)string {
    if ([string isKindOfClass:[NSNumber class]] || [string isKindOfClass:[NSNull class]]) return nil;
    if (![string length]) return nil;
    
    NSDate *date = [self.dateFormatter dateFromString:string];
    return date;
}

- (NSDate *)dateFromTimeInterval:(NSTimeInterval)interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return date;
}

- (NSString *)stringFromDate:(NSDate *)date {
    return [self.stringFormatter stringFromDate:date];
}

@end

//
//  ADColorCompatibility.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//
#import "ADColorCompatibility.h"
#import <ChameleonFramework/Chameleon.h>

#define IOS_DARK_MODE_AVAILABLE @available(iOS 13.0, *)

@implementation ADColorCompatibility

+ (UIColor *)labelColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor labelColor];
    } else {
        return [UIColor colorWithHexString:@"#000000ff"];
    }
}

+ (UIColor *)secondaryLabelColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor secondaryLabelColor];
    } else {
        return [UIColor colorWithHexString:@"#3c3c4399"];
    }
}

+ (UIColor *)tertiaryLabelColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor tertiaryLabelColor];
    } else {
        return [UIColor colorWithHexString:@"#3c3c434c"];
    }
}

+ (UIColor *)quaternaryLabelColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor quaternaryLabelColor];
    } else {
        return [UIColor colorWithHexString:@"#3c3c432d"];
    }
}

+ (UIColor *)systemFillColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemFillColor];
    } else {
        return [UIColor colorWithHexString:@"#78788033"];
    }
}
+ (UIColor *)secondarySystemFillColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor secondarySystemFillColor];
    } else {
        return [UIColor colorWithHexString:@"#78788028"];
    }
}

+ (UIColor *)tertiarySystemFillColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor tertiarySystemFillColor];
    } else {
        return [UIColor colorWithHexString:@"#7676801e"];
    }
}

+ (UIColor *)quaternarySystemFillColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor quaternarySystemFillColor];
    } else {
        return [UIColor colorWithHexString:@"#74748014"];
    }
}

+ (UIColor *)placeholderTextColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor placeholderTextColor];
    } else {
        return [UIColor colorWithHexString:@"#3c3c432d"];
    }
}

+ (UIColor *)systemBackgroundColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemBackgroundColor];
    } else {
        return [UIColor colorWithHexString:@"#ffffffff"];
    }

}

+ (UIColor *)secondarySystemBackgroundColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor secondarySystemBackgroundColor];
    } else {
        return [UIColor colorWithHexString:@"#f2f2f7ff"];
    }
}

+ (UIColor *)tertiarySystemBackgroundColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor tertiarySystemBackgroundColor];
    } else {
        return [UIColor colorWithHexString:@"#ffffffff"];
    }
}

+ (UIColor *)systemGroupedBackgroundColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemGroupedBackgroundColor];
    } else {
        return [UIColor colorWithHexString:@"#f2f2f7ff"];
    }
}

+ (UIColor *)secondarySystemGroupedBackgroundColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor secondarySystemGroupedBackgroundColor];
    } else {
        return [UIColor colorWithHexString:@"#ffffffff"];
    }
}

+ (UIColor *)tertiarySystemGroupedBackgroundColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor tertiarySystemGroupedBackgroundColor];
    } else {
        return [UIColor colorWithHexString:@"#f2f2f7ff"];
    }
}

+ (UIColor *)separatorColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor separatorColor];
    } else {
        return [UIColor colorWithHexString:@"#3c3c4349"];
    }
}

+ (UIColor *)opaqueSeparatorColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor opaqueSeparatorColor];
    } else {
        return [UIColor colorWithHexString:@"#c6c6c8ff"];
    }
}

+ (UIColor *)linkColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor linkColor];
    } else {
        return [UIColor colorWithHexString:@"#007affff"];
    }
}

+ (UIColor *)darkTextColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor darkTextColor];
    } else {
        return [UIColor colorWithHexString:@"#000000ff"];
    }
}

+ (UIColor *)lightTextColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor lightTextColor];
    } else {
        return [UIColor colorWithHexString:@"#ffffff99"];
    }
}

+ (UIColor *)systemBlueColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemBlueColor];
    } else {
        return [UIColor colorWithHexString:@"#007affff"];
    }
}

+ (UIColor *)systemGreenColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemGreenColor];
    } else {
        return [UIColor colorWithHexString:@"#34c759ff"];
    }
}

+ (UIColor *)systemIndigoColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemIndigoColor];
    } else {
        return [UIColor colorWithHexString:@"#5856d6ff"];
    }
}

+ (UIColor *)systemOrangeColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemOrangeColor];
    } else {
        return [UIColor colorWithHexString:@"#ff9500ff"];
    }
}

+ (UIColor *)systemPinkColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemPinkColor];
    } else {
        return [UIColor colorWithHexString:@"#ff2d55ff"];
    }
}

+ (UIColor *)systemPurpleColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemPurpleColor];
    } else {
        return [UIColor colorWithHexString:@"#af52deff"];
    }
}

+ (UIColor *)systemRedColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemRedColor];
    } else {
        return [UIColor colorWithHexString:@"#ff3b30ff"];
    }
}

+ (UIColor *)systemTealColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemTealColor];
    } else {
        return [UIColor colorWithHexString:@"#5ac8faff"];
    }
}

+ (UIColor *)systemYellowColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemYellowColor];
    } else {
        return [UIColor colorWithHexString:@"#ffcc00ff"];
    }
}

+ (UIColor *)systemGrayColor {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemGrayColor];
    } else {
        return [UIColor colorWithHexString:@"#8e8e93ff"];
    }
}

+ (UIColor *)systemGray2Color {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemGray2Color];
    } else {
        return [UIColor colorWithHexString:@"#aeaeb2ff"];
    }
}

+ (UIColor *)systemGray3Color {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemGray3Color];
    } else {
        return [UIColor colorWithHexString:@"#c7c7ccff"];
    }
}

+ (UIColor *)systemGray4Color {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemGray4Color];
    } else {
        return [UIColor colorWithHexString:@"#d1d1d6ff"];
    }
}

+ (UIColor *)systemGray5Color {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemGray5Color];
    } else {
        return [UIColor colorWithHexString:@"#e5e5eaff"];
    }
}

+ (UIColor *)systemGray6Color {
    if (IOS_DARK_MODE_AVAILABLE) {
        return [UIColor systemGray6Color];
    } else {
        return [UIColor colorWithHexString:@"#f2f2f7ff"];
    }
}

@end

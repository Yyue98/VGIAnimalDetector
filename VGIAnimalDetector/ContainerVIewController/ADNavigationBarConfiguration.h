//
//  ADNavigationBarConfiguration.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADNavigationBarConfiguration : NSObject
/// Navigation bar id for locating
@property (nonatomic, copy) NSString    *navigationBarID;

/// Height for navigation bar
@property (nonatomic, assign)   double  heightForNavigationBar;

@end

NS_ASSUME_NONNULL_END

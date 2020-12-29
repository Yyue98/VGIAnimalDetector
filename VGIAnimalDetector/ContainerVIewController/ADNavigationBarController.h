//
//  ADNavigationBarController.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Container view controller navigationbar controller protocol
@protocol ADNavigationBarController <NSObject>
@required

/// View height for navigationbar controller
- (double)heightForNavigationBar;

@optional

/// Navigation bar id for locating in view stacks
- (NSString *)navigationBarID;

@end

NS_ASSUME_NONNULL_END

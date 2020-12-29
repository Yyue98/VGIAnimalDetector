//
//  ADUserLocationArrow.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ADUserLocationArrow <NSObject>

- (void)showHeadingIndicator:(BOOL)show;
- (void)setRotation:(CGAffineTransform)rotation;
- (void)setStyleColor:(UIColor *)color;
- (CGFloat)size;

@end

NS_ASSUME_NONNULL_END

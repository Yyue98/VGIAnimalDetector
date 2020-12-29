//
//  ADUserLocationView.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADUserLocationView : UIView
@property (nonatomic, strong)   UIColor *styleColor;
@property (nonatomic, assign)   BOOL    navigationMode;
@property (nonatomic, assign)   BOOL    showHeadingIndicator;
@property (nonatomic, assign)   CGAffineTransform   rotation;

- (instancetype)initWithSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END

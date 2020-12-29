//
//  ADSelectionCell.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/26.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADSelectionCell : QMUITableViewCell
@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UILabel *yesLabel;
@property (nonatomic, strong)   UILabel *noLabel;
@property (nonatomic, strong)  UISwitch *switchView;
@property (nonatomic, strong)   UIImageView *onView;
@property (nonatomic, strong)   UIImageView *offView;

@end

NS_ASSUME_NONNULL_END

//
//  ADInformationCell.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/24.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADInformationCell : QMUITableViewCell <UITextFieldDelegate>
@property (nonatomic, strong)   UITextField *textFiled;
@property (nonatomic, strong)   UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END

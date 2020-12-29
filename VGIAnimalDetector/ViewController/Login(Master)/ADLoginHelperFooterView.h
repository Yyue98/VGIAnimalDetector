//
//  ADLoginHelperFooterView.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADLoginHelperFooterView : UIView

@property (nonatomic, strong)   UIButton    *forgotButton;
@property (nonatomic, strong)   UIButton    *registerButton;
@property (nonatomic, strong)   QMUIFillButton  *submitButton;
@property (nonatomic, strong)   QMUIFillButton  *wechatButton;

@end

NS_ASSUME_NONNULL_END

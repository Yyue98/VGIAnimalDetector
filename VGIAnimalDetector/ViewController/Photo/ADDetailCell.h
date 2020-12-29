//
//  ADDetailCell.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/26.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADDetailCell : UITableViewCell <UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@property (nonatomic, strong)   UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END

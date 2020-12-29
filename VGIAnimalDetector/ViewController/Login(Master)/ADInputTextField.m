//
//  ADInputTextField.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADInputTextField.h"

@implementation ADInputTextField

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    [self sendActionsForControlEvents:UIControlEventValueChanged];
//    return YES;
//}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGFloat width = 88;
    CGFloat margin = 2;
    return CGRectMake(CGRectGetMaxX(self.bounds) - width - margin, margin, width, CGRectGetHeight(self.bounds) - margin * 2);
}

@end

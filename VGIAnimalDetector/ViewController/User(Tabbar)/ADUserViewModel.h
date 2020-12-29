//
//  ADUserViewModel.h
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>

#import <ReactiveObjC/ReactiveObjC.h>
#import "ADUserService.h"
//#import "SPAccount.h"
//#import "SPSecionPlaceholder.h"

@interface ADUserViewModel : NSObject

//@property (nonatomic, copy) SPAccount   *account;
@property (nonatomic, copy) NSString  *temp;
@property (nonatomic, copy) NSString    *title;
@property (nonatomic, strong)   RACCommand  *selectionCommand;
@property (nonatomic, strong)   id <ADUserService>  service;

- (instancetype)initWithService:(id <ADUserService>)service;

@end

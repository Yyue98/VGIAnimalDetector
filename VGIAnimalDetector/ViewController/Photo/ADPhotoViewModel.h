//
//  ADPhotoViewModel.h
//   VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ADPhotoService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADPhotoViewModel : NSObject

@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString  *temp;
@property (nonatomic, copy) NSData    *imageData;
@property (nonatomic, strong)   RACCommand  *commitCommand;
@property (nonatomic, strong)   RACCommand  *selectionCommand;

- (instancetype)initWithService:(id <ADPhotoService>)service;

@end

NS_ASSUME_NONNULL_END

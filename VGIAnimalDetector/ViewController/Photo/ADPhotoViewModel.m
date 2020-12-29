//
//  ADPhotoViewModel.m
//   VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADPhotoViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ACStatusHUD/ACStatusHUD.h>
#import <CYLTabBarController/CYLTabBarController.h>
#import <ChameleonFramework/Chameleon.h>
#import <YYKit/YYKit.h>
#import <LEEAlert/LEEAlert.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <Photos/Photos.h>
#import "ADContainerViewController.h"
#import "ADAppLauncher.h"
#import "ADColorCompatibility.h"

@interface ADPhotoViewModel () <UIImagePickerControllerDelegate>
@property (nonatomic, strong)   id <ADPhotoService>  service;
@end

@implementation ADPhotoViewModel

- (instancetype)initWithService:(id<ADPhotoService>)service {
    self = [super init];
    if (self) {
        _service = service;
        [self initialize];
    }
    
    return self;
}

- (void)dealloc {
}

- (void)initialize {
    _title = NSLocalizedString(@"添加照片", nil);
//    _commitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//        }];
//    }];
    
        _selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSIndexPath *input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                switch (input.section) {
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                    case 4: {
                        [LEEAlert actionsheet].config
                        .LeeAddAction(^(LEEAction * _Nonnull action) {
                            action.type = LEEActionTypeDefault;
                            action.title = @"拍照上传";
                            action.titleColor = [ADColorCompatibility systemBlueColor];
                            action.font = [UIFont systemFontOfSize:18];
                            action.clickBlock = ^{
                                [self showImagePicker];
                            };
                        })
                        .LeeAddAction(^(LEEAction * _Nonnull action) {
                            action.type = LEEActionTypeDefault;
                            action.title = @"从相册中选取";
                            action.titleColor = [ADColorCompatibility systemBlueColor];
                            action.font = [UIFont systemFontOfSize:18];
                            action.clickBlock = ^{
                                [self showAlbum];
                            };
                        })
                        .LeeAddAction(^(LEEAction * _Nonnull action) {
                            action.type = LEEActionTypeCancel;
                            action.title = @"取消";
                            action.titleColor = [ADColorCompatibility systemBlueColor];
                            action.font = [UIFont systemFontOfSize:18];
                        })
                        .LeeActionSheetCancelActionSpaceColor([ADColorCompatibility secondarySystemBackgroundColor]) // 设置取消按钮间隔的颜色
                        .LeeActionSheetBottomMargin(0.0) // 设置底部距离屏幕的边距为0
                        .LeeCornerRadii(CornerRadiiMake(0, 0, 0, 0))   // 指定整体圆角半径
                        .LeeActionSheetHeaderCornerRadii(CornerRadiiZero()) // 指定头部圆角半径
                        .LeeActionSheetCancelActionCornerRadii(CornerRadiiZero()) // 指定取消按钮圆角半径
                        .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
                            return CGRectGetWidth([[UIScreen mainScreen] bounds]);
                        })
                        .LeeActionSheetBackgroundColor([ADColorCompatibility systemBackgroundColor]) // 通过设置背景颜色来填充底部间隙
                        #ifdef __IPHONE_13_0
                        .LeeUserInterfaceStyle(UIUserInterfaceStyleLight)
                        #endif
                        .LeeShow();
                        
                        [subscriber sendCompleted];
                        return nil;
                    }
                    default: {
    
                    }
                        break;
                }
                
                [subscriber sendCompleted];
                return nil;
            }];
        }];
}

- (void)showAlbum {
    UIImagePickerController *viewController = [UIImagePickerController new];
    viewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    viewController.delegate = self;
    [viewController.rac_imageSelectedSignal subscribeNext:^(NSDictionary * _Nullable x) {
        [viewController dismissViewControllerAnimated:YES completion:^{
            [ACStatusHUD presentTitle:@"上传成功" message:nil iconStyle:ACStatusIconTypeDone];
            UIImage* image;
//            if (viewController.sourceType == UIImagePickerControllerSourceTypeCamera)
//              {
//            image = [x objectForKey:@"UIImagePickerControllerOriginalImage"];
//              }
            image = [x objectForKey: @"UIImagePickerControllerEditedImage"];
               // 把图片转成NSData类型的数据来保存文件(存入到沙盒中)
               NSData *imageData;
               // 判断图片是不是png格式的文件
               if (UIImagePNGRepresentation(image)) {
                   // 返回为png图像。
                   imageData = UIImagePNGRepresentation(image);

               }else {
                  // 返回为JPEG图像
                   imageData = UIImageJPEGRepresentation(image, 1.0);
               }
               // 路径拼接,写入-----
        //       NSString * imageSavePath = [[[HMTMySqliteDataHandle shareInstance]saveImagesPath] stringByAppendingPathComponent:@"自定义.自定义"];
        //
        //       [imageData writeToFile:imageSavePath atomically:YES];


            self.imageData = imageData;
        }];
    }];
    [self.service presentViewController:viewController animated:YES completion:nil];
}



- (void)showImagePicker {
    UIImagePickerController *viewController = [UIImagePickerController new];
    viewController.sourceType = UIImagePickerControllerSourceTypeCamera;
    viewController.delegate = self;
    [viewController.rac_imageSelectedSignal subscribeNext:^(NSDictionary * _Nullable x) {
        [viewController dismissViewControllerAnimated:YES completion:^{
            
            [ACStatusHUD presentTitle:@"上传成功" message:nil iconStyle:ACStatusIconTypeDone];
            UIImage* image;
//            if (viewController.sourceType == UIImagePickerControllerSourceTypeCamera)
//              {
            image = [x objectForKey:@"UIImagePickerControllerOriginalImage"];
//              }
//            imaxge = [x objectForKey: @"UIImagePickerControllerEditedImage"];
               // 把图片转成NSData类型的数据来保存文件(存入到沙盒中)
               NSData *imageData;
               // 判断图片是不是png格式的文件
               if (UIImagePNGRepresentation(image)) {
                   // 返回为png图像。
                   imageData = UIImagePNGRepresentation(image);

               }else {
                  // 返回为JPEG图像
                   imageData = UIImageJPEGRepresentation(image, 1.0);
               }
               // 路径拼接,写入-----
        //       NSString * imageSavePath = [[[HMTMySqliteDataHandle shareInstance]saveImagesPath] stringByAppendingPathComponent:@"自定义.自定义"];
        //
        //       [imageData writeToFile:imageSavePath atomically:YES];


            self.imageData = imageData;
        }];
    }];
    [self.service presentViewController:viewController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [ACStatusHUD presentTitle:@"上传成功" message:nil iconStyle:ACStatusIconTypeDone];
    UIImage* image;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
      {
          image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
      }
    image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
       // 把图片转成NSData类型的数据来保存文件(存入到沙盒中)
       NSData *imageData;
       // 判断图片是不是png格式的文件
       if (UIImagePNGRepresentation(image)) {
           // 返回为png图像。
           imageData = UIImagePNGRepresentation(image);

       }else {
          // 返回为JPEG图像
           imageData = UIImageJPEGRepresentation(image, 1.0);
       }
       // 路径拼接,写入-----
//       NSString * imageSavePath = [[[HMTMySqliteDataHandle shareInstance]saveImagesPath] stringByAppendingPathComponent:@"自定义.自定义"];
//
//       [imageData writeToFile:imageSavePath atomically:YES];


    self.imageData = imageData;
}

@end

//
//  ADInformationTableViewHelper.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/26.
//

#import "ADInformationTableViewHelper.h"
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <ChameleonFramework/Chameleon.h>
#import <ACStatusHUD/ACStatusHUD.h>
#import "ADColorCompatibility.h"
#import "ADInformationCell.h"
#import "ADSelectionCell.h"
#import "ADAddPhotoCell.h"
#import "ADDetailCell.h"
#import "ADAPIManager.h"
#import "ADUnitFormatter.h"
#import "ADPositioningManager.h"

@interface ADInformationTableViewHelper () <UITableViewDataSource, UITableViewDelegate, ADPositioningManagerDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong)   ADPhotoViewModel *viewModel;
@property (nonatomic, copy) NSString    *catID;
@property (nonatomic, copy) NSString    *catName;
@property (nonatomic, copy) NSString    *location;
@property (nonatomic, assign)   BOOL    healthyStatus;  //是否健康
@property (nonatomic, assign) BOOL    needHelp;         //是否需要帮助
@property (nonatomic, assign)   CLLocationCoordinate2D  coordinate; //位置（经度，纬度）
@property (nonatomic, copy)   NSString  *timestamp; //记录的时间
@property (nonatomic, copy) NSString    *remark;       //其他补充
@property (nonatomic, copy) NSData    *imageData;
@property (nonatomic, weak) RACCommand  *selectionCommand;

@end

@implementation ADInformationTableViewHelper

- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)selectionCommand ViewModel:(ADPhotoViewModel *)viewModel {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _viewModel = viewModel;
        
        _selectionCommand = selectionCommand;
        [[ADPositioningManager sharedManager] addNotifyObserver:self];
        
    }
    RACSignal *enableSignal = [RACObserve(self, catName) map:^id _Nullable(id  _Nullable value) {
        return @([value length]);
    }];
    
    _submitCommand = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSDictionary *record = @{@"cat_name" : self.catName,
                                        @"isHealthy" : [self healthyStatusWithBool:self.healthyStatus],
                                        @"needHelp" : [self needHelpWithBool:self.needHelp],
                                        @"time"     : [self nowTime],
                                        @"longitude": [NSString stringWithFormat:@"%f", self.coordinate.longitude],
                                        @"latitude"  : [NSString stringWithFormat:@"%f", self.coordinate.latitude],
                                        @"location"  : self.location,
//                                         @"photo"  : self.imageData,
                                        @"remark"   : self.remark
                    };
            @weakify(self);
//            ACStatusView *hud = [ACStatusHUD presentLoadingWithTitle:nil message:nil];
            [[[ADAPIManager sharedManager] addRecordWithCatRecord:record] subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                
                [ACStatusHUD presentTitle:@"提交成功" message:nil iconStyle:ACStatusIconTypeDone];

                [subscriber sendNext:x];
                [subscriber sendCompleted];
                
                } error:^(NSError * _Nullable error) {
                    [subscriber sendCompleted];
                }];
            
            return nil;
        }];
    }];

    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? 2 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return 88;
        case 1: return 44;
        case 2: return 88;
        case 3: return 88;
        default: return 200;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return [self cellForNameAtIndexPath:indexPath];
        case 1: return [self cellForCatStatusAtIndexPath:indexPath];
        case 2: return [self cellForDescriptionAtIndexPath:indexPath];
        case 3: return [self cellForAddCatPhotoAtIndexPath:indexPath];
        default: return [self cellForDetailAtIndexPath:indexPath];
    }
}


- (UITableViewCell *)cellForCatStatusAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: return [self cellForCatHealthyAtIndexPath:indexPath];
        default:return [self cellForCatNeedHelpAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)cellForNameAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"name";
    ADInformationCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        

        RAC(self, catName) = [[RACSignal concat:@[cell.textFiled.rac_textSignal, RACObserve(cell.textFiled, text)]] takeUntil:cell.rac_prepareForReuseSignal];
        cell.titleLabel.text = @"猫咪名称";
        cell.textFiled.placeholder = @"例：小花狸 （可为空）";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (UITableViewCell *)cellForDescriptionAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Description";
    ADInformationCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
       
        FAKIcon *icon = [FAKMaterialIcons carIconWithSize:24];
        [icon addAttribute:NSForegroundColorAttributeName value:[ADColorCompatibility systemBlueColor]];
        RAC(self, location) = [[RACSignal concat:@[cell.textFiled.rac_textSignal, RACObserve(cell.textFiled, text)]] takeUntil:cell.rac_prepareForReuseSignal];        cell.titleLabel.text = @"拍摄地点";
        cell.textFiled.placeholder = @"例：食堂一楼阶梯";
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    
    return cell;
}
- (UITableViewCell *)cellForDetailAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Detail";
    ADDetailCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
       
        FAKIcon *icon = [FAKMaterialIcons carIconWithSize:24];
        [icon addAttribute:NSForegroundColorAttributeName value:[ADColorCompatibility systemBlueColor]];
        cell.titleLabel.text = @"备注";
        RAC(self, remark) = [[RACSignal concat:@[cell.textView.rac_textSignal, RACObserve(cell.textView, text)]] takeUntil:cell.rac_prepareForReuseSignal];
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    
    return cell;
}

- (UITableViewCell *)cellForCatHealthyAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Healthy";
    ADSelectionCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADSelectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.titleLabel.text = @"健康状态";
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.yesLabel.text = @"健康";
        cell.noLabel.text = @"不健康";
        RAC(self, healthyStatus) = [[RACSignal concat:@[cell.switchView.rac_newOnChannel, RACObserve(cell.textLabel, text)]] takeUntil:cell.rac_prepareForReuseSignal];
        UIImage *image = [UIImage imageNamed:@"猫爪"];
        cell.onView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(36, 36)];
        
        UIImage *image2 = [UIImage imageNamed:@"猫零食"];
        cell.offView.image = [UIImage imageWithImage:image2 scaledToSize:CGSizeMake(36, 36)];
    }

    return cell;
}

- (UITableViewCell *)cellForCatNeedHelpAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Help";
    ADSelectionCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADSelectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.titleLabel.text = @"是否需要帮助";
        cell.accessoryType = UITableViewCellAccessoryNone;

        RAC(self, needHelp) = [[RACSignal concat:@[cell.switchView.rac_newOnChannel, RACObserve(cell.textLabel, text)]] takeUntil:cell.rac_prepareForReuseSignal];
        UIImage *image = [UIImage imageNamed:@"猫爪"];
        cell.onView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(36, 36)];
        
        UIImage *image2 = [UIImage imageNamed:@"猫零食"];
        cell.offView.image = [UIImage imageWithImage:image2 scaledToSize:CGSizeMake(36, 36)];
    }

    return cell;
}

- (UITableViewCell *)cellForAddCatPhotoAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Photo";
    ADAddPhotoCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADAddPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.titleLabel.text = @"添加照片";
        cell.accessoryType = UITableViewCellAccessoryNone;
        RAC(self, imageData) =  RACObserve(self.viewModel, imageData);
    }

    return cell;
}

//- (UITableViewCell *)cellForCommitAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellID = @"Commit";
//    ADCommitCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[ADCommitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//
//    return cell;
//}
- (NSString *)healthyStatusWithBool:(BOOL)status {
    return _healthyStatus ? @"1" : @"0" ;
}

- (NSString *)needHelpWithBool:(BOOL)status {
    return _needHelp ? @"1" : @"0" ;
}

- (NSString *)nowTime{
    NSDate *now = [NSDate date];
    
    return [[ADUnitFormatter sharedFormatter] stringFromDate:now] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_selectionCommand execute:indexPath];
}

#pragma mark - ADPositioningManagerDelegate
- (void)positioningManager:(ADPositioningManager *)manager didUpdateLocation:(ADLocation *)location {
    _coordinate = location.coordinate;
    
}
@end

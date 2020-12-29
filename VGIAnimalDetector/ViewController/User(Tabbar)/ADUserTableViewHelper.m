//
//  ADUserTableHelper.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/6.
//

#import "ADUserTableViewHelper.h"
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <ChameleonFramework/Chameleon.h>
#import "ADUserAccountCell.h"
#import "ADColorCompatibility.h"
#import "ADListItemCell.h"
#import "ADCatImplement.h"
#import "ADCatViewModel.h"
#import "ADCatViewController.h"
#import "ADRecordImplement.h"
#import "ADRecordViewModel.h"
#import "ADRecordViewController.h"
#import "ADAPIManager.h"


@interface ADUserTableViewHelper () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong)   id <ADUserService>  service;
@property (nonatomic, weak) RACCommand  *selectionCommand;
@end

@implementation ADUserTableViewHelper

- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)selectionCommand service:(id<ADUserService>)service {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _service = service;

//        [source subscribeNext:^(id  _Nullable x) {
//            self.account = x;
//            [self.tableView reloadData];
//        }];
        
        _selectionCommand = selectionCommand;
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? 3 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 88 : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return [self cellForUserAccountAtIndexPath:indexPath];
        default:return [self cellForUserFunctionAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)cellForUserAccountAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Title";
    ADUserAccountCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADUserAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.titleLabel.text = @"梅花行踪 猫咪图鉴";
    UIImage *image = [UIImage imageNamed:@"猫徽章"];
    cell.avatarView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(66, 66)];
    return cell;
}

- (UITableViewCell *)cellForUserFunctionAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: return [self cellForBillAtIndexPath:indexPath];
        case 1: return [self cellForLicenseAtIndexPath:indexPath];
//        case 2: return [self cellForCat3AtIndexPath:indexPath];
//        case 3: return [self cellForCat4AtIndexPath:indexPath];
        default:return [self cellForCat5AtIndexPath:indexPath];
    }
}

- (UITableViewCell *)cellForBillAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cat1";
    ADListItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImage *image = [UIImage imageNamed:@"三花猫"];
        cell.iconView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(36, 36)];
        cell.titleLabel.text = @"小花狸🐈";
    }
    
    return cell;
}

- (UITableViewCell *)cellForLicenseAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cat2";
    ADListItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
        UIImage *image = [UIImage imageNamed:@"灰蓝猫"];
        cell.iconView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(36, 36)];
        cell.titleLabel.text = @"鼻鼻🐈";
    }
    
    return cell;
}

//- (UITableViewCell *)cellForCat3AtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellID = @"Cat3";
//    ADListItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[ADListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//        UIImage *image = [UIImage imageNamed:@"暹罗猫"];
//        cell.iconView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(24, 24)];
//        cell.titleLabel.text = @"起司";
//    }
//
//    return cell;
//}
//
//- (UITableViewCell *)cellForCat4AtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellID = @"Cat4";
//    ADListItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[ADListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//        UIImage *image = [UIImage imageNamed:@"三花猫"];
//        cell.iconView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(24, 24)];
//        cell.titleLabel.text = @"白橘";
//    }
//
//    return cell;
//}

- (UITableViewCell *)cellForCat5AtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cat5";
    ADListItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
        UIImage *image = [UIImage imageNamed:@"暹罗猫"];
        cell.iconView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(66, 66)];
        cell.titleLabel.text = @"图图妈妈🐈";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_selectionCommand execute:indexPath];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    editingStyle = UITableViewCellEditingStyleDelete;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *moreDetailRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"详细信息" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
        ADCatImplement *service = [ADCatImplement new];
        ADCatViewModel *viewModel = [[ADCatViewModel alloc] initWithService:service];
        [self.service pushViewModel:viewModel];
    }];
    
UITableViewRowAction *recordRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"查看足迹" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
    
    
    ADRecordImplement *service = [ADRecordImplement new];
    ADRecordViewModel *viewModel = [[ADRecordViewModel alloc] initWithService:service];
    [self.service pushViewModel:viewModel];
}];
    
    recordRowAction.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];//可以定义RowAction的颜色
    return @[moreDetailRoWAction, recordRowAction];//最后返回这俩个RowAction 的数组
}

@end

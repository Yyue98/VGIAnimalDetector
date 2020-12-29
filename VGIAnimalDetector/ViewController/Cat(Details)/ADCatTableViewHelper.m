//
//  ADCatTableViewHelper.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import "ADCatTableViewHelper.h"
#import "ADCatItemCell.h"
#import "ADCatDetailCell.h"
#import "ADCatImageCell.h"

@interface ADCatTableViewHelper() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) RACCommand  *selectionCommand;

@end

@implementation ADCatTableViewHelper

- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)selectionCommand {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        
        _selectionCommand = selectionCommand;
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? 1 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return 440;
        case 1: return 45;
        case 2: return 45;
        case 3: return 45;
        case 4: return 45;
        case 5: return 45;
        default: return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return [self cellForImageAtIndexPath:indexPath];
        case 1: return [self cellForNameAtIndexPath:indexPath];
        case 2: return [self cellForAddCatGenderAtIndexPath:indexPath];
        case 3: return [self cellForDescriptionAtIndexPath:indexPath];
        case 4: return [self cellForCatApperanceAtIndexPath:indexPath];
        case 5: return [self cellForTemperamentAtIndexPath:indexPath];
        default: return [self cellForDetailAtIndexPath:indexPath];
    }
}


- (UITableViewCell *)cellForImageAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"image";
    ADCatImageCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADCatImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (UITableViewCell *)cellForNameAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"name";
    ADCatItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADCatItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        

        cell.titleLabel.text = @"猫咪名称";
        cell.contentLabel.titleLabel.text = @"小彩狸";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (UITableViewCell *)cellForDescriptionAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Description";
    ADCatItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADCatItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
       

//        cell.iconView.image = [icon imageWithSize:CGSizeMake(24, 24)];
        cell.titleLabel.text = @"活动地点";
        cell.contentLabel.titleLabel.text = @"地科院";
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    
    return cell;
}
- (UITableViewCell *)cellForDetailAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Detail";
    ADCatDetailCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADCatDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
       

        cell.titleLabel.text = @"备注";
        cell.contentLabel.titleLabel.text = @"已绝育";

        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    
    return cell;
}

- (UITableViewCell *)cellForCatHealthyAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Healthy";
    ADCatItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADCatItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.titleLabel.text = @"健康状态";
        cell.contentLabel.titleLabel.text = @"健康";

        cell.accessoryType = UITableViewCellAccessoryNone;

    }

    return cell;
}

- (UITableViewCell *)cellForCatApperanceAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Apperance";
    ADCatItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADCatItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.titleLabel.text = @"外貌特征";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.contentLabel.titleLabel.text = @"狸花，脖子底下有一撮白毛";

    }

    return cell;
}

- (UITableViewCell *)cellForAddCatGenderAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Gender";
    ADCatItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADCatItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.titleLabel.text = @"性别";
        cell.contentLabel.titleLabel.text = @"母";
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }

    return cell;
}

- (UITableViewCell *)cellForTemperamentAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Temperament";
    ADCatItemCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADCatItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.titleLabel.text = @"性格";
        cell.contentLabel.titleLabel.text = @"比较亲近人";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_selectionCommand execute:indexPath];
}
@end

//
//  ADRecordTableViewHelper.m
//  VGIAnimalDetector
//
//  Created by NNU-SCENS-YY on 2020/12/27.
//

#import "ADRecordTableViewHelper.h"
#import "ADRecordSummaryCell.h"
#import "ADCatRecord.h"
#import "ADUnitFormatter.h"
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <YYKit/NSObject+YYModel.h>
#import <ChameleonFramework/Chameleon.h>
#import "ADAPIManager.h"

@interface ADRecordTableViewHelper () <UITableViewDataSource, UITableViewDelegate , ADRecordViewModelDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) RACCommand  *selectionCommand;
@property (nonatomic, copy) NSArray <ADCatRecord *>   *records;
@property (nonatomic, strong)   ADRecordViewModel *viewModel;

@end

@implementation ADRecordTableViewHelper

- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)selection viewModel:(ADRecordViewModel *)viewModel {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _viewModel = viewModel;
        _viewModel.delegate = self;
//        _records = @{}.mutableCopy;
        
//        [source subscribeNext:^(id  _Nullable x) {
//            self.records = x;
//            [self.tableView reloadData];
//        }];
        
        
        _selectionCommand = selection;
    }
    
    return self;
}

#pragma mark - UITableView datasource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.records count];
//    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    ADRecordSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ADRecordSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        UIImage *image = [UIImage imageNamed:@"cat-footprint2"];
        cell.iconView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(36, 36)];
    }
    
    ADCatRecord *record = self.records[indexPath.row];
    cell.titleLabel.text = record.catName;
    cell.timeLabel.text = record.timestamp;
//    cell.timeLabel.text = [[ADUnitFormatter sharedFormatter] stringFromDate:record.timestamp];
    cell.statusLabel.text = [self catStatusWithRecord:record];
    cell.positionLabel.text = record.location;
    cell.locationLabel.text = [NSString stringWithFormat:@"经度：%f 纬度：%f",record.coordinate.longitude,record.coordinate.latitude];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_selectionCommand execute:indexPath];
}
- (NSString *)catStatusWithRecord:(ADCatRecord *)record {
    if (!record.healthyStatus ) {
        return @"猫咪状态不佳";
    }
    if (record.needHelp ) {
        return @"猫咪需要帮助";
    }
    return @"猫咪状态正常";
}
//- (NSString *)paymentDisplayForTransaction:(SPTransaction *)transaction {
//    switch (transaction.statusCode) {
//        case 0:     return @"--";
//        case 500:   return @"--";
//        case 1000:  return @"--";
//        case 2000:  return transaction.prepayFee;
//        case 3000:  return transaction.prepayFee;
//        case 4000:  return transaction.prepayFee;
//        case 4250:  return transaction.prepayFee;
//        case 4500:  return transaction.prepayFee;
//        case 5000:  return transaction.settlementTotalFee;
//        case 6000:  return transaction.settlementTotalFee;
//        case 7000:  return transaction.settlementTotalFee;
//        case 10000:
//        default:    return @"--";
//    }
//}

#pragma mark - ADRecordViewModeldelegate
- (void)recordModelDidRefresh:(ADRecordViewModel *)viewModel withRecords:(NSDictionary *)dic {
    NSMutableArray *mutable = @[].mutableCopy;
    for (NSDictionary *json in dic) {
//        ADCatRecord *record = [ADCatRecord modelWithJSON:json];
//        CLLocationDegrees latitude = [json[@"latitude"] doubleValue];
//        CLLocationDegrees longitude = [json[@"longitude"] doubleValue];
//        BOOL healthy = YES;
//        BOOL help = NO;
//
//        if (!json[@"location"]) {
//            healthy = NO;
//        }
//        if (json[@"help"]) {
//            healthy = YES;
//        }
        
        ADCatRecord *record = [ADCatRecord modelWithJSON:json];
        [mutable addObject:record];
    }
    _records = mutable;
    [self.tableView reloadData];

}
@end

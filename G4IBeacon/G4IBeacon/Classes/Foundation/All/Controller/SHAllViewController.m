//
//  SHAllViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAllViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "SHAllTableViewCell.h"

@interface SHAllViewController () <CLLocationManagerDelegate>

/// 定位
@property (nonatomic, strong) CLLocationManager *locationManager;

/// 设备区域
@property (nonatomic, strong) CLBeaconRegion *region;

/// 扫描到的所有设备
@property (nonatomic, strong) NSArray *beacons;

@end

@implementation SHAllViewController

// MARK: - UI

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"All Device On Line";
    
    // 准备表格
    [self initTableView];
}

/// 准备表格
- (void)initTableView {
    
    self.tableView.rowHeight = [SHAllTableViewCell cellRowHeight];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHAllTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SHAllTableViewCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - 数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.beacons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SHAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SHAllTableViewCell class]) forIndexPath:indexPath];
    
    cell.beacon = self.beacons[indexPath.row];
    
    return cell;
}


// MARK: - getter && setter

/// region
- (CLBeaconRegion *)region {
    
    if (!_region) {
        
        _region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:UUIDStirng] identifier:REGION_IDENTIFIER];
        
        _region.notifyEntryStateOnDisplay = YES;
        _region.notifyOnExit = YES;
        _region.notifyOnEntry = YES;
    }
    return _region;
}

/// locationManager
- (CLLocationManager *)locationManager {
    
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            _locationManager.allowsBackgroundLocationUpdates = YES;
        }
        
    }
    return _locationManager;
}

@end

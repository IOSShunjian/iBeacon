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

- (void)dealloc {
    
    // 停止扫描
    [self.locationManager stopMonitoringForRegion:self.region];
    [self.locationManager stopRangingBeaconsInRegion:self.region];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"All Device On Line";
    
    // 准备表格
    [self initTableView];
    
    // 开始定位扫描
    [self startScanDevice];
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

// MARK: - 定位与扫描

/// 获得详细数据的回调
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    
    if (!beacons.count) {
        self.beacons = nil;
        return;
    }

    //如果存在不是我们要监测的iBeacon那就停止扫描
    if (![[region.proximityUUID UUIDString] isEqualToString:UUIDStirng]) {
        [self.locationManager stopMonitoringForRegion:region];
        [self.locationManager stopRangingBeaconsInRegion:region];
    }
    
//    for (CLBeacon *beacon in beacons) {
//        NSLog(@"%@", beacon);
//    }
    
    // 设置最新信息
    self.beacons = beacons;
    [self.tableView reloadData];
}

/// 获得状态
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    
    if (state == CLRegionStateInside) {
        NSLog(@"进入区域");
        
        // 获得详细信息
        [self.locationManager startRangingBeaconsInRegion:self.region];
        
    } else if (state == CLRegionStateOutside) {
         NSLog(@"离开区域");
    }
}

/// 获得距离失败
- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    
    if (error) {
        [SVProgressHUD showWithStatus:@"open the phone Bluetooth"];
    }
}

/// 打开监听失败
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    
    if (error) {
        [SVProgressHUD showWithStatus:@"open the phone Bluetooth"];
    }
}

/// 用户授权的变化
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways: {
            
            // 授权才开始开启监测
            [self.locationManager startMonitoringForRegion:self.region];
            [self.locationManager requestStateForRegion:self.region];
        }
            
            break;
            
        default:
            break;
    }
}

/// 开始定位扫描
- (void)startScanDevice {
    
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }
    
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        return;
    }
    
    // 申请手动授权
    [self.locationManager requestAlwaysAuthorization];
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
//
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
//            _locationManager.allowsBackgroundLocationUpdates = YES;
//        }
        
    }
    return _locationManager;
}

@end

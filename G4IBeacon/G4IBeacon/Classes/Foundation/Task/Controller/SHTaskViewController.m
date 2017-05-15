//
//  SHTaskViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHTaskViewController.h"
#import "SHTaskCollectionViewCell.h"
#import "SHSenceViewController.h"
#import "SHAddViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface SHTaskViewController () <UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate>

/// 显示所有场景的视图
@property (nonatomic, strong) UICollectionView* listView;

/// 所有的iBeaon
@property (strong, nonatomic)NSMutableArray *alliBeacons;

/// 所有的区域
@property (strong, nonatomic) NSMutableArray *allBeaconRegions;

/// 定位管理器
@property (nonatomic, strong) CLLocationManager *locationManager;

/// 是否进入区域
@property (assign, nonatomic) BOOL isEnterArea;

/// 是否离开区域
@property (assign, nonatomic) BOOL isExiteArea;

@end

@implementation SHTaskViewController

// MARK: - 任务

/// 执行任务
- (void)executeTask:(CLBeacon *)beacon {

    // 先找到对应的模型
    SHIBeacon *iBeacon = [self searchSuitTask:beacon];
    
    // 要先过滤 0
    if ((ABS(beacon.rssi) > iBeacon.rssiValue + iBeacon.rssiBufValue) || (!beacon.rssi)) {
        
        // 已经离开了这个区域的回调
        if (self.isExiteArea) {
            SHLog(@"你已经离开了");
            return;
        }
        
        // 首次离开重新进入这个区域
        self.isExiteArea = !self.isExiteArea;
        self.isEnterArea = !self.isExiteArea;
        SHLog(@"执行【离开】区域的任务 - %d", ABS(beacon.rssi));
        
        [self executeExitAreaTask:iBeacon];
        
    } else if (ABS(beacon.rssi) <= iBeacon.rssiValue - iBeacon.rssiBufValue) {
        
        // 已经进入了区域后的回调
        if (self.isEnterArea) {
            SHLog(@"已经进来了");
            return;
        }
        
        // 首次进入修改状态
        self.isEnterArea = !self.isEnterArea;
        self.isExiteArea = !self.isEnterArea;
        
        SHLog(@"执行【来到】区域的任务 - %d", ABS(beacon.rssi));
        [self executeEnterAreaTask:iBeacon];
        
    } else {
        
        SHLog(@"中间状态_啥也不干: %d", ABS(beacon.rssi));
    }

}

/// 执行进入区域的任务
- (void)executeEnterAreaTask:(SHIBeacon *)iBeacon {
    
    // 取出任务
    for (SHButton *button in iBeacon.enterAreaTasks) {
        
        switch (button.buttonKind) {
            case ButtonKindLight:
                [SHSendDeviceData setDimmer:button];
                break;
                
            default:
                break;
        }
    }
}

/// 执行离开区域的任务
- (void)executeExitAreaTask:(SHIBeacon *)iBeacon {
    
    for (SHButton *button in iBeacon.exitAreaTasks) {
        
        SHLog(@"总在执行");
        
        switch (button.buttonKind) {
            case ButtonKindLight:
                [SHSendDeviceData setDimmer:button];
                break;
                
            default:
                break;
        }
        
    }
}

/// 找到与iBeacon匹配的模型
- (SHIBeacon* )searchSuitTask:(CLBeacon *)beacon {
    
    for (SHIBeacon *iBeacon in self.alliBeacons) {
        
        if (([iBeacon.uuidString isEqualToString:beacon.proximityUUID.UUIDString]) && (beacon.major.integerValue == iBeacon.majorValue) && (beacon.minor.integerValue == iBeacon.minorValue)) {
            return iBeacon;
        }
    }
    return nil;
}

// MARK: - 定位

/// 获得详细数据的回调
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    
    if (!beacons.count) {
        
        return;
    }
    
    //如果存在不是我们要监测的iBeacon那就停止扫描
    if (![[region.proximityUUID UUIDString] isEqualToString:UUIDStirng]) {
        [self.locationManager stopMonitoringForRegion:region];
        [self.locationManager stopRangingBeaconsInRegion:region];
    }
    
    for (CLBeacon *beacon in beacons) {
        // 执行任务
        [self executeTask:beacon];
    }
}

/// 获得状态
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    
    if (![region isKindOfClass:[CLBeaconRegion class]]) {
        return;
    }
    
    if (state == CLRegionStateInside) {
        SHLog(@"进入区域");
  
        // 获得详细信息
        for (CLBeaconRegion *region in self.allBeaconRegions) {

            [self.locationManager startRangingBeaconsInRegion:region];
        }
        
    } else if (state == CLRegionStateOutside) {
        SHLog(@"离开区域");
        
        // 停止获得详细信息
        for (CLBeaconRegion *region in self.allBeaconRegions) {
            
            [self.locationManager stopRangingBeaconsInRegion:region];
        }
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

// MARK: - UI

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Tasks";
    
    self.view.backgroundColor = SHGlobalBackgroundColor;
    
    // 设置导航栏
    [self setUpNavigationBar];
    
    [self.view addSubview:self.listView];
    
    [self startScanDevice];
}

// MARK: - 本地通知

//注意： 相同的UUID只会触发一次

/// 发送进入区域的通知
- (void)sendEnterNotification {
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"welcome";
    notification.soundName = @"Default";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

///发送离开区域的通知
- (void)sendExitNotification {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Exit Region";
    notification.soundName = @"Default";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

/// 进入区域
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        
        [self sendEnterNotification];
    }
}

// 离开区域
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        
        [self sendExitNotification];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // 显示出所有的列表
    self.alliBeacons = [[SHSQLiteManager shareSHSQLiteManager] searchiBeacons];
    
    for (SHIBeacon *iBeacon in self.alliBeacons) {
        
        // 建立相应的区域模型
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:iBeacon.uuidString] major:iBeacon.majorValue minor:iBeacon.minorValue identifier:@"iBeacon"];
        region.notifyOnEntry = YES;
        region.notifyOnExit = YES;
        region.notifyEntryStateOnDisplay = YES;
        
        // 将每个iBeacon的区域任务取出
        iBeacon.exitAreaTasks = [[SHSQLiteManager shareSHSQLiteManager] getButtonsFor:iBeacon isEnter:NO];
        iBeacon.enterAreaTasks = [[SHSQLiteManager shareSHSQLiteManager] getButtonsFor:iBeacon isEnter:YES];
        
        [self.allBeaconRegions addObject:region];
    }
    
    [self.listView reloadData];
    
    // 开始通信
    for (CLBeaconRegion *region in self.allBeaconRegions) {
        
        [self.locationManager startMonitoringForRegion:region];
        [self.locationManager requestStateForRegion:region];
    }
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    self.listView.frame = self.view.bounds;
}

/// 设置导航栏
- (void)setUpNavigationBar {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewiBeacon)];
}

- (void)addNewiBeacon {
    
    SHAddViewController *addViewController = [[SHAddViewController alloc] init];
    
    addViewController.iBeacon = [[SHIBeacon alloc] init];
    addViewController.iBeacon.iBeaconID = [[SHSQLiteManager shareSHSQLiteManager] getMaxiBeaconID] + 1;
    
    [self.navigationController pushViewController:addViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - 代理

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SHSenceViewController *senceViewController =
    [[UIStoryboard storyboardWithName:NSStringFromClass([SHSenceViewController class ]) bundle:nil] instantiateInitialViewController];
    
    // 传入模型
    senceViewController.iBeacon = self.alliBeacons[indexPath.row];
    
    [self.navigationController pushViewController:senceViewController animated:YES];
}

// MARK: - 数据源

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.alliBeacons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SHTaskCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SHTaskCollectionViewCell class]) forIndexPath:indexPath];
    
    // 获得区域模型
    cell.iBeacon = self.alliBeacons[indexPath.item];
    
    return cell;
}

// MARK: gettr && setter

/// locationManager
- (CLLocationManager *)locationManager {
    
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
    
    }
    return _locationManager;
}

/// 展示场景
- (UICollectionView *)listView {
    
    if (!_listView) {
        
        // 1.自定义流水布局
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        // 1.1 设置方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        // 1.2 计算每个item的大小
        CGFloat itemMarign = 1;
        
        // 总列数
        NSUInteger totalCols = 3;
        
        CGFloat itemWidth = (self.view.frame_width - (totalCols * itemMarign)) / totalCols;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        
        // 1.3 设置间距
        flowLayout.minimumLineSpacing = itemMarign;
        flowLayout.minimumInteritemSpacing = itemMarign;
        
        // 2.创建 (临时指定一个高度，宽度不需要指定)
        _listView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout] ;
        
        // 设置背景颜色
        _listView.backgroundColor = self.view.backgroundColor;
        
        // 注册cell
        [_listView registerNib:[UINib nibWithNibName:NSStringFromClass([SHTaskCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SHTaskCollectionViewCell class])];
        
        // 设置数据源和方法
        _listView.dataSource = self;
        _listView.delegate = self;
    }
    
    return _listView;
}

- (NSMutableArray *)allBeaconRegions {
    if (!_allBeaconRegions) {
        _allBeaconRegions = [NSMutableArray array];
    }
    return _allBeaconRegions;
}

@end

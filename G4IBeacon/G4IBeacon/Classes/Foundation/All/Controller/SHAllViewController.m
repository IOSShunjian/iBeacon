//
//  SHAllViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAllViewController.h"

// 导入框架
#import <CoreBluetooth/CoreBluetooth.h>


@interface SHAllViewController () <CBCentralManagerDelegate, CBPeripheralDelegate>

/**
 中央管理器
 */
@property (strong, nonatomic) CBCentralManager *manager;

/**
 外设的存储数组
 */
@property (strong, nonatomic) NSMutableArray *peripheralArray;

@end

@implementation SHAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.建立中央管理者 nil - 主队列
    // 提示蓝牙开关未打开时会弹出警告框
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{CBCentralManagerOptionShowPowerAlertKey:@YES}];
    
    // 2.扫描 外边设备 Services:UUID， nil - 扫描全部服务
    [self.manager scanForPeripheralsWithServices:nil options:nil];
}

// MARK: - CBCentralManager的代理

/**
 代理回调  -- 将要开始第四步 -- 4.1
 
 @param central 管理器
 @param peripheral 外设
 @param advertisementData 数据
 @param RSSI 信号强度
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
   
    
     if (advertisementData[CBAdvertisementDataLocalNameKey] == nil || advertisementData[CBAdvertisementDataServiceUUIDsKey] == nil) return;
    
     SHLog(@"发现外围设备...%@, %@", advertisementData, RSSI);
    
    // 如果存在不添加
    if (![self.peripheralArray containsObject:peripheral]) {
        
        //停扫
//        [self.manager stopScan];
        
        [self.peripheralArray addObject:peripheral];
        
        // 刷新表格
        [self.tableView reloadData];
    }
    
    
}

/**
 这个代理必须实现 3.开始扫描
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (central.state) {
        case CBManagerStatePoweredOn: {

            // 3.扫描外设
            [central scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
            
        }
            break;
            
        default:
            NSLog(@"此设备不支持BLE或未打开蓝牙功能，无法作为外围设备.");
            break;
    }
}

// MARK: - 代理

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.manager stopScan];
    
    SHLog(@"停止扫描");
}

// MARK: - 数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.peripheralArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    
    CBPeripheral *peripheral = self.peripheralArray[indexPath.row];
    
    cell.textLabel.text = peripheral.name;
    
    return cell;
}

#pragma mark - getter && setter

- (NSMutableArray *)peripheralArray {
    if (!_peripheralArray) {
        _peripheralArray = [NSMutableArray array];
    }
    return _peripheralArray;
}

@end

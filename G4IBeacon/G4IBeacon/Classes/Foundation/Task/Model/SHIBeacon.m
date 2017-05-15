//
//  SHIBeacon.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHIBeacon.h"

@implementation SHIBeacon

/// 字典转换为模型
+ (instancetype)iBeaconWithDictionary:(NSDictionary *)dictionary {
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dictionary];
    
    return obj;
}

// MARK: - getter

- (NSMutableArray *)allDeviceButtonInCurrentZone {
    
    if (!_allDeviceButtonInCurrentZone) {
        _allDeviceButtonInCurrentZone = [NSMutableArray array];
    }
    return _allDeviceButtonInCurrentZone;
}

- (NSMutableArray *)enterAreaTasks {
    
    if (!_enterAreaTasks) {
        _enterAreaTasks = [NSMutableArray array];
    }
    return _enterAreaTasks;
}

- (NSMutableArray *)exitAreaTasks {
    
    if (!_exitAreaTasks) {
        _exitAreaTasks = [NSMutableArray array];
    }
    return _exitAreaTasks;
}

@end

//
//  SHSQLiteManager.h
//  G4Image
//
//  Created by LHY on 2017/4/11.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "SHIBeacon.h"
#import "SHButton.h"

@interface SHSQLiteManager : NSObject

// MARK: - 区域内部操作

/// 获得最大的按钮ID
- (NSUInteger)getMaxButtonID;

/// 将新创建的按钮保存在数据库中
- (void)inserNewButton:(SHButton *)button;

// MARK: - 区域操作

/// 搜索所有的iBeacon
- (NSMutableArray *)searchiBeacons;

/// 获得最大的iBeaconID
- (NSUInteger)getMaxiBeaconID;

/// 删除一个iBeacon
- (BOOL)deleteiBeacon:(SHIBeacon *)iBeacon;

/// 插入一个新的iBeacon
- (BOOL)insertiBeacon:(SHIBeacon *)iBeacon;

/// 这个iBeacon是否存在
- (BOOL)isiBeaconExist:(SHIBeacon *)iBeacon;

SingletonInterface(SHSQLiteManager)

@end

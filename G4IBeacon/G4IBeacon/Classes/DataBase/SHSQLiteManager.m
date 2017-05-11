//
//  SHSQLiteManager.m
//  G4Image
//
//  Created by LHY on 2017/4/11.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
/*
 SQL语句使用注意:
    1.在执行DDL语句，由于我拉放在字符串中，可以不加''来包含字段名和表名，但使用了字符串的值虽然使用的拼接，但在SQL中还要在用''来包括
        所得出的字符串。
 */

#import "SHSQLiteManager.h"
#import "FileTools.h"

#import <FMDB.h>

@interface SHSQLiteManager ()

/// 全局操作队列
@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation SHSQLiteManager

// MARK: - 每个iBeacon中所有的设备操作




// MARK: - iBeacon区域模块的操作

/// 搜索所有的iBeacon
- (NSMutableArray *)searchiBeacons {
    
    // 获得字典数组
    NSArray *resultiBeacons = [self selectProprty:@"select iBeaonID, name, uuidString, majorValue, minorValue, rssiValue, rssiBufValue from iBeaconList order by iBeaonID;"];
    
    // 将字典数组转换成模型
    NSMutableArray *alliBeacons = [NSMutableArray arrayWithCapacity:resultiBeacons.count];
    for (NSDictionary *dict in resultiBeacons) {
        
        [alliBeacons addObject: [SHIBeacon iBeaconWithDictionary:dict]];
    }
    
    return alliBeacons;
}

/// 获得最大的iBeaconID
- (NSUInteger)getMaxiBeaconID {
    
    // 获得结果ID
    id resID = [[[self selectProprty:@"select max(iBeaonID) from iBeaconList;"] lastObject] objectForKey:@"max(iBeaonID)"];
    return (resID == [NSNull null]) ? 0 : [resID integerValue];
}

/// 这个iBeacon是否存在
- (BOOL)isiBeaconExist:(SHIBeacon *)iBeacon {

    NSString *existSql = [NSString stringWithFormat:@"select name from iBeaconList where iBeaconID = %zd;", iBeacon.iBeaconID];
    
    return [[self selectProprty:existSql] count];
}

/// 已经添加过
- (BOOL)isAleardyAddiBeacon:(SHIBeacon *)iBeacon {

     NSString *existSql = [NSString stringWithFormat:@"select name from iBeaconList where uuidString = '%@'and majorValue = %zd and minorValue = %zd;", iBeacon.uuidString, iBeacon.majorValue, iBeacon.minorValue];
    
    return [[self selectProprty:existSql] count];
}

/// 删除一个iBeacon
- (BOOL)deleteiBeacon:(SHIBeacon *)iBeacon {
    
    
    // 如果区域还不存在就不要删除
    if (![self isiBeaconExist:iBeacon]) {
        return YES;
    }
    
    // 如果存在就直接删除
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM iBeaconList WHERE iBeaconID = %zd", iBeacon.iBeaconID];
    
    return [self insetData:deleteSql];
}

/// 插入一个新的iBeacon
- (BOOL)insertiBeacon:(SHIBeacon *)iBeacon {
    
    // 先判断是否添加过了
    if ([self isAleardyAddiBeacon:iBeacon]) {
        // 什么也不做
        return NO;
    }
    
    NSString *inserSql = @"";
    
    // 判断这个iBeaonID是否存在，如果存在更新，否则插入
    if ([self isiBeaconExist:iBeacon]) { // 更新
        
        inserSql = [NSString stringWithFormat:@"UPDATE iBeaconList SET name = '%@', uuidString = '%@', majorValue = %zd, minorValue = %zd, rssiValue = %zd, rssiBufValue = %zd WHERE iBeaconID = %zd", iBeacon.name, iBeacon.uuidString, iBeacon.majorValue, iBeacon.minorValue, iBeacon.rssiValue, iBeacon.rssiBufValue, iBeacon.iBeaconID];
        
    } else {  // 直接插入
       
        inserSql = [NSString stringWithFormat:@"INSERT  INTO iBeaconList(iBeaconID, name, uuidString, majorValue, minorValue, rssiValue, rssiBufValue) VALUES(%zd, '%@', '%@', %zd, %zd, %zd, %zd);", iBeacon.iBeaconID, iBeacon.name, iBeacon.uuidString, iBeacon.majorValue, iBeacon.minorValue, iBeacon.rssiValue, iBeacon.rssiBufValue];
    }
    
    return [self insetData:inserSql];
}

// MARK: - 创建表格

/// 创建当前区域的设备按钮表格
- (void)crateDeviceButtonForiBeacon {
    
    /*
     'zoneID' 			区域ID
     'buttonID' 		按钮ID
     'subnetID' 	按钮子网ID
     'deviceID' 	按钮设备ID
     'buttonKind'   按钮的类型
     
     'buttonPara1' 	 	不同设备的参数1
     'buttonPara2' 	 	不同设备的参数2
     'buttonPara3'      不同设备的参数3
     'buttonPara4' 	 	不同设备的参数4
     'buttonPara5' 	 	不同设备的参数5
     'buttonPara6'      不同设备的参数6
     */
    NSString *buttonSql = @"CREATE TABLE IF NOT EXISTS 'DeviceButtonForZone' (\
    'zoneID' INTEGER NOT NULL DEFAULT (0),\
    'buttonID' INTEGER PRIMARY KEY NOT NULL DEFAULT (1),\
    'subnetID' INTEGER NOT NULL DEFAULT (1),\
    'deviceID' INTEGER NOT NULL DEFAULT (0),\
    'buttonKind' INTEGER NOT NULL DEFAULT (0), \
                                               \
    'buttonPara1' INTEGER NOT NULL DEFAULT (0),\
    'buttonPara2' INTEGER NOT NULL DEFAULT (0),\
    'buttonPara3' INTEGER NOT NULL DEFAULT (0),\
    'buttonPara4' INTEGER NOT NULL DEFAULT (0),\
    'buttonPara5' INTEGER NOT NULL DEFAULT (0),\
    'buttonPara6' INTEGER NOT NULL DEFAULT (0)\
    );";
    
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        if ([db executeStatements:buttonSql]) {
            SHLog(@"创建操作设备");
        }
    }];
}


/// 创建iBeacon列表
- (void)createiBeacons {

    NSString *buttonSql = @"CREATE TABLE IF NOT EXISTS 'iBeaconList' (\
    'iBeaonID' INTEGER PRIMARY KEY DEFAULT (0),\
    'name' TEXT  NOT NULL ,\
    'uuidString' TEXT NOT NULL,\
    'majorValue' INTEGER NOT NULL DEFAULT (0),\
    'minorValue' INTEGER NOT NULL DEFAULT (0), \
    'rssiValue' INTEGER NOT NULL DEFAULT (0),\
    'rssiBufValue' INTEGER NOT NULL DEFAULT (0)\
    );";
    
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        if ([db executeStatements:buttonSql]) {
            SHLog(@"iBeacon表格创建成功");
        }
    }];
}

// MARK: - 以下是公共封装部分

///  创建表格
- (void)createSqlTables {
    
    // 创建一张iBeacon的列表
    [self createiBeacons];
  
    // 创建区域中的设备列表
    [self crateDeviceButtonForiBeacon];
}

/// 执行语句
- (BOOL)insetData:(NSString *)sql {
    
    __block BOOL res = YES;
    
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        if (![db executeUpdate:sql]) {
            res = NO;
        }
    }];
    
    return res;
}

/// 查询语句
- (NSMutableArray *)selectProprty:(NSString *)sql  {
    
    // 准备一个数组来存储所有内容
    __block NSMutableArray *array = [NSMutableArray array];
    
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        // 获得全部的记录
        FMResultSet *resultSet = [db executeQuery:sql];
        
        // 遍历结果
        while (resultSet.next) {
            
            // 准备一个字典
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            
            // 获得列数
            int count = [resultSet columnCount];
            
            // 遍历所有的记录
            for (int i = 0; i < count; i++) {
                
                // 获得字段名称
                NSString *name = [resultSet columnNameForIndex:i];
                
                // 获得字段值
                NSString *value = [resultSet objectForColumnName:name];
                
                // 存储在字典中
                dict[name] =  value;
            }
            
            // 添加到数组
            [array addObject:dict];
        }
    }];
    
    return array;
}


/// 创建数据库
- (instancetype)init {
    if (self = [super init]) {
        
        // 数据库路径
        NSString *filePath = [[FileTools documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", [FileTools appName]]];
        
        // 如果数据库不存在，会建立数据库，然后，再创建队列，并且打开数据库
        // 如果数据库存在，会直接创建队列且打开数据库
        self.queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
        
        // 创建表格
        [self createSqlTables];
    }
    return self;
}

// MARK: - 单例

SingletonImplementation(SHSQLiteManager)

@end

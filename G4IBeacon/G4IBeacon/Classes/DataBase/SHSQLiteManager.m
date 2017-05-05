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

/// 获得最大的iBeaconID
- (NSUInteger)getMaxiBeaconID {
    
    // 获得结果ID
    id resID = [[[self selectProprty:@"select max(iBeaonID) from iBeaconList"] lastObject] objectForKey:@"max(iBeaonID)"];
    return (resID == [NSNull null]) ? 0 : [resID integerValue];
}

/// 插入一个新的iBeacon
- (BOOL)insert:(SHIBeacon *)iBeacon {
    
    NSString *inserSql = [NSString stringWithFormat:@"INSERT  INTO iBeaconList(iBeaonID, name, uuidString, majorValue, minorValue, rssiValue, rssiBufValue) VALUES(%zd, '%@', '%@', %zd, %zd, %zd, %zd);", iBeacon.iBeaonID, iBeacon.name, iBeacon.uuidString, iBeacon.majorValue, iBeacon.minorValue, iBeacon.rssiValue, iBeacon.rssiBufValue];
    return [self insetData:inserSql];
}

// MARK: - 创建表格

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
            NSLog(@"iBeaon表格创建成功");
        }
    }];
}

// MARK: - 以下是公共封装部分

///  创建表格
- (void)createSqlTables {
    
    // 创建一张iBeacon的列表
    [self createiBeacons];
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

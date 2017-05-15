//
//  SHIBeacon.h
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHIBeacon : NSObject

/// iBeaonID
@property (nonatomic, assign) NSUInteger iBeaconID;

/// 名称
@property (nonatomic, copy) NSString *name;

/// UUID字符串
@property (nonatomic, copy) NSString *uuidString;

/// 主要值
@property (nonatomic, assign) NSUInteger majorValue;

/// 次要值
@property (nonatomic, assign) NSUInteger minorValue;

/// 设置有效区域值(这里是正数，实际使用是负数)
@property (nonatomic, assign) NSUInteger rssiValue;

/// 有效区域的误差
@property (nonatomic, assign) NSUInteger rssiBufValue;

/// 字典转换为模型
+ (instancetype)iBeaconWithDictionary:(NSDictionary *)dictionary;

/// 当前所有的设备按钮
@property (nonatomic, strong) NSMutableArray *allDeviceButtonInCurrentZone;

/// 进入区域的任务
@property (nonatomic, strong) NSMutableArray *enterAreaTasks;

/// 离开区域的任务
@property (nonatomic, strong) NSMutableArray *exitAreaTasks;

/// 是否进入区域
@property (assign, nonatomic) BOOL isEnterArea;

/// 是否离开区域
@property (assign, nonatomic) BOOL isExiteArea;

/// 区域成员数量
@property (nonatomic, assign) NSUInteger memberCount;

@end

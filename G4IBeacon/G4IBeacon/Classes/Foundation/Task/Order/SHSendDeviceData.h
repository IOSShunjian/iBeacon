//
//  SHSendDeviceData.h
//  G4IBeacon
//
//  Created by LHY on 2017/5/12.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHSendDeviceData : NSObject

/// 设置调光器
+ (void)setDimmer:(SHButton *)button;

/// 窗帘打开和关闭
+ (void)curtainOpenOrClose:(SHButton *)button;

/// 设置LED颜色
+ (void)setLedColor:(SHButton *)button;

/// AC 空调开关
+ (void)acOnAndOff:(SHButton *)button;

/// 温度变化
+ (void)updateACTempture:(SHButton *)button;

@end

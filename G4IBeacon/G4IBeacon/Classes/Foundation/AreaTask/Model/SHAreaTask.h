//
//  SHAreaTask.h
//  G4IBeacon
//
//  Created by LHY on 2017/5/11.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHAreaTask : NSObject

/// 执行类别
@property (nonatomic, assign) SHButtonType taskType;

/// 任务标记
@property (nonatomic, assign) BOOL isEnter;

/// 执行区域ID
@property (nonatomic, assign) NSUInteger iBeaconID;

/// 子网ID
@property (nonatomic, assign) Byte subNetID;

/// 设备ID
@property (nonatomic, assign) Byte deviceID;

/// 调光器通道
@property (nonatomic, assign) Byte dimmerChannelNumber;

/// 调光器的亮度
@property (nonatomic, assign) Byte dimmerBrightness;

@end

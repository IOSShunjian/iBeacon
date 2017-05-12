//
//  SHSendDeviceData.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/12.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHSendDeviceData.h"

@implementation SHSendDeviceData

/// 设置调光器
+ (void)setDimmer:(SHButton *)button {
    
    Byte lightData[4] = {button.buttonPara1, button.buttonPara2, 0X0, 0X0};
    
    // 发送指令
    [[SHUdpSocket shareSHUdpSocket] sendDataWithOperatorCode:0X0031 targetSubnetID:button.subNetID targetDeviceID:button.deviceID additionalContentData:[NSMutableData dataWithBytes:lightData length:sizeof(lightData)]];
}

@end

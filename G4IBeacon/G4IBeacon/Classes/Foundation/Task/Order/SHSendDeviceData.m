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

/// 窗帘打开和关闭
+ (void)curtainOpenOrClose:(SHButton *)button {
    
    // 打开和关闭通道
    Byte curtainStartOrStop = button.buttonPara3 ? button.buttonPara1 : button.buttonPara2;
    
    // 和Dimmer一样
    Byte curtainData[] = {curtainStartOrStop, 100, 0, 0};
    
    [[SHUdpSocket shareSHUdpSocket] sendDataWithOperatorCode:0X0031 targetSubnetID:button.subNetID targetDeviceID:button.deviceID additionalContentData:[NSMutableData dataWithBytes:curtainData length:sizeof(curtainData)]];
}

/// 设置LED颜色
+ (void)setLedColor:(SHButton *)button {
    
    Byte colorData[] = {button.buttonPara1, button.buttonPara2, button.buttonPara3, button.buttonPara4, 0X00, 0X00};
    
     [[SHUdpSocket shareSHUdpSocket] sendDataWithOperatorCode:0xF080 targetSubnetID:button.subNetID targetDeviceID:button.deviceID additionalContentData:[NSMutableData dataWithBytes:colorData length:sizeof(colorData)]];
}
@end

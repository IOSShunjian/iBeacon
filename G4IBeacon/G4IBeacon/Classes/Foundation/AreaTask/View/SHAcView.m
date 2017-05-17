//
//  SHAcView.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/16.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAcView.h"

@interface SHAcView ()

/// 空调开关
@property (weak, nonatomic) IBOutlet UISwitch *acSwitch;

/// 当前温度值
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

/// 改变温度值
@property (weak, nonatomic) IBOutlet UISlider *changeTempSlider;

@end

@implementation SHAcView


// 空调的打开和关闭
- (IBAction)acTurnOnAndOff {
    
    self.changeTempSlider.enabled = self.acSwitch.on;
    
    self.deviceButton.buttonPara1 = self.acSwitch.on;
    
    [SHSendDeviceData acOnAndOff:self.deviceButton];
}

/// 空调温度的变化
- (IBAction)acTempChange:(UISlider *)sender {
    
    // 获得温度
    Byte tempValue = (NSUInteger)self.changeTempSlider.value;
    
    self.tempLabel.text = [NSString stringWithFormat:@"%zd°C", tempValue];
    
    self.deviceButton.buttonPara2 = tempValue;
    
    [SHSendDeviceData updateACTempture:self.deviceButton];
}


- (void)setDeviceButton:(SHButton *)deviceButton {
    _deviceButton = deviceButton;
    
    // 设置状态
    self.acSwitch.on = deviceButton.buttonPara1;
    
    [SHSendDeviceData acOnAndOff:deviceButton];
    
    // 设置温度
    Byte tempValue = deviceButton.buttonPara2;
    
    SHLog(@"%d", tempValue);
    self.tempLabel.text = [NSString stringWithFormat:@"%zd°C", tempValue];
    
    self.changeTempSlider.value = tempValue;
    [self acTempChange:self.changeTempSlider];
}

+ (instancetype)acView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

//
//  SHCurtainView.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/9.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHCurtainView.h"

@interface SHCurtainView()

/// 窗帘开关
@property (weak, nonatomic) IBOutlet UISwitch *curtainSwitch;

@end

@implementation SHCurtainView

- (void)setDeviceButton:(SHButton *)deviceButton {
    _deviceButton = deviceButton;
    
    self.curtainSwitch.on = deviceButton.buttonPara3;
    
    [self trunOnOrOff:self.curtainSwitch];
}

- (IBAction)trunOnOrOff:(UISwitch *)sender {
    
    // 保存状态
    self.deviceButton.buttonPara3 = sender.on;
    
    // 发送指令
    [SHSendDeviceData curtainOpenOrClose:self.deviceButton];
}

+ (instancetype)curtainView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

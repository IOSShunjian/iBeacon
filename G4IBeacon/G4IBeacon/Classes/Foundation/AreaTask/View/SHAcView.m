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
    
    if (!self.acSwitch.on) {
        // 如果空调关闭 不能调节温度
        self.changeTempSlider.enabled = NO;
        
//        [SVProgressHUD showInfoWithStatus:@"The air conditioner is closed"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
    }
    
    self.deviceButton.buttonPara1 = self.acSwitch.on;
    
    [SHSendDeviceData acOnAndOff:self.deviceButton];
}


/// 空调温度的变化
- (IBAction)acTempChange {

    // 获得它的值
    Byte tempValue = (NSUInteger)self.changeTempSlider.value;
    
    self.tempLabel.text = [NSString stringWithFormat:@"%zd°C", tempValue];
    
    self.deviceButton.buttonPara2 = tempValue;
    
    [SHSendDeviceData updateACTempture:self.deviceButton];
}


- (void)setDeviceButton:(SHButton *)deviceButton {
    _deviceButton = deviceButton;
    
}

+ (instancetype)acView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

//
//  SHDimmerView.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/9.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHDimmerView.h"

@interface SHDimmerView()

/// 灯光值
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

/// 调整值
@property (weak, nonatomic) IBOutlet UISlider *slider;


@end

@implementation SHDimmerView

- (void)willMoveToWindow:(UIWindow *)newWindow {
    
//    self.slider.value = self.deviceButton.buttonPara2;
    
    Byte lightValue = self.deviceButton.buttonPara2;
    
//    [self slideChange:self.slider];
    
//    if (deviceButton.buttonKind == ButtonKindLight) {
//        SHLog(@"%d - %d", self.deviceButton.buttonPara1, self.deviceButton.buttonPara2);
//    }
}

- (void)setDeviceButton:(SHButton *)deviceButton {
    _deviceButton = deviceButton;
    
    Byte lightValue = deviceButton.buttonPara2;
    
    self.slider.value = lightValue;
    
    [self slideChange:self.slider];
}

- (IBAction)slideChange:(UISlider *)sender {
    
    // 获得它的值
    Byte lightValue = (NSUInteger)self.slider.value;
    
    self.valueLabel.text = [NSString stringWithFormat:@"%zd", lightValue];
    
    // 设置保存的亮度值
    self.deviceButton.buttonPara2 = lightValue;
}


+ (instancetype)dimmerView {
 
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}



@end

//
//  SHLedView.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/16.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHLedView.h"
#import "SHSelectColorViewController.h"

@interface SHLedView ()

/// 取色开关
@property (weak, nonatomic) IBOutlet UIButton *selectColorButton;

/// 显示选取后的颜色
@property (weak, nonatomic) IBOutlet UIView *showColorView;

@end

@implementation SHLedView

/// 设定值
- (void)setDeviceButton:(SHButton *)deviceButton {
    _deviceButton = deviceButton;
    
    UIColor *color = [UIColor colorWithRed:deviceButton.buttonPara1/100.0 green:deviceButton.buttonPara2/100.0 blue:deviceButton.buttonPara3/100.0 alpha:deviceButton.buttonPara4/100.0];
    
    self.showColorView.backgroundColor = color;
}

/// 选取颜色
- (IBAction)selectColor {
    
    SHSelectColorViewController *selectController = [[SHSelectColorViewController alloc] init];
    
    [selectController show:self.deviceButton colorView:self.showColorView];
}



+ (instancetype)ledView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

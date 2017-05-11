//
//  SHSettingViewController.m
//  G4Image
//
//  Created by LHY on 2017/4/6.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHSettingViewController.h"

@interface SHSettingViewController ()

/// 子网ID
@property (weak, nonatomic) IBOutlet UITextField *subNetTextField;

/// 设备ID
@property (weak, nonatomic) IBOutlet UITextField *deviceTextField;

/// 调光器通道
@property (weak, nonatomic) IBOutlet UITextField *dimmerChannel;

/// 打开窗帘
@property (weak, nonatomic) IBOutlet UITextField *curtainOpenChannel;

/// 关闭窗帘
@property (weak, nonatomic) IBOutlet UITextField *curtainCloseChannel;


@end

@implementation SHSettingViewController


#pragma mark - 点击事件

/// 保存
- (IBAction)saveButtonClick:(UIButton *)sender {
    
    self.settingButton.subNetID = (Byte)self.subNetTextField.text.integerValue;
    self.settingButton.deviceID = (Byte)self.deviceTextField.text.integerValue;
    
    if (self.settingButton.buttonKind == ButtonKindLight) {
        self.settingButton.buttonPara1 = (Byte)self.dimmerChannel.text.integerValue;
    }
    
    if (self.settingButton.buttonKind == ButtonKindCurtain) {
        self.settingButton.buttonPara1 = (Byte)self.curtainOpenChannel.text.integerValue;
        self.settingButton.buttonPara2 = (Byte)self.curtainCloseChannel.text.integerValue;
    }
    
    [SVProgressHUD showSuccessWithStatus:@"save Data"];
    [self.navigationController popViewControllerAnimated:YES];
}

/// 删除按钮
- (IBAction)deleteButtonClick:(UIButton *)sender {
    
    // 来源控制器的保存按钮数组中删除
//    if ([self.sourceViewController.zone.allDeviceButtonInCurrentZone containsObject:self.settingButton]) {
//        [self.sourceViewController.zone.allDeviceButtonInCurrentZone removeObject:self.settingButton];
//    }
//    
//    // 数据库也要删除
//    [[SHSQLiteManager shareSHSQLiteManager] deleteButton:self.settingButton];;
//    
//    // 从界面上删除这个按钮
//    [self.settingButton removeFromSuperview];
//    
    // 返回
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SHGlobalBackgroundColor;
    
    self.navigationItem.title = @"Setting";
    
    // 设置初值
    self.subNetTextField.text = [NSString stringWithFormat:@"%d", self.settingButton.subNetID];
    self.deviceTextField.text = [NSString stringWithFormat:@"%d", self.settingButton.deviceID];
    
    
    if (self.settingButton.buttonKind == ButtonKindLight) {
        self.dimmerChannel.text = [NSString stringWithFormat:@"%d", self.settingButton.buttonPara1];
    }
    
    if (self.settingButton.buttonKind == ButtonKindCurtain) {
        self.curtainOpenChannel.text = [NSString stringWithFormat:@"%d", self.settingButton.buttonPara1];
        self.curtainCloseChannel.text = [NSString stringWithFormat:@"%d", self.settingButton.buttonPara2];
    }
    
    // 子网ID成为第一响应者
    [self.subNetTextField becomeFirstResponder];
}

@end

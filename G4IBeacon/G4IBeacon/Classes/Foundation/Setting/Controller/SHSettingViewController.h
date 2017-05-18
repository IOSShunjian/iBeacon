//
//  SHSettingViewController.h
//  G4Image
//
//  Created by LHY on 2017/4/6.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//


#import "SHViewController.h"
#import "SHAreaViewController.h"

@interface SHSettingViewController : SHViewController

/// 设置按钮
@property (strong,nonatomic)SHButton *settingButton;

/// iBeacon模型
@property (nonatomic, strong) SHIBeacon *iBeacon;


@end

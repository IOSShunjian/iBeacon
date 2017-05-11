//
//  SHSettingDeviceViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/8.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHSettingDeviceViewController.h"

@interface SHSettingDeviceViewController ()

@end

@implementation SHSettingDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationBar {
    
    self.navigationItem.title = @"Setting Device";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveArgs)];
}

/// 保存参数
- (void)saveArgs {

    
}

@end

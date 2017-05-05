//
//  SHAddViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAddViewController.h"
#import "SHIBeacon.h"

@interface SHAddViewController ()

/// 名称
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

/// major值
@property (weak, nonatomic) IBOutlet UITextField *majorTextField;

/// minor值
@property (weak, nonatomic) IBOutlet UITextField *minorTextField;

/// 设置区域的触发值
@property (weak, nonatomic) IBOutlet UITextField *rssiTextField;

/// 触发值的误差范围(+-)
@property (weak, nonatomic) IBOutlet UITextField *rssiBufferTextField;


@end

@implementation SHAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置导航栏
    [self setUpNavigationBar];
}

/// 设置导航栏
- (void)setUpNavigationBar {

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveiBeacon)];
}

/// 保存区域
- (void)saveiBeacon {
    
    // 检测数据
    if (!self.nameTextField.text.length ||
        !self.minorTextField.text.length ||
        !self.majorTextField.text.length ||
        !self.rssiBufferTextField.text.length ||
        !self.rssiTextField.text.length ) {
        
        [SVProgressHUD showInfoWithStatus:@"Value Can not nil"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }

    // 获得所有的数据
    NSString *name = self.nameTextField.text;
    NSUInteger majorValue = self.majorTextField.text.integerValue;
    NSUInteger minorValue = self.minorTextField.text.integerValue;
    NSUInteger rssiValue = self.rssiTextField.text.integerValue;
    NSUInteger rssiBufValue = self.rssiBufferTextField.text.integerValue;
    
    // 创建一个模型
    SHIBeacon *iBeacon = [[SHIBeacon alloc] init];
    iBeacon.name = name;
    iBeacon.majorValue = majorValue;
    iBeacon.minorValue = minorValue;
    iBeacon.rssiValue = rssiValue;
    iBeacon.rssiBufValue = rssiBufValue;
    iBeacon.uuidString = UUIDStirng;
    
    // TODO: - 保存到数据库中去
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

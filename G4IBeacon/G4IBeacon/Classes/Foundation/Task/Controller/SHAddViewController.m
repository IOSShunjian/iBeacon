//
//  SHAddViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAddViewController.h"
#import "SHIBeacon.h"
#import "SHTaskViewController.h"

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

/// pickerView
@property (strong, nonatomic) UIPickerView *pickerView;

@end

@implementation SHAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SHGlobalBackgroundColor;
    
    // 设置导航栏
    [self setUpNavigationBar];
    
    // 设置数据
    self.nameTextField.text = self.iBeacon.name;
    self.majorTextField.text = [NSString stringWithFormat:@"%zd", self.iBeacon.majorValue];
    self.minorTextField.text = [NSString stringWithFormat:@"%zd", self.iBeacon.minorValue];
    self.rssiTextField.text = [NSString stringWithFormat:@"%zd", self.iBeacon.rssiValue];
    
    self.rssiBufferTextField.text = [NSString stringWithFormat:@"%zd", self.iBeacon.rssiBufValue];
}

/// 设置导航栏
- (void)setUpNavigationBar {

    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveiBeacon)];
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(deleteiBeacon)];
    
    self.navigationItem.rightBarButtonItems = @[saveItem, deleteItem];
}

/// 获得当前区域模型
- (void)getCurrentiBeacon {

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
    
    self.iBeacon.name = name;
    self.iBeacon.majorValue = majorValue;
    self.iBeacon.minorValue = minorValue;
    self.iBeacon.rssiValue = rssiValue;
    self.iBeacon.rssiBufValue = rssiBufValue;
    self.iBeacon.uuidString = UUIDStirng;
}

/// 删除区域
- (void)deleteiBeacon {

    [self getCurrentiBeacon];
    
    // TODO: - 保存到数据库中去
    [[SHSQLiteManager shareSHSQLiteManager] deleteiBeacon:self.iBeacon];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
    // 直接回到任务列表
    for (UIViewController *viewController in self.navigationController.childViewControllers) {
        if ([viewController isKindOfClass:[SHTaskViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}

/// 保存区域
- (void)saveiBeacon {
    
    [self getCurrentiBeacon];
    
    // TODO: - 保存到数据库中去
    [[SHSQLiteManager shareSHSQLiteManager] insertiBeacon:self.iBeacon];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

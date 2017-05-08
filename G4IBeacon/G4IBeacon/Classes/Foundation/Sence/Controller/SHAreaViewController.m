//
//  SHAreaViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/8.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAreaViewController.h"
#import "SHEnterAreaViewController.h"

@interface SHAreaViewController ()

@end

@implementation SHAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航
    [self setUpNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 设置导航
- (void)setUpNavigationBar {
    
    self.navigationItem.title = [self isKindOfClass:[SHEnterAreaViewController class]] ? @"Enter Area" : @"Exit Area";
    
    //    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAreaTask)];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addNewTask)];
    
    self.navigationItem.rightBarButtonItems = @[ addItem];
}

/// 保存区域任务
- (void)saveAreaTask {
    
}

/// 新增任务
- (void)addNewTask {
    
    
}


@end

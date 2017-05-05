//
//  SHSenceViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHSenceViewController.h"

@interface SHSenceViewController ()

/// 任务选项卡
@property (weak, nonatomic) UISegmentedControl *segmentedControl;

@end

@implementation SHSenceViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.segmentedControl.frame = CGRectMake(0, SHNavigationBarHeight, self.view.frame_width, SHTabBarHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Sence";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setUpsegmentedControl];
}

/// 设置选项卡
- (void)setUpsegmentedControl {

    // 添加选择卡
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Enter", @"Exit"]];
    [self.view addSubview:segmentedControl];
    self.segmentedControl = segmentedControl;
    
    // 增加监听
    [segmentedControl addTarget:self action:@selector(selectGoal:) forControlEvents:UIControlEventValueChanged];
    
    // 默认进入选择第一项
    segmentedControl.selectedSegmentIndex = 0;
    [self selectGoal:segmentedControl];
    
    // 设置字体
    [segmentedControl setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]} forState:UIControlStateNormal];
}

/// 选项卡
- (void)selectGoal:(UISegmentedControl *)segmentedControl {
    
    if (segmentedControl.selectedSegmentIndex) {
        NSLog(@"退出任务");
    } else {
        NSLog(@"进入任务");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end

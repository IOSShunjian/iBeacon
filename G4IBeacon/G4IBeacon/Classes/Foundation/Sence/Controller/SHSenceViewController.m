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

/// 进入区域任务
@property (weak, nonatomic) UIView *enterView;

/// 离开区域任务
@property (weak, nonatomic) UIView *exitView;

@end

@implementation SHSenceViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.segmentedControl.frame = CGRectMake(0, SHNavigationBarHeight, self.view.frame_width, SHTabBarHeight);
    
    self.enterView.frame = self.view.bounds;
    self.enterView.frame_y = SHNavigationBarHeight + SHTabBarHeight;
    
    self.exitView.frame = self.view.bounds;
    self.exitView.frame_y = SHNavigationBarHeight + SHTabBarHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Sence";
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - 代理

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath.section && !indexPath.row) {
        NSLog(@"设置");
    
    } else {
    
        if (!indexPath.row) {
            NSLog(@"进入区域的任务");
        } else {
            NSLog(@"离开区域的任务");
        }
    }
}

 

@end

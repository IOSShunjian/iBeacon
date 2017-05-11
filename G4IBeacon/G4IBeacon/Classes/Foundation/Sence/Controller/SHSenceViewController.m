//
//  SHSenceViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHSenceViewController.h"
#import "SHAddViewController.h"
//#import "SHAreaViewController.h"
#import "SHExitAreaViewController.h"
#import "SHEnterAreaViewController.h"

@interface SHSenceViewController ()


@end

@implementation SHSenceViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SHGlobalBackgroundColor;
    
    self.navigationItem.title = @"Sence";
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 设置区域
- (void)setUpiBeacon {

    SHAddViewController *addViewController = [[SHAddViewController alloc] init];
    
    addViewController.iBeacon = self.iBeacon;
    
    [self.navigationController pushViewController:addViewController animated:YES];
}

/// 设置进入区域的任务
- (void)seUpEnterTasks  {
    
    SHEnterAreaViewController *areaViewController = [[SHEnterAreaViewController alloc] init];
    
    [self.navigationController pushViewController:areaViewController animated:YES];
}

/// 设置离开区域的任务
- (void)seUpExitTasks {
    SHExitAreaViewController *areaViewController = [[SHExitAreaViewController alloc] init];
    
    [self.navigationController pushViewController:areaViewController animated:YES];
}

// MARK: - 代理

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath.section && !indexPath.row) {
       
        [self setUpiBeacon];
    
    } else {
        if (!indexPath.row) {
            // 进入区域
            [self seUpEnterTasks];
        } else {
            [self seUpExitTasks];
        }
    }
}

@end

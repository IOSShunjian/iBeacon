//
//  SHAreaViewController.h
//  G4IBeacon
//
//  Created by LHY on 2017/5/8.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHViewController.h"
#import "SHIBeacon.h"

@interface SHAreaViewController : SHViewController

/// iBeacon模型
@property (nonatomic, strong) SHIBeacon *iBeacon;

/// 当前区域的任务
//@property (strong, nonatomic) NSMutableArray *tasks;

@end

//
//  SHAreaViewController.h
//  G4IBeacon
//
//  Created by LHY on 2017/5/8.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHIBeacon.h"

@interface SHAreaViewController :SHTableViewController

/// iBeacon模型
@property (nonatomic, strong) SHIBeacon *iBeacon;

@end

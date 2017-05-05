//
//  SHAllTableViewCell.h
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SHAllTableViewCell : UITableViewCell

/// 对应的设备
@property (nonatomic, strong) CLBeacon *beacon;

/// 行高
+ (CGFloat)cellRowHeight;

@end

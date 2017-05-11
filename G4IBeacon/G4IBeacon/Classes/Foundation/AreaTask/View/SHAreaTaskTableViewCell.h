//
//  SHAreaTaskTableViewCell.h
//  G4IBeacon
//
//  Created by LHY on 2017/5/9.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHAreaTaskTableViewCell : UITableViewCell

/// cell对应的按钮
@property (nonatomic, strong) SHButton *deviceButton;

/// 行高
+ (CGFloat)cellRowHeight;

@end

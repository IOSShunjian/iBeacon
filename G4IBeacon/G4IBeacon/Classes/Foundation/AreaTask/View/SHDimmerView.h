//
//  SHDimmerView.h
//  G4IBeacon
//
//  Created by LHY on 2017/5/9.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHDimmerView : UIView

/// 实现化调节器
+ (instancetype)dimmerView;

/// cell对应的按钮
@property (nonatomic, strong) SHButton *deviceButton;

@end

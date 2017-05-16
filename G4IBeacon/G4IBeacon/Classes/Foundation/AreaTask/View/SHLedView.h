//
//  SHLedView.h
//  G4IBeacon
//
//  Created by LHY on 2017/5/16.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHLedView : UIView

/// 实现化调节器
+ (instancetype)ledView;

/// cell对应的按钮
@property (nonatomic, strong) SHButton *deviceButton;

@end

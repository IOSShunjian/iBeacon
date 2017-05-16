//
//  SHAcView.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/16.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAcView.h"

@implementation SHAcView

- (void)setDeviceButton:(SHButton *)deviceButton {
    _deviceButton = deviceButton;
    
}

+ (instancetype)acView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

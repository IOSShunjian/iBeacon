//
//  SHAudioView.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/16.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAudioView.h"

@implementation SHAudioView

- (void)setDeviceButton:(SHButton *)deviceButton {
    _deviceButton = deviceButton;
    
    
}

/// 实例化
+ (instancetype)audioView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

//
//  SHCurtainView.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/9.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHCurtainView.h"

@interface SHCurtainView()



@end

@implementation SHCurtainView

- (IBAction)trunOnOrOff:(UISwitch *)sender {
    
    if (sender.on) {
        NSLog(@"打开");
    } else {
        NSLog(@"关闭");
    }
}


+ (instancetype)curtainView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

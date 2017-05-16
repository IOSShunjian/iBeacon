//
//  SHLedView.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/16.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHLedView.h"

@interface SHLedView ()

/// 取色开关
@property (weak, nonatomic) IBOutlet UIButton *selectColorButton;

/// 显示选取后的颜色
@property (weak, nonatomic) IBOutlet UIView *showColorView;


@end

@implementation SHLedView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.showColorView.hidden = YES;
}

/// 设定值
- (void)setDeviceButton:(SHButton *)deviceButton {
    _deviceButton = deviceButton;
    
    
}

/// 选取颜色
- (IBAction)selectColor {
    
    
}



+ (instancetype)ledView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
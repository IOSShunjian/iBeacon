//
//  SHDimmerView.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/9.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHDimmerView.h"

@interface SHDimmerView()

/// 灯光值
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;


@end

@implementation SHDimmerView

- (void)willMoveToWindow:(UIWindow *)newWindow {
    
    self.valueLabel.text = [NSString stringWithFormat:@"50"];
}

- (IBAction)slideChange:(UISlider *)sender {
    
    self.valueLabel.text = [NSString stringWithFormat:@"%zd", (NSUInteger)sender.value];
}


+ (instancetype)dimmerView {
 
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

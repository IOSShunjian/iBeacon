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

/// 调整值
@property (weak, nonatomic) IBOutlet UISlider *slider;


@end

@implementation SHDimmerView

- (void)willMoveToWindow:(UIWindow *)newWindow {
    
    [self slideChange:self.slider];
}

- (IBAction)slideChange:(UISlider *)sender {
    
    self.valueLabel.text = [NSString stringWithFormat:@"%zd", (NSUInteger)self.slider.value];
}


+ (instancetype)dimmerView {
 
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

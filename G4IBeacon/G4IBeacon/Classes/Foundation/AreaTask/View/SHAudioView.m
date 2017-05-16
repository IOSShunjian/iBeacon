//
//  SHAudioView.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/16.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAudioView.h"

@interface SHAudioView ()

/// 播放按钮
@property (weak, nonatomic) IBOutlet UIButton *playButton;

/// 音量
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;

/// 音量调整大小
@property (weak, nonatomic) IBOutlet UISlider *volSlider;


@end

@implementation SHAudioView

/// 播放
- (IBAction)playClick {
    
    SHLog(@"正在播放");
    
}

/// 改变量音量
- (IBAction)changeVolume {

}

/// 上一首
- (IBAction)lastSong {
    
    SHLog(@"上一首");

}

/// 下一首
- (IBAction)nextSong {
    
    SHLog(@"下一首");
}


- (void)setDeviceButton:(SHButton *)deviceButton {
    _deviceButton = deviceButton;
    
    
}

/// 实例化
+ (instancetype)audioView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

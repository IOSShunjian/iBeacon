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
    
    self.playButton.selected = !self.playButton.selected;
    self.deviceButton.buttonPara1 = self.playButton.selected;
    
    if (self.playButton.selected) {
        self.volSlider.enabled = NO;
    }
    
    [SHSendDeviceData musicPlayAndStop:self.deviceButton];
    
    
}

/// 改变量音量
- (IBAction)changeVolume:(UISlider *)sender {
    
    // 获得它的值
    Byte volValue = (NSUInteger)self.volSlider.value;
    
    self.volumeLabel.text = [NSString stringWithFormat:@"%zd", volValue];
    self.deviceButton.buttonPara2 = self.volSlider.maximumValue - volValue;
    
    [SHSendDeviceData updateAuidoVOL:self.deviceButton];
}

/// 上一首
- (IBAction)lastSong {
    
    [SHSendDeviceData playSong:self.deviceButton isNext:YES];
}

/// 下一首
- (IBAction)nextSong {
    [SHSendDeviceData playSong:self.deviceButton isNext:NO];
}


- (void)setDeviceButton:(SHButton *)deviceButton {
    _deviceButton = deviceButton;
    
    self.playButton.selected = deviceButton.buttonPara1;
    
    Byte vol = deviceButton.buttonPara2;
    
    self.volumeLabel.text = [NSString stringWithFormat:@"%zd", vol];
    
    self.volSlider.value = vol;
    
    [self changeVolume:self.volSlider];
}

/// 实例化
+ (instancetype)audioView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end

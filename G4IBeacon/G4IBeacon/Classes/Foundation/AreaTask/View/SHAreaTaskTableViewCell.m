//
//  SHAreaTaskTableViewCell.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/9.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAreaTaskTableViewCell.h"
#import "SHSettingViewController.h"

#import "SHDimmerView.h"
#import "SHCurtainView.h"
#import "SHLedView.h"
#import "SHAudioView.h"
#import "SHAcView.h"

@interface SHAreaTaskTableViewCell()

/// 名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/// 图片
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

/// 匹配不同的view
@property (weak, nonatomic) IBOutlet UIView *diferentView;

/// 灯光调节器
@property (strong, nonatomic) SHDimmerView *lightView;

/// 窗帘
@property (strong, nonatomic) SHCurtainView *curtainView;

/// LED
@property (strong, nonatomic) SHLedView *ledView;

/// 音乐
@property (strong, nonatomic) SHAudioView *audioView;

/// 空调
@property (strong, nonatomic) SHAcView *acView;

@end

@implementation SHAreaTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 取消选择
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 添加手势
    self.iconView.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(setDeviceButtonArgs)];
    
    longPressGestureRecognizer.minimumPressDuration = 1.0;
    
    [self.iconView addGestureRecognizer:longPressGestureRecognizer];
    
}

/// 设置设备按钮的参数
- (void)setDeviceButtonArgs {

    SHSettingViewController *settingViewController = [[UIStoryboard storyboardWithName:NSStringFromClass([SHSettingViewController class]) bundle:nil] instantiateInitialViewController];
    
    // 传递参数
    settingViewController.settingButton = self.deviceButton;
    settingViewController.iBeacon = self.iBeacon;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:settingViewController animated:YES completion:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

/// 设置模型
- (void)setDeviceButton:(SHButton *)deviceButton {
    
    _deviceButton = deviceButton;
    self.nameLabel.text = [SHButton buttonDefaultTitleFromKind:deviceButton];
    
    self.iconView.image = [UIImage imageNamed:self.nameLabel.text];
    
    switch (deviceButton.buttonKind) {
        case ButtonKindLight: { // 调光器
            
            [self.diferentView addSubview:self.lightView];
            self.lightView.deviceButton = deviceButton;
            self.lightView.frame = self.diferentView.bounds;
            
//            // 隐藏其它类型
//            self.acView.hidden = YES;
//            self.ledView.hidden = YES;
//            self.audioView.hidden = YES;
//            self.curtainView.hidden = YES;
        }
            break;
            
        case ButtonKindCurtain: {
            
            [self.diferentView addSubview:self.curtainView];
            self.curtainView.deviceButton = deviceButton;
            self.curtainView.frame = self.diferentView.bounds;
            
//            // 隐藏其它类型
//            self.acView.hidden = YES;
//            self.ledView.hidden = YES;
//            self.audioView.hidden = YES;
//            self.lightView.hidden = YES;
        }
            break;
            
        case ButtonKindLed: {
            
            [self.diferentView addSubview:self.ledView];
            self.ledView.deviceButton = deviceButton;
            self.ledView.frame = self.diferentView.bounds;
            
//            // 隐藏其它类型
//            self.acView.hidden = YES;
//            self.curtainView.hidden = YES;
//            self.audioView.hidden = YES;
//            self.lightView.hidden = YES;
        }
            break;
            
        case ButtonKindAC: {
            [self.diferentView addSubview:self.acView];
        
            self.acView.deviceButton = deviceButton;
            self.acView.frame = self.diferentView.bounds;
            
//            // 隐藏其它类型
//            self.curtainView.hidden = YES;
//            self.ledView.hidden = YES;
//            self.audioView.hidden = YES;
//            self.lightView.hidden = YES;
        }
            break;
            
        case ButtonKindMusic:{
        
            [self.diferentView addSubview:self.audioView];
            self.audioView.deviceButton = deviceButton;
            self.audioView.frame = self.diferentView.bounds;
            
//            // 隐藏其它类型
//            self.acView.hidden = YES;
//            self.ledView.hidden = YES;
//            self.curtainView.hidden = YES;
//            self.lightView.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

+ (CGFloat)cellRowHeight {
    
    return 85;
}

// MARK: - getter && setter

- (SHCurtainView *)curtainView {
    
    if (!_curtainView) {
        _curtainView = [SHCurtainView curtainView];
    }
    return _curtainView;
}

- (SHDimmerView *)lightView {
    
    if (!_lightView) {
        _lightView = [SHDimmerView dimmerView];
    }
    return _lightView;
}

- (SHLedView *)ledView {
    
    if (!_ledView) {
        _ledView = [SHLedView ledView];
    }
    return _ledView;
}

- (SHAudioView *)audioView {
    
    if (!_audioView) {
        _audioView = [SHAudioView audioView];
    }
    return _audioView;
}

- (SHAcView *)acView {
    
    if (!_acView) {
        _acView = [SHAcView acView];
    }
    return _acView;
}

@end

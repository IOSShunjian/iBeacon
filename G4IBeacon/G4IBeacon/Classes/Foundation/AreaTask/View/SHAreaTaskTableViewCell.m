//
//  SHAreaTaskTableViewCell.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/9.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAreaTaskTableViewCell.h"

#import "SHDimmerView.h"
#import "SHCurtainView.h"

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

@end

@implementation SHAreaTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
     
}

- (void)setDeviceButton:(SHButton *)deviceButton {
    
    _deviceButton = deviceButton;
    self.nameLabel.text = [SHButton buttonDefaultTitleFromKind:deviceButton];
    
    self.iconView.image = [UIImage imageNamed:self.nameLabel.text];
    
    switch (deviceButton.buttonKind) {
        case ButtonKindLight: { // 调光器
            
            [self.diferentView addSubview:self.lightView];
            self.lightView.deviceButton = deviceButton;
            self.lightView.frame = self.diferentView.bounds;
        }
            break;
            
        case ButtonKindCurtain: {
            
            [self.diferentView addSubview:self.curtainView];
            self.curtainView.deviceButton = deviceButton;
            self.curtainView.frame = self.diferentView.bounds;
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

@end

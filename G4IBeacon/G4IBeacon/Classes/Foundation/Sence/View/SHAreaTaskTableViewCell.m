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

@end

@implementation SHAreaTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setButton:(SHButton *)button {
    _button = button;
    
    self.nameLabel.text = [button titleForState:UIControlStateNormal];
    
    self.iconView.image = [UIImage imageNamed:self.nameLabel.text];
    
    switch (button.buttonKind) {
        case SHButtonTypeDimmer: { // 调光器
            
            SHDimmerView *dimmerView = [SHDimmerView dimmerView];
            
            [self.diferentView addSubview:dimmerView];
            
            dimmerView.frame = self.diferentView.bounds;
            
        }
            break;
            
        case SHButtonTypeCurtain: {
        
            SHCurtainView *curtainView = [SHCurtainView  curtainView];
            
            [self.diferentView addSubview:curtainView];
            
            curtainView.frame = self.diferentView.bounds;
        }
            break;
            
        default:
            break;
    }
}

+ (CGFloat)cellRowHeight {
    
    return 85;
}


@end

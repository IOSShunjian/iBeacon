//
//  SHTaskCollectionViewCell.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHTaskCollectionViewCell.h"

@interface SHTaskCollectionViewCell ()

/// 名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SHTaskCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setIBeacon:(SHIBeacon *)iBeacon {
    
    _iBeacon = iBeacon;
    
    // 设置值
    self.nameLabel.text = iBeacon.name;
}

@end

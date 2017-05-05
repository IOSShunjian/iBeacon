//
//  SHAllTableViewCell.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHAllTableViewCell.h"

@interface SHAllTableViewCell ()



@end

@implementation SHAllTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/// 行高
+ (CGFloat)cellRowHeight {
    
    return 85;
}

@end

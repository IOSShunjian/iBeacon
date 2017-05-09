//
//  SHButton.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/9.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHButton.h"
#define SHButtonMaign (5)

@interface SHButton ()


@end


@implementation SHButton

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= SHButtonMaign;
    [super setFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
    }
    return self;
}

 

@end

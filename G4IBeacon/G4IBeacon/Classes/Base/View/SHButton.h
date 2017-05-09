//
//  SHButton.h
//  G4IBeacon
//
//  Created by LHY on 2017/5/9.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    SHButtonTypeCustom,
    SHButtonTypeDimmer,
    SHButtonTypeLed,
    SHButtonTypeAc,
    SHButtonTypeAudio,
    SHButtonTypeCurtain
    
} SHButtonType;


@interface SHButton : UIButton

/// 类型
@property (nonatomic, assign) SHButtonType buttonKind;



@end

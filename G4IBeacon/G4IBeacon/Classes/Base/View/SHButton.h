//
//  SHButton.h
//  TouchTest
//
//  Created by Firas on 4/4/17.
//  Copyright (c) 2013 SH. All rights reserved.
//

#import <UIKit/UIKit.h>

// 音乐播放控制
typedef enum  {
    
    SHAudoiPalyControlNone,
    SHAudoiPalyControlPrevious,
    SHAudoiPalyControlNext,
    SHAudoiPalyControlPlay,
    SHAudoiPalyControlStop
    
} SHAudoiPalyControl;

/// 按钮类型
typedef enum  {
    
    ButtonKindNone,
    
    ButtonKindLight,
    ButtonKindLed,

    ButtonKindAC,
    ButtonKindMusic,

    ButtonKindCurtain,
    ButtonKindMediaTV
    
} ButtonKind ;


@interface SHButton : UIButton

/// 按钮区域ID
@property (assign,nonatomic)NSUInteger iBeaconID;

/// 按钮ID
@property (assign,nonatomic)NSUInteger buttonID;

/// 子网ID
@property (assign,nonatomic)Byte subNetID;

/// 设备ID
@property (nonatomic, assign) Byte deviceID;

/// 按钮类型
@property (assign,nonatomic ) ButtonKind buttonKind;


#pragma mark - 不同的参数(不同设备不同)

/// 参数一:[Dim: 通道, Curtain: Open通道]
@property (assign, nonatomic) Byte buttonPara1;

/// 参数二: [Curtain:  Close 通道];
@property (assign, nonatomic) Byte buttonPara2;

@property (assign, nonatomic) Byte buttonPara3;
@property (assign, nonatomic) Byte buttonPara4;
@property (assign, nonatomic) Byte buttonPara5;
@property (assign, nonatomic) Byte buttonPara6;


/// 字典转换为模型
+ (instancetype)buttonWithDictionary:(NSDictionary *)dictionary;

/// 由类型来确定默认名称
+ (NSString *)buttonDefaultTitleFromKind:(SHButton *)button;

@end

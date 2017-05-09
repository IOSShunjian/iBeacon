//
//  UIButton+init.m



#import "UIButton+init.h"

@implementation UIButton (init)



/**
 实例化按钮

 @param imageName 常态图片名称
 @param hightlightedImageName 点击下的图片名称
 @param target 点击响应者
 @param action 响应事件
 @return 按钮
 */
+ (instancetype)buttonWithImageName:(NSString *)imageName hightlightedImageName:(NSString *)hightlightedImageName addTarget:(id)target action:(SEL)action {
    
    UIButton *button  = [[UIButton alloc] init];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hightlightedImageName] forState:UIControlStateHighlighted];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button sizeToFit];
    
    return button;
}

@end

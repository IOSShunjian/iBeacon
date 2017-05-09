//
//  UIButton+init.h


#import <UIKit/UIKit.h>

@interface UIButton (init)

/**
 实例化按钮(如果不需要点击事件 参数使用 nil)
 
 @param imageName 常态图片名称
 @param hightlightedImageName 点击下的图片名称
 @param target 点击响应者
 @param action 响应事件
 @return 按钮
 */
+ (instancetype)buttonWithImageName:(NSString *)imageName hightlightedImageName:(NSString *)hightlightedImageName addTarget:(id)target action:(SEL)action;


@end

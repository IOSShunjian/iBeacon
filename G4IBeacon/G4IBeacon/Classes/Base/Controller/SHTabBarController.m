//
//  SHTabBarController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHTabBarController.h"
#import "SHNavigationController.h"
#import "UIColor+set.h"

#import "SHAllViewController.h"
#import "SHTaskViewController.h"

#define SHTabBarFont ([UIFont systemFontOfSize:15])

@interface SHTabBarController ()

@end

@implementation SHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 添加子控制器
    [self addChildControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// MARK: - 增加子控制器

/// 设置字体
+ (void)initialize {
    
    // 常态
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: SHTabBarFont, NSForegroundColorAttributeName : [UIColor cololrWithHex:0X1296db alpa:1.0]} forState:UIControlStateNormal];
    
    // 选中状态 
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor cololrWithHex:0Xd81e06 alpa:1.0]} forState:UIControlStateSelected];
}

/// 添加所有的子控制器
- (void)addChildControllers {
    
    [self setUpChildController:[[SHAllViewController alloc] init] title:@"All" imageName:@"All" highlightedImageName:@"All_highlighted"];

   [self setUpChildController:[[SHTaskViewController alloc] init] title:@"task" imageName:@"task" highlightedImageName:@"task_highlighted"];
}

/**
 添加单个子控制器
 
 @param viewController 子控制器
 @param title 标题
 @param imageName 常态下图片的名称
 @param highlightedImageName 高亮状态下的图片名称
 */
- (void)setUpChildController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName {
    
    viewController.title = title;
    
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:highlightedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置字体颜色和大小 -- 代码在上面 initialize
    
    // 添加到父控件上
    [self addChildViewController:[[SHNavigationController alloc] initWithRootViewController:viewController]];
}

@end

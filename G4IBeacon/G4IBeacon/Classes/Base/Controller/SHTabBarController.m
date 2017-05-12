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

@interface SHTabBarController ()

@end

@implementation SHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 程序启动进入相应的面面
    [self viewWillTransitionToSize:self.view.bounds.size withTransitionCoordinator:self.transitionCoordinator];
    
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
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: SHTabBarFont, NSForegroundColorAttributeName : SHTextNormalColor } forState:UIControlStateNormal];
    
    // 选中状态 
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: SHTextHighlightedColor } forState:UIControlStateSelected];
}

/// 添加所有的子控制器
- (void)addChildControllers {
    
    [self setUpChildController:[[SHTaskViewController alloc] init] title:@"task" imageName:@"task" highlightedImageName:@"task_highlighted"];
    
//    [self setUpChildController:[[SHAllViewController alloc] init] title:@"All" imageName:@"All" highlightedImageName:@"All_highlighted"];
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

// MARK: - 横竖屏适配

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return [super supportedInterfaceOrientations];
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

@end

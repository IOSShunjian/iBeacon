//
//  SHNavigationController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHNavigationController.h"
#import "UIColor+set.h"

/**
 注意：这不是一个真正的协议，只是为了防止系统报警告
 */
@protocol recognizerDelegate <NSObject>

@optional

- (void)handleNavigationTransition:(UIGestureRecognizer *)recognizer;

@end

@interface SHNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation SHNavigationController

/// 设置统一的背景与字体
+ (void)load {
    
    // 设置字体
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:22], NSForegroundColorAttributeName: SHTextHighlightedColor}];
    
    [[UINavigationBar appearance] setTintColor:SHTextNormalColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 滑动返回
//    // 创建手势
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//    
//    pan.delegate = self;
//    
//    [self.view addGestureRecognizer:pan];
//    
//    // 禁用系统的
//    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 手势代理
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    
//    return self.childViewControllers.count > 1; // 不是栈顶控制器才有效
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置返回item
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemTitle:@"" font:[UIFont systemFontOfSize:20] normalTextColor:SHTextNormalColor highlightedTextColor:SHTextHighlightedColor imageName:@"return" hightlightedImageName:@"return_highlighted" addTarget:self action:@selector(popBack)];
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)popBack {
    [self popViewControllerAnimated:YES];
}

@end

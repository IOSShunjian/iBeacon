//
//  SHNavigationController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHNavigationController.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 滑动返回
    // 创建手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
    
    // 禁用系统的
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    return self.childViewControllers.count > 1; // 不是栈顶控制器才有效
}

@end

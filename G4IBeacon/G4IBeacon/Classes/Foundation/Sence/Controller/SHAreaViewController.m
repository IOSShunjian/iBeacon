//
//  SHAreaViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/8.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

 
#import "SHEnterAreaViewController.h"
#import "SHExitAreaViewController.h"
#import "SHSettingDeviceViewController.h"

@interface SHAreaViewController () <UITableViewDelegate, UITableViewDataSource>

/// 选择不同的设备列表
@property (strong, nonatomic) UIScrollView *selectDeviceButtonScrollView;

/// 设备列表名称
@property (strong, nonatomic) NSArray *selectNames;

/// 显示任务的tableView
@property (strong, nonatomic) UITableView *taskView;

@property (strong, nonatomic) NSMutableArray *tasks;

@end

@implementation SHAreaViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.selectDeviceButtonScrollView.frame  = CGRectMake(self.view.frame_width - SHNavigationBarHeight, SHNavigationBarHeight,SHNavigationBarHeight, self.view.frame_height - SHNavigationBarHeight);
    
    for (NSUInteger i = 0; i < self.selectDeviceButtonScrollView.subviews.count; i++) {
        UIView *subView = self.selectDeviceButtonScrollView.subviews[i];
        
        if ([subView isKindOfClass:[UIButton class]]) {
            subView.frame = CGRectMake(0, subView.tag * SHTabBarHeight , self.selectDeviceButtonScrollView.frame_width, SHTabBarHeight);
        }
    }
    self.taskView.frame = self.view.bounds;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航
    [self setUpNavigationBar];
    
    [self.view addSubview:self.taskView];
    
    [self.view addSubview:self.selectDeviceButtonScrollView];
    self.selectDeviceButtonScrollView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 设置导航
- (void)setUpNavigationBar {
    
    self.navigationItem.title = [self isKindOfClass:[SHEnterAreaViewController class]] ? @"Enter Area" : @"Exit Area";
    
    //    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAreaTask)];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addNewTask)];
    
    self.navigationItem.rightBarButtonItems = @[addItem];
}

/// 保存区域任务
- (void)saveAreaTask {
    
}

/// 新增任务
- (void)addNewTask {
    
    self.selectDeviceButtonScrollView.hidden = !self.selectDeviceButtonScrollView.hidden;
}

/// 按钮点击
- (void)selectDeviceTouched:(UIButton *)button {
    
    [self.tasks addObject:button];
    
    [self.taskView reloadData];
}

// MARK: - 代理

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SHSettingDeviceViewController *setDeviceViewController = [[SHSettingDeviceViewController alloc] init];
    

    [self.navigationController pushViewController:setDeviceViewController animated:YES];
}


// MARK: - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    // 获得按钮
    UIButton *button = self.tasks[indexPath.row];
    
    cell.textLabel.text = [button titleForState:UIControlStateNormal];
    cell.imageView.image = [UIImage imageNamed:cell.textLabel.text];
    
    return cell;
    
}

// MARK: - getter && setter

/// 选择设备列表框
- (UIScrollView *)selectDeviceButtonScrollView {
    
    if (!_selectDeviceButtonScrollView) {
        
        _selectDeviceButtonScrollView = [[UIScrollView alloc] init];
        _selectDeviceButtonScrollView.showsVerticalScrollIndicator = YES;
        _selectDeviceButtonScrollView.pagingEnabled = YES;

        
        // 添加按钮
        NSArray *selectNames = @[@"Dimmer", @"AC",@"Audio", @"Curtain", @"LED"];
        self.selectNames = selectNames;
        
        _selectDeviceButtonScrollView.contentSize = CGSizeMake(0, selectNames.count * SHTabBarHeight);
        
        for (NSUInteger i = 0; i < selectNames.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.backgroundColor = [UIColor orangeColor];
            
            button.tag = i;
            
            // 匹配图片和文字
//            [button setImage:[UIImage imageNamed:selectNames[i]] forState:UIControlStateNormal];
            [button setTitle:[selectNames objectAtIndex:i] forState:UIControlStateNormal];
            
            // 点击显示出来
            [button addTarget:self action:@selector(selectDeviceTouched:) forControlEvents:UIControlEventTouchUpInside];
            
            [_selectDeviceButtonScrollView addSubview:button];
        }
    }
    return _selectDeviceButtonScrollView;
}

/// 任务列表
- (UITableView *)taskView {
    
    if (!_taskView) {
        _taskView = [[UITableView alloc] init];
        _taskView.delegate = self;
        _taskView.dataSource = self;
        _taskView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _taskView.rowHeight = SHTabBarHeight;
        
        [_taskView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _taskView;
}

- (NSMutableArray *)tasks {
    if (!_tasks) {
        _tasks = [NSMutableArray array];
    }
    return _tasks;
}

@end

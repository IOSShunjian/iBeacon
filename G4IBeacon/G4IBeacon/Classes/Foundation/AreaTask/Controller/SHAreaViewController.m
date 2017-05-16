//
//  SHAreaViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/8.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

 
#import "SHEnterAreaViewController.h"
#import "SHExitAreaViewController.h"
#import "SHSettingViewController.h"
#import "SHAreaTaskTableViewCell.h"

@interface SHAreaViewController ()

/// 选择不同的设备列表
@property (strong, nonatomic) UIScrollView *selectDeviceButtonScrollView;

/// 设备列表名称
@property (strong, nonatomic) NSArray *selectNames;

/// 设备种类
@property (assign, nonatomic) NSUInteger deviceKindCount;


@end

@implementation SHAreaViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.selectDeviceButtonScrollView.frame  = CGRectMake(self.view.frame_width *  0.8, SHNavigationBarHeight,self.view.frame_width *  0.2, self.view.frame_height - SHNavigationBarHeight);
    
    for (NSUInteger i = 0; i < self.selectDeviceButtonScrollView.subviews.count; i++) {
        UIView *subView = self.selectDeviceButtonScrollView.subviews[i];
        
        if ([subView isKindOfClass:[UIButton class]]) {
            subView.frame = CGRectMake(0, subView.tag * SHTabBarHeight , self.selectDeviceButtonScrollView.frame_width, SHTabBarHeight);
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 保存数据
   [[SHSQLiteManager shareSHSQLiteManager] saveCurrentZonesButtons:self.iBeacon];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 刷新
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = SHGlobalBackgroundColor;
    
    [self initTableView];
    
    // 设置导航
    [self setUpNavigationBar];
    
    [self.view addSubview:self.selectDeviceButtonScrollView];
    self.selectDeviceButtonScrollView.hidden = YES;
    
    // 显示已经存在的任务
    self.iBeacon.allDeviceButtonInCurrentZone = [[SHSQLiteManager shareSHSQLiteManager] getButtonsFor:self.iBeacon isEnter:[self isKindOfClass:[SHEnterAreaViewController class]]];
}

- (void)initTableView {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = [SHAreaTaskTableViewCell cellRowHeight];
    
    self.tableView.backgroundColor = SHGlobalBackgroundColor;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHAreaTaskTableViewCell class]) bundle:nil] forCellReuseIdentifier: NSStringFromClass([SHAreaTaskTableViewCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 设置导航
- (void)setUpNavigationBar {
    
    self.navigationItem.title = [self isKindOfClass:[SHEnterAreaViewController class]] ? @"Enter Area" : @"Exit Area";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showDeviceSelectList)];
}

/// 显示选择列表
- (void)showDeviceSelectList {
    
    self.selectDeviceButtonScrollView.hidden = !self.selectDeviceButtonScrollView.hidden;
}

/// 按钮点击
- (void)selectDeviceTouched:(SHButton *)button {
    
    // 添加到所任务队列中去
    SHButton *deviceButton = [[SHButton alloc] init];
    deviceButton.buttonID = [[SHSQLiteManager shareSHSQLiteManager] getMaxButtonID] + 1;
    deviceButton.buttonKind = button.buttonKind;
    deviceButton.iBeaconID = self.iBeacon.iBeaconID;
    deviceButton.subNetID = 1; // 默认都是1
    
    // 当前的任务类型是进入还是离开(设置任务类型)
    deviceButton.isEnterAreaTask = [self isKindOfClass:[SHEnterAreaViewController class]];
    
    [self.iBeacon.allDeviceButtonInCurrentZone addObject:deviceButton];
    [self.tableView reloadData];
    
    // TODO: 保存到数据库中去
    [[SHSQLiteManager shareSHSQLiteManager] inserNewButton:deviceButton];
}


// MARK: - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.iBeacon.allDeviceButtonInCurrentZone.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SHAreaTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SHAreaTaskTableViewCell class]) forIndexPath:indexPath];
    
    // 获得按钮
    cell.deviceButton = self.iBeacon.allDeviceButtonInCurrentZone[indexPath.row];
    
    // cell添加一个长按手势
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(setDeviceArgs:)];
    
    longPressGestureRecognizer.minimumPressDuration = 1.0;
    
    [cell addGestureRecognizer:longPressGestureRecognizer];
    
    return cell;
}


- (void)setDeviceArgs:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    
    if (longPressGestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    SHSettingViewController *settingViewController = [[UIStoryboard storyboardWithName:NSStringFromClass([SHSettingViewController class]) bundle:nil] instantiateInitialViewController];
    
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    
    // 设置长按的按钮
    settingViewController.settingButton = self.iBeacon.allDeviceButtonInCurrentZone[indexPath.row];
    
    settingViewController.sourceViewController = self;
    
    [self.navigationController pushViewController:settingViewController animated:YES];
}

// MARK: - getter && setter

/// 选择设备列表框
- (UIScrollView *)selectDeviceButtonScrollView {
    
    self.deviceKindCount = 5;
    
    if (!_selectDeviceButtonScrollView) {
        
        _selectDeviceButtonScrollView = [[UIScrollView alloc] init];
        _selectDeviceButtonScrollView.showsVerticalScrollIndicator = YES;
        _selectDeviceButtonScrollView.pagingEnabled = YES;

        // 添加按钮
        _selectDeviceButtonScrollView.contentSize = CGSizeMake(0, self.deviceKindCount * SHTabBarHeight);
        
        for (NSUInteger i = 0; i < self.deviceKindCount; i++) {
            
            SHButton *button = [SHButton buttonWithType:UIButtonTypeCustom];
            
            button.backgroundColor = [UIColor orangeColor];
            
            button.tag = i;
   
        
            switch (i) {
                case 0:
                    button.buttonKind = ButtonKindLight;
                    break;
                    
                case 1:
                    button.buttonKind = ButtonKindAC;
                    break;
                    
                case 2:
                    button.buttonKind = ButtonKindMusic;
                    break;
                    
                case 3:
                    button.buttonKind = ButtonKindCurtain;
                    break;
                    
                case 4:
                    button.buttonKind = ButtonKindLed;
                    break;
                    
                default:
                    break;
            }
            
            [button setTitle:[SHButton buttonDefaultTitleFromKind:button] forState:UIControlStateNormal];
            
            // 点击显示出来
            [button addTarget:self action:@selector(selectDeviceTouched:) forControlEvents:UIControlEventTouchUpInside];
            
            [_selectDeviceButtonScrollView addSubview:button];
            
        }
    }
    return _selectDeviceButtonScrollView;
}

@end

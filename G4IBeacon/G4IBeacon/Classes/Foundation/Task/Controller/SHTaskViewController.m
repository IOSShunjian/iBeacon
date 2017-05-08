//
//  SHTaskViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHTaskViewController.h"
#import "SHTaskCollectionViewCell.h"
#import "SHSenceViewController.h"
#import "SHAddViewController.h"

@interface SHTaskViewController () <UICollectionViewDelegate, UICollectionViewDataSource>


/// 显示所有场景的视图
@property (nonatomic, strong) UICollectionView* listView;

/// 所有的iBeaon
@property (strong, nonatomic)NSMutableArray *alliBeacons;

@end

@implementation SHTaskViewController


// MARK: - UI

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Tasks";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏
    [self setUpNavigationBar];
    
    [self.view addSubview:self.listView];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // 显示出所有的列表
    self.alliBeacons = [[SHSQLiteManager shareSHSQLiteManager] searchiBeacons];
    
    [self.listView reloadData];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    self.listView.frame = self.view.bounds;
}

/// 设置导航栏
- (void)setUpNavigationBar {

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewiBeacon)];
}

- (void)addNewiBeacon {
    
    SHAddViewController *addViewController = [[SHAddViewController alloc] init];
    
    addViewController.iBeacon = [[SHIBeacon alloc] init];
    addViewController.iBeacon.iBeaonID = [[SHSQLiteManager shareSHSQLiteManager] getMaxiBeaconID] + 1;
    
    [self.navigationController pushViewController:addViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - 代理

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SHSenceViewController *senceViewController =
    [[UIStoryboard storyboardWithName:NSStringFromClass([SHSenceViewController class ]) bundle:nil] instantiateInitialViewController];
    
    // 传入模型
    senceViewController.iBeacon = self.alliBeacons[indexPath.row];
    
    [self.navigationController pushViewController:senceViewController animated:YES];
}

// MARK: - 数据库

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.alliBeacons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SHTaskCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SHTaskCollectionViewCell class]) forIndexPath:indexPath];
    
    // 获得区域模型
    cell.iBeacon = self.alliBeacons[indexPath.item];
    
    return cell;
}


// MARK: gettr && setter

/// 展示场景
- (UICollectionView *)listView {
    
    if (!_listView) {
        
        // 1.自定义流水布局
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        // 1.1 设置方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        // 1.2 计算每个item的大小
        CGFloat itemMarign = 1;
        
        // 总列数
        NSUInteger totalCols = 3;
        
        CGFloat itemWidth = (self.view.frame_width - (totalCols * itemMarign)) / totalCols;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        
        // 1.3 设置间距
        flowLayout.minimumLineSpacing = itemMarign;
        flowLayout.minimumInteritemSpacing = itemMarign;
        
        // 2.创建 (临时指定一个高度，宽度不需要指定)
        _listView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout] ;
        
        // 设置背景颜色
        _listView.backgroundColor = self.view.backgroundColor;
        
        // 注册cell
        [_listView registerNib:[UINib nibWithNibName:NSStringFromClass([SHTaskCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SHTaskCollectionViewCell class])];
        
        // 设置数据源和方法
        _listView.dataSource = self;
        _listView.delegate = self;
    }
    
    return _listView;
}


@end

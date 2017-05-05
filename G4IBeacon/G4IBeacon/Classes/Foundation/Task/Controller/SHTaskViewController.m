//
//  SHTaskViewController.m
//  G4IBeacon
//
//  Created by LHY on 2017/5/5.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHTaskViewController.h"
#import "SHTaskCollectionViewCell.h"

@interface SHTaskViewController () <UICollectionViewDelegate, UICollectionViewDataSource>


/// 显示所有场景的视图
@property (nonatomic, strong) UICollectionView* listView;

@end

@implementation SHTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Tasks";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.listView];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    self.listView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - 数据库

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SHTaskCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SHTaskCollectionViewCell class]) forIndexPath:indexPath];

    // 获得区域模型
//    cell.modelZone = self.allZones[indexPath.item];
    cell.backgroundColor = [UIColor orangeColor];
    
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
        _listView.backgroundColor = [UIColor redColor];
        
        // 注册cell
        [_listView registerNib:[UINib nibWithNibName:NSStringFromClass([SHTaskCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SHTaskCollectionViewCell class])];
        
        // 设置数据源和方法
        _listView.dataSource = self;
        _listView.delegate = self;
    }
    
    return _listView;
}


@end

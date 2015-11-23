//
//  CollectionViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "CollectionViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"

#import "WaterfallCollectionViewCell.h"
#import "WaterCollectionReusableView.h"
#import "FooterReusableView.h"

// 标识符
#define CELL_IDENTIFIER   @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface CollectionViewController ()<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView * collectionViews;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableArray * dataSourceSize;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据源
    _dataSource = [NSMutableArray new];
    // 存数据
    for (int i = 0; i <= 16; i++) {
        //[_dataSource addObject:<#(nonnull id)#>]
    }
    
    // 初始化布局
    CHTCollectionViewWaterfallLayout * layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    // 设置布局
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.headerHeight = 100; // headerView高度
    layout.footerHeight = 100; // footerView高度
    layout.columnCount = 3; // 几列显示
    layout.minimumColumnSpacing = 5;// cell之间的水平间距
    layout.minimumInteritemSpacing = 5; // cell之间的垂直间距
    
    //初始化collectionView
    _collectionViews = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionViews.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionViews.dataSource = self;
    _collectionViews.delegate = self;
    _collectionViews.backgroundColor = [UIColor whiteColor];
    
    // 注册cell及header， footer
    [_collectionViews registerClass:[WaterfallCollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    [_collectionViews registerClass:[WaterCollectionReusableView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:HEADER_IDENTIFIER];
    [_collectionViews registerClass:[FooterReusableView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:FOOTER_IDENTIFIER];
    // 添加到视图上
    [self.view addSubview:_collectionViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterfallCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    UIImage * image = _dataSource[indexPath.row];
    cell.showImageView.image = image;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * reusableview = nil;
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADER_IDENTIFIER forIndexPath:indexPath];
    }else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]){
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FOOTER_IDENTIFIER forIndexPath:indexPath];
    }
    return reusableview;
}

#pragma mark -- CHTCollectionViewDelegateWatefallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 返回每个cell的尺寸
    UIImage * image = _dataSource[indexPath.row];
    return image.size;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

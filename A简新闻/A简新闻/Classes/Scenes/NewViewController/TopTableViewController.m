//
//  TopTableViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "TopTableViewController.h"
#import "OneImgTableViewCell.h"
#import "MoreImgTableViewCell.h"
#import "DataParsing.h"
#import "ContentModel.h"
#import "DataWebViewController.h"
#import "ShufflingView.h"
#import "SDCycleScrollView.h"


@interface TopTableViewController ()

@property (nonatomic, strong) NSMutableArray * array;

// 轮播图数组
@property (nonatomic, strong) NSMutableArray * shuffArray;

@property (nonatomic, strong) ShufflingView * shuff;

@property (nonatomic, assign) int urlNumber;
// 上拉下啦
@property (nonatomic,assign) BOOL upOrDownData;
@property (nonatomic,assign) BOOL Data;

@property (nonatomic, strong) NSDate * stateDate;
@end

static NSString * identifier1 = @"oneCell";
static NSString * identifier2 = @"moreCell";
@implementation TopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlNumber = 10;
    self.tableView.backgroundColor = [UIColor cyanColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册
    [self.tableView registerClass:[OneImgTableViewCell class] forCellReuseIdentifier:identifier1];
    [self.tableView registerClass:[MoreImgTableViewCell class] forCellReuseIdentifier:identifier2];
    // 数据解析
    [self dataPatsEvent];
    // 上拉加载，下拉刷新
    [self updateEvent];
    [self downLoadEvent];
}

- (void)viewWillAppear:(BOOL)animated{
    self.stateDate = [NSDate date];
}
- (void)viewWillDisappear:(BOOL)animated{
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.stateDate];
    //if (time > 2 * 60) {
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"top1" object:nil userInfo:@{@"name":@"头条",@"time":[NSNumber numberWithDouble:time]}];
    //};
}

- (void)shufflingView{
    SDCycleScrollView * scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 150) imageURLStringsGroup:self.shuffArray];
    self.tableView.tableHeaderView = scrollView;
}


// 数据解析
- (void)dataPatsEvent{
    DataParsing * datas = [DataParsing new];
    if (self.upOrDownData) {
        if (self.urlNumber < 20) {
            self.urlNumber += 10;
        }
    }
    NSString * url = [NSString stringWithFormat:@"%@%d-%d.html",kTopURL,0,self.urlNumber];
    [datas doDataParsing:url];
    if (!self.upOrDownData) {
        [datas shufflingDataParsing:url];
    }
    
    __weak typeof(self) temp = self;
    datas.dataPars = ^(NSMutableArray * dataArray){
        temp.array = dataArray;
        [temp.tableView reloadData];
    };
    datas.imgData = ^(NSMutableArray * imgArray){
        // 轮播图
        self.shuffArray = imgArray;
        [self shufflingView];
        [temp.tableView reloadData];
    };
}

// 懒加载
- (NSMutableArray *)shuffArray{
    if (!_shuffArray) {
        _shuffArray = [NSMutableArray array];
    }
    return _shuffArray;
}


// 懒加载
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentModel * contModel = self.array[indexPath.row];
    if (contModel.imgsrc2.length == 0) {
        OneImgTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1 forIndexPath:indexPath];
        
        cell.content = contModel;
        return cell;
    } else {
        MoreImgTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier2 forIndexPath:indexPath];
        
        cell.content = contModel;
        return cell;
    }
}
// 设置每个cell的高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


// 点击每个cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DataWebViewController * dataWeb = [[DataWebViewController alloc] init];
    ContentModel * model = self.array[indexPath.row];
    dataWeb.url = model.url;
    [self.navigationController pushViewController:dataWeb animated:YES];
}


#pragma mark -- 下拉刷新，上拉加载

- (void)updateEvent{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateNewData:)];
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"正在拼命加载中 ..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)updateNewData:(MJRefreshNormalHeader *)sender{
    [self dataPatsEvent];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 停止刷新
        [sender endRefreshing];
        // 刷新view
        [self.tableView reloadData];
    });
}

- (void)downLoadEvent{
    __weak typeof(self) temp = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.upOrDownData = YES;
        [temp dataPatsEvent];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 停止刷新
            [temp.tableView.mj_footer endRefreshing];
            self.upOrDownData = NO;
            // 刷新view
            [temp.tableView reloadData];
        });
    }];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

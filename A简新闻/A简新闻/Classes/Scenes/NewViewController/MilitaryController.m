//
//  MilitaryController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "MilitaryController.h"
#import "OneImgTableViewCell.h"
#import "MoreImgTableViewCell.h"
#import "DataParsing.h"
#import "SDCycleScrollView.h"
#import "ContentModel.h"
#import "Userset+CoreDataProperties.h"

@interface MilitaryController ()
@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) int ste;
@property (nonatomic, assign) BOOL temp;
@property (nonatomic, strong) NSDate * stateDate;
@end

static NSString * identifier = @"cell";
static NSString * identifier1 = @"cell1";
@implementation MilitaryController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.tableView registerClass:[OneImgTableViewCell class] forCellReuseIdentifier:identifier];
    [self.tableView registerClass:[MoreImgTableViewCell class] forCellReuseIdentifier:identifier1];
    self.ste = 10;
    // 解析数据
    [self dataParsing];
    [self shuffingParsing];
    // 下拉刷新，上拉加载
    [self upDataEvent];
    [self downDataEvent];
}
- (void)viewWillAppear:(BOOL)animated{
    self.stateDate = [NSDate date];
}
- (void)viewWillDisappear:(BOOL)animated{
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.stateDate];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"top2" object:nil userInfo:@{@"name":@"军事",@"time":[NSNumber numberWithDouble:time]}];
}

// 下拉刷新，上拉加载
- (void)dataParsingEvent{
    if (self.temp) {
        // 加载
        self.ste += 10;
        [self dataParsing];
    } else {
        // 刷新
        [self dataParsing];
        [self shuffingParsing];
    }
}

- (void)dataParsing{
    DataParsing * datas = [DataParsing new];
    [datas doDataParsing:[NSString stringWithFormat:@"%@%d-%d.html",kMilitary,0,self.ste]];
    __weak typeof(self) temp = self;
    datas.dataPars = ^(NSMutableArray * array){
        temp.dataArray = array;
        [temp.tableView reloadData];
    };
}

- (void)shuffingParsing{
    DataParsing * datas = [DataParsing new];
    [datas shufflingDataParsing:[NSString stringWithFormat:@"%@%d-%d.html",kMilitary,0,self.ste]];
    __weak typeof(self) temp = self;
    datas.imgData = ^(NSMutableArray * array){
        [temp shuffingView:array];
        [temp.tableView reloadData];
    };
}

// 轮播图
- (void)shuffingView:(NSMutableArray *)sender{
    SDCycleScrollView * shuffing = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 150) imageURLStringsGroup:sender];
    self.tableView.tableHeaderView = shuffing;
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
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentModel * content = self.dataArray[indexPath.row];
    if (content.imgsrc2.length == 0) {
        OneImgTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.content = content;
        return cell;
    }else{
        MoreImgTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1 forIndexPath:indexPath];
        cell.content = content;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

#pragma mark -- 上拉加载,下拉刷新
- (void)upDataEvent{
   MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateNewData:)];
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"正在拼命加载中 ..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

- (void)updateNewData:(MJRefreshNormalHeader *)sender{
    [self dataParsingEvent];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 停止刷新
        [sender endRefreshing];
        // 刷新view
        [self.tableView reloadData];
    });
}

- (void)downDataEvent{
    self.temp = YES;
    __weak typeof(self) temp = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [temp dataParsingEvent];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [temp.tableView.mj_footer endRefreshing];
            [temp.tableView reloadData];
            temp.temp = NO;
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

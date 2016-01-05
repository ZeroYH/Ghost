//
//  LockTableViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "LockTableViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "MMDrawerController.h"
#import "RightViewController.h"
#import "VideoParsing.h"
#import "VideoCell.h"
#import "VideoPlayer.h"



@interface LockTableViewController ()<videoEndDelegate>

@property (nonatomic, strong) NSMutableArray * videoArray;
@property (nonatomic, strong) NSDate * stateDate;
// 计数器
@property (nonatomic, assign) BOOL temp;
@property (nonatomic, assign) bool videoUpOrDown;
//
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, assign) int ste;
@end

static NSString * identifier = @"cell";
@implementation LockTableViewController

- (void)leftEvent:(UIBarButtonItem *)sender{
    [self.mm_drawerController toggleDrawerSide:(MMDrawerSideLeft) animated:YES completion:nil];
    
}
- (void)backEvent:(UIBarButtonItem *)sender{
    [self.mm_drawerController toggleDrawerSide:(MMDrawerSideRight) animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showView];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    self.ste = 10;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"逛街" style:(UIBarButtonItemStylePlain) target:self action:@selector(backEvent:)];
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellReuseIdentifier:identifier];
    [self videoParsingEvent];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.indexPath = [NSIndexPath indexPathWithIndex:-1];
    // 刷新 加载
    [self upDataVideo];
    [self downDataVideo];
}
- (void)viewWillAppear:(BOOL)animated{
    self.stateDate = [NSDate date];
}
- (void)viewWillDisappear:(BOOL)animated{
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.stateDate];
    //if (time > 2 * 60) {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"top6" object:nil userInfo:@{@"name":@"看看",@"time":[NSNumber numberWithDouble:time]}];
    //};
}
// 解析数据
- (void)videoParsingEvent{
    VideoParsing * videoPars = [VideoParsing new];
    if (_videoUpOrDown) {
        self.ste += 10;
    }
    [videoPars doVideoParsing:[NSString stringWithFormat:@"%@%d-%d.html", kVideo, 0, self.ste]];
    __weak typeof(self) temp = self;
    videoPars.arrayBlock = ^(NSMutableArray * array){
        temp.videoArray = array;
        [self.tableView reloadData];
    };
}

- (void)showView{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu@2x.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftEvent:)];
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
    return self.videoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //停止播放
   [[VideoPlayer videoPlayer] pauseForVideo];
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    VideoModel * model = self.videoArray[indexPath.row];
    cell.video = model;
//    cell.ste = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self.indexPath isEqual:indexPath]) {
//        [[VideoPlayer videoPlayer] pauseForVideo];
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//        VideoModel * model = self.videoArray[indexPath.row];
//        VideoCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//        // 播放
//        [[VideoPlayer videoPlayer] showVideoPlayer:model.mp4_url andFrame:cell.backView.bounds andView:cell.backView];
//        [VideoPlayer videoPlayer].delegate = self;
//        self.indexPath = indexPath;
    //TODO: BUG ~~~~~~~~~~~~~~~~~~
    if ([VideoPlayer videoPlayer].temp) {
        [[VideoPlayer videoPlayer] pauseForVideo];
    }
    
}

- (void)doSomeThingsWhenVideoEnd{
     [[VideoPlayer videoPlayer] pauseForVideo];
}

#pragma mark -- 上拉加载，下拉刷新
- (void)upDataVideo{
    __weak typeof(self) temp = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [temp videoParsingEvent];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [temp.tableView.mj_header endRefreshing];
            [temp.tableView reloadData];
        });
    }];
    [self.tableView.mj_header beginRefreshing];
}


- (void)downDataVideo{
    self.videoUpOrDown = YES;
    __weak typeof(self) temp = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [temp videoParsingEvent];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [temp.tableView.mj_footer endRefreshing];
            [temp.tableView reloadData];
            self.videoUpOrDown = NO;
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

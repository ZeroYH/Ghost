//
//  RightViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "RightViewController.h"
#import "NewsTabBarController.h"
#import "RightTableViewCell.h"
#import "RightParsing.h"
#import "WebRightViewController.h"
#import "MMDCViewController.h"

@interface RightViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *table4View;
- (IBAction)btn:(UIButton *)sender;
@property (strong, nonatomic) NSMutableArray * array;
@end
static NSString * identifier = @"cellReuse";
@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 注册
    [self.table4View registerNib:[UINib nibWithNibName:@"RightTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    self.table4View.showsVerticalScrollIndicator = NO;
    self.table4View.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table4View.delegate = self;
    self.table4View.dataSource = self;
    self.table4View.bounces = NO;
    [self dataParsing];
}


- (void)dataParsing{
    RightParsing * datas = [RightParsing new];
    [datas doRightParsing:kFind];
    datas.arrayBlock = ^(NSMutableArray * array){
        self.array = array;
        [self.table4View reloadData];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    RightModel * model = self.array[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebRightViewController * web = [[WebRightViewController alloc] init];
     RightModel * model = self.array[indexPath.row];
    web.url = model.url;
    UINavigationController * nac = [[UINavigationController alloc] initWithRootViewController:web];
    [self presentViewController:nac animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn:(UIButton *)sender {
    MMDCViewController * tab = [[MMDCViewController alloc] init];
    [self presentViewController:tab animated:YES completion:nil];
    
}
@end

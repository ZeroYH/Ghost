//
//  HostViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "HostViewController.h"
#import "TopTableViewController.h"

#import "LeftViewController.h"
#import "MMDrawerBarButtonItem.h"
#import <UIViewController+MMDrawerController.h>
#import "MilitaryController.h"
#import "SportsController.h"
#import "FashionController.h"
#import "GameController.h"

@interface HostViewController ()<ViewPagerDelegate,ViewPagerDataSource>

@property (nonatomic, strong) NSArray * array;

@property (nonatomic, strong) NSArray * arrayController;

@end

@implementation HostViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (IBAction)leftBarAction:(UIBarButtonItem *)sender {
    // 开关左抽屉
    //[self.mm_drawerController openDrawerSide:(MMDrawerSideLeft) animated:YES completion:nil];
    [self.mm_drawerController toggleDrawerSide:(MMDrawerSideLeft) animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TopTableViewController * top1 = [[TopTableViewController alloc] init];
    MilitaryController * top2 = [[MilitaryController alloc] init];
    SportsController * top3 = [[SportsController alloc] init];
    FashionController * top4 = [[FashionController alloc] init];
    GameController * top5 = [[GameController alloc] init];
    self.dataSource = self;
    self.delegate = self;
    self.array = @[@"头条",@"军事",@"体育",@"时尚",@"游戏"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻" image:[UIImage imageNamed:@"cinema"] tag:1001];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:13 weight:15]} forState:(UIControlStateNormal)];
    
    self.arrayController = @[top1, top2, top3, top4, top5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.array.count;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15.0];
    label.text = [NSString stringWithFormat:@"%@", self.array[index]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    return self.arrayController[index];
    
    //return self.arrayController[index];
}

#pragma mark - ViewPagerDelegate
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  MMDCViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "MMDCViewController.h"
#import "NewsTabBarController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface MMDCViewController ()

@end

@implementation MMDCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置MMDC 右划时的距离
    self.maximumLeftDrawerWidth = [UIScreen mainScreen].bounds.size.width - 120;
    
    // 添加视图
    NewsTabBarController * newsTBC = [[NewsTabBarController alloc] init];
    LeftViewController * leftVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"left"];
    //RightViewController * right = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RightView"];
    
    self.centerViewController = newsTBC;
    self.leftDrawerViewController = leftVC;
    //self.rightDrawerViewController = right;
    
    // 添加手势
    [self setOpenDrawerGestureModeMask:(MMOpenDrawerGestureModeAll)];
    [self setCloseDrawerGestureModeMask:(MMCloseDrawerGestureModeAll)];
    
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

@end

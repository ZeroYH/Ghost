//
//  WebRightViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "WebRightViewController.h"

@interface WebRightViewController ()<UIWebViewDelegate>
// webView
@property (nonatomic, strong) UIWebView * webView;
@end

@implementation WebRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建webView
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -54, self.view.bounds.size.width, self.view.bounds.size.height + 54)];
    self.webView.scrollView.bounces = NO;
    // 内容填充
    _webView.scalesPageToFit = YES;
    // 添加代理
    _webView.delegate = self;
    // 添加到视图上
    [self.view addSubview:_webView];
    
    // 创建请求
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    // 请求链接
    [self.webView loadRequest:request];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back@2x.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(backEvent:)];
}
- (void)backEvent:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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

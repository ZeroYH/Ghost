//
//  DataWebViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "DataWebViewController.h"

@interface DataWebViewController ()<UIWebViewDelegate>

// webView
@property (nonatomic, strong) UIWebView * webView;

@end

@implementation DataWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
}
#pragma mark -- UIWebViewDelegate
//// 开始加载
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    // 加载是的黑色背景
//    UIView * backView = [[UIView alloc] initWithFrame:self.view.frame];
//    backView.backgroundColor = [UIColor blackColor];
//    backView.alpha = 0.6;
//    backView.tag = 1001;
//    [self.view addSubview:backView];
//}
//// 加载结束
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    // 加载完成后删除背景
//    UIView * views = [self.view viewWithTag:1001];
//    [views removeFromSuperview];
//}


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

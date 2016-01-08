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

@property (nonatomic, strong) UIActivityIndicatorView * activityView;

@property (nonatomic, strong) UIView * backView;
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
    
    self.backView = [[UIView alloc] initWithFrame:self.view.frame];
    _backView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_backView];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _activityView.center = self.view.center;
    _activityView.color = [UIColor redColor];
    [self.view addSubview:_activityView];
    
}
#pragma mark -- UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityView  startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    
    NSArray *array = @[@"a_topad js-topad", @"article_source js-source", @"more_client more-client", @"h5share_panel", @"a_topad js-tbad", @"article_comment", @"article_ad", @"content-list",@"list-more", @"feed_back"];
    for (int i = 0; i < array.count; i++) {
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('%@')[0].style.display = 'none'", array[i]]];
    }
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('footer')[0].style.display = 'none'"];
    
    
    [self.activityView  stopAnimating];
    [self.activityView hidesWhenStopped];
    [self.backView removeFromSuperview];
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

//
//  FocusViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "FocusViewController.h"
#import "UIColor+RandomColor.h"
@interface FocusViewController ()

@property (nonatomic, strong) UIView * view1;
@property (nonatomic, strong) UILabel *labe1;

@property (nonatomic, strong) UIView * view2;
@property (nonatomic, strong) UILabel *labe2;

@property (nonatomic, strong) UIView * view3;
@property (nonatomic, strong) UILabel *labe3;

@property (nonatomic, strong) UIView * view4;
@property (nonatomic, strong) UILabel *labe4;

@property (nonatomic, strong) UIView * view5;
@property (nonatomic, strong) UILabel *labe5;

@property (nonatomic, strong) UIView * view6;
@property (nonatomic, strong) UILabel *labe6;

@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign) BOOL temp;
@end

@implementation FocusViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.title = @"上次的页面统计";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(backLeftEvent:)];
    }
    return self;
}
// 返回
- (void)backLeftEvent:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self showView];
}
// 展示视图
- (void)showView{
    // 头条
    self.view1 = [[UIView alloc] init];
    _view1.center = CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
    _view1.bounds = CGRectMake(0, 0, 60, 60);
    _view1.alpha = 0;
    self.labe1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    _labe1.numberOfLines = 0;
    _labe1.font = [UIFont systemFontOfSize:12];
    _labe1.textAlignment = NSTextAlignmentCenter;
    [self.view1 addSubview:_labe1];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameEvent:) name:@"top1" object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"top1" object:nil];
    [self.view addSubview:_view1];
    ///*///
    // 军事
    self.view2 = [[UIView alloc] init];
    _view2.center = CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
    _view2.bounds = CGRectMake(0, 0, 60, 60);
    self.labe2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _view2.alpha = 0;
    _labe2.numberOfLines = 0;
    _labe2.textAlignment = NSTextAlignmentCenter;
    _labe2.font = [UIFont systemFontOfSize:10];
    [self.view2 addSubview:_labe2];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameEvent:) name:@"top2" object:nil];
   // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"top2" object:nil];
    [self.view addSubview:_view2];
    // 体育
    self.view3 = [[UIView alloc] init];
    _view3.center = CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
    _view3.bounds = CGRectMake(0, 0, 60, 60);
    self.labe3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    _view3.alpha = 0;
    _labe3.textAlignment = NSTextAlignmentCenter;
    _labe3.numberOfLines = 0;
    _labe3.font = [UIFont systemFontOfSize:12];
    [self.view3 addSubview:_labe3];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameEvent:) name:@"top3" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"top3" object:nil];
    [self.view addSubview:_view3];
    // 时尚
    self.view4 = [[UIView alloc] init];
    _view4.center = CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
    _view4.bounds = CGRectMake(0, 0, 60, 60);
    _labe4.textAlignment = NSTextAlignmentCenter;
    self.labe4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _view4.alpha = 0;
    _labe4.numberOfLines = 0;
    _labe4.font = [UIFont systemFontOfSize:12];
    [self.view4 addSubview:_labe4];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameEvent:) name:@"top4" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"top4" object:nil];
    [self.view addSubview:_view4];
    // 游戏
    self.view5 = [[UIView alloc] init];
    _view5.center = CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
    _view5.bounds = CGRectMake(0, 0, 60, 60);
    self.labe5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _view5.alpha = 0;
    _labe5.textAlignment = NSTextAlignmentCenter;
    _labe5.numberOfLines = 0;
    _labe5.font = [UIFont systemFontOfSize:9];
    [self.view5 addSubview:_labe5];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameEvent:) name:@"top5" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"top5" object:nil];
    [self.view addSubview:_view5];
   // */
    
    // 视频
    self.view6 = [[UIView alloc] init];
    _view6.center = CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
    _view6.bounds = CGRectMake(0, 0, 60, 60);
    self.labe6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _view6.alpha = 0;
    _labe6.numberOfLines = 0;
    _labe6.textAlignment = NSTextAlignmentCenter;
    _labe6.font = [UIFont systemFontOfSize:9];
    [self.view6 addSubview:_labe6];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameEvent:) name:@"top6" object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"top5" object:nil];
    [self.view addSubview:_view6];
    
    // btn
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.center = CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
    _btn.bounds = CGRectMake(0, 0, 60, 60);
    [_btn setBackgroundImage:[UIImage imageNamed:@"iconfont-tabbaraddgroupbtn.png"] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(actionEvent:) forControlEvents:UIControlEventTouchUpInside];
    _btn.showsTouchWhenHighlighted = YES;
    [self.view addSubview:_btn];
    
    //timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeEvent:) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)nameEvent:(NSNotification *)sender{
 NSNumber * nu = sender.userInfo[@"time"];
    double time = [nu doubleValue];
    int fen = (int)time / 60;
    int miao = (int)time % 60;
//    self.labe1.text = sender.userInfo[@"name"];
//    NSLog(@"%@",sender.userInfo[@"name"]);
    if ([sender.userInfo[@"name"] isEqualToString:@"头条"]) {
        self.labe1.text = [NSString stringWithFormat:@"<%@>停留:%d分:%d秒",sender.userInfo[@"name"],fen,miao];
    }else if ([sender.userInfo[@"name"] isEqualToString:@"军事"]){
        self.labe2.text = [NSString stringWithFormat:@"<%@>停留:%d分:%d秒",sender.userInfo[@"name"],fen,miao];
    }else if ([sender.userInfo[@"name"] isEqualToString:@"体育"]){
        self.labe3.text = [NSString stringWithFormat:@"<%@>停留:%d分:%d秒",sender.userInfo[@"name"],fen,miao];
    }else if ([sender.userInfo[@"name"] isEqualToString:@"时尚"]){
        self.labe4.text = [NSString stringWithFormat:@"<%@>停留:%d分:%d秒",sender.userInfo[@"name"],fen,miao];
    }else if ([sender.userInfo[@"name"] isEqualToString:@"游戏"]){
        self.labe5.text = [NSString stringWithFormat:@"<%@停留:%d分:%d秒",sender.userInfo[@"name"],fen,miao];
    }else if ([sender.userInfo[@"name"] isEqualToString:@"看看"]){
        self.labe6.text = [NSString stringWithFormat:@"<%@停留:%d分:%d秒",sender.userInfo[@"name"],fen,miao];
    }
}

- (void)timeEvent:(NSTimer *)sender{
    self.btn.transform = CGAffineTransformRotate(self.btn.transform, M_PI/100);
}
// 动画
- (void)actionEvent:(UIButton *)sender{
    if (!_temp) {
        
        [UIView beginAnimations:@"view1" context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
      
        self.view1.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2 - 100, [UIScreen mainScreen].bounds.size.height / 2 + 170);
        self.view1.bounds = CGRectMake(0, 0, 80, 80);
        self.view1.alpha = 0.8;
        self.view1.backgroundColor = [UIColor randomColor];
        self.view1.layer.masksToBounds = YES;
        self.view1.layer.cornerRadius = 5;
        
        self.view2.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2 - 100, [UIScreen mainScreen].bounds.size.height / 2 - 110);
        self.view2.bounds = CGRectMake(0, 0, 55, 55);
        self.view2.alpha = 0.8;
        self.view2.backgroundColor = [UIColor randomColor];
        self.view2.layer.masksToBounds = YES;
        self.view2.layer.cornerRadius = 5;
        
        self.view3.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2 + 100, [UIScreen mainScreen].bounds.size.height / 2 + 120);
        self.view3.bounds = CGRectMake(0, 0, 90, 90);
        self.view3.alpha = 0.8;
        self.view3.backgroundColor = [UIColor randomColor];
        self.view3.layer.masksToBounds = YES;
        self.view3.layer.cornerRadius = 5;
        
        self.view4.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2 + 100, [UIScreen mainScreen].bounds.size.height / 2 - 140);
        self.view4.bounds = CGRectMake(0, 0, 65, 65);
        self.view4.alpha = 0.8;
        self.view4.backgroundColor = [UIColor randomColor];
        self.view4.layer.masksToBounds = YES;
        self.view4.layer.cornerRadius = 5;
        
        self.view5.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2 + 80);
        self.view5.bounds = CGRectMake(0, 0, 45, 45);
        self.view5.alpha = 0.8;
        self.view5.backgroundColor = [UIColor randomColor];
        self.view5.layer.masksToBounds = YES;
        self.view5.layer.cornerRadius = 5;
        
        
        self.view6.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2 - 80);
        self.view6.bounds = CGRectMake(0, 0, 45, 45);
        self.view6.alpha = 0.8;
        self.view6.backgroundColor = [UIColor randomColor];
        self.view6.layer.masksToBounds = YES;
        self.view6.layer.cornerRadius = 5;
        
        [UIView commitAnimations];
        self.temp = YES;
    } else {
        [UIView beginAnimations:@"view1" context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view1.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
        self.view1.alpha = 0;
        self.view2.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
        self.view2.alpha = 0;
        self.view3.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
        self.view3.alpha = 0;
        self.view4.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
        self.view4.alpha = 0;
        self.view5.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
        self.view5.alpha = 0;
        self.view6.center =  CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
        self.view6.alpha = 0;
        [UIView commitAnimations];
        self.temp = NO;
    }
    
    
    
//    CABasicAnimation * basic = [CABasicAnimation animationWithKeyPath:@"frame"];
//    
//    CGRect fromRect = CGRectMake(100, 100, 100, 100);
//    CGRect toRect = CGRectMake(100, 400, 100, 50);
//    
//    basic.fromValue = [NSValue valueWithCGRect:fromRect];
//    basic.toValue = [NSValue valueWithCGRect:toRect];
//    
//    CGRect newRect = self.view2.layer.frame;
//    newRect = toRect;
//    // _myView.layer.frame = newRect;
//    [ self.view2.layer addAnimation:basic forKey:@"frame"];

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

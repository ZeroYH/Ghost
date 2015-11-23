//
//  LoginViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisViewController.h"
#import "emptyEvent.h"

@interface LoginViewController ()<emptyDelegate>
// 模态返回
- (IBAction)actionDims:(UIButton *)sender;
// 注册
- (IBAction)action4Reg:(UIButton *)sender;
// 用户名
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
// 密码
@property (strong, nonatomic) IBOutlet UITextField *passTF;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back@2x.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]style:(UIBarButtonItemStylePlain) target:self action:@selector(backEvent:)];
}


- (void)backEvent:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 取消键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
#pragma mark -- 提示窗 代理
- (void)viewDoThings:(UIAlertController *)sender{
    [self presentViewController:sender animated:YES completion:nil];
}

// 模态返回
- (IBAction)actionDims:(UIButton *)sender {
    // 非空判断
    if (self.nameTF.text.length == 0 || self.passTF.text.length == 0) {
        // 弹窗类
        emptyEvent * empty = [emptyEvent new];
        empty.delegate = self;
        [empty emptyEvent:@"提示" andMessage:@"不能为空"];
        
    } else {
        // 返回
        [AVUser logInWithUsernameInBackground:self.nameTF.text password:self.passTF.text block:^(AVUser *user, NSError *error) {
            if (user != nil) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账户或密码错误" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
        
    }
}

// 注册
- (IBAction)action4Reg:(UIButton *)sender {
    RegisViewController * regVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"regis"];
    [self.navigationController pushViewController:regVC animated:YES];
}
@end

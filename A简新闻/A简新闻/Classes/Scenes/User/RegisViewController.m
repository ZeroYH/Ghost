//
//  RegisViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "RegisViewController.h"
#import "emptyEvent.h"
#import <AVOSCloud/AVOSCloud.h>

@interface RegisViewController ()<emptyDelegate>

// 成功返回
- (IBAction)action4Ok:(UIButton *)sender;
// name
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
// pass
@property (strong, nonatomic) IBOutlet UITextField *passTF;
// email
@property (strong, nonatomic) IBOutlet UITextField *emilTF;
// 暂未使用到
@property (strong, nonatomic) IBOutlet UIView *backGroundView;

//
@property (nonatomic, assign) BOOL temp;

@end

@implementation RegisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 隐藏navigationItem的back键
    //self.navigationItem.hidesBackButton = YES;
    
}




- (void)assignment{
    AVUser * user = [AVUser user];
    user.username = self.nameTF.text;
    user.password = self.passTF.text;
    user.email = self.emilTF.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"1");
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"哈哈" message:@"成功啦~~" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            
        } else {
            NSLog(@"%@", error);
            self.temp = YES;
            // 注册失败，弹窗提示
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败,个性名称重复或邮箱错误" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
// 成功后直接返回主页
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.title isEqualToString:@"哈哈"] && buttonIndex == 0) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 取消键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

// 注册
- (IBAction)action4Ok:(UIButton *)sender {
    
//    if (self.nameTF.text.length == 0 || self.passTF.text.length == 0 || self.emilTF.text.length == 0) {
//        // 弹窗类
//        emptyEvent * empty = [emptyEvent new];
//        empty.delegate = self;
//        [empty emptyEvent:@"提示" andMessage:@"不能为空"];
//        
//    } else {
        [self assignment];
   // }
    
    
}
@end

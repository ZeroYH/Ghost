//
//  LeftViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "LeftViewController.h"
#import "LoginViewController.h"
#import "FocusViewController.h"
#import "CollectionTableViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "PerViewController.h"
#import "UploadPictuers.h"
#import "AppDelegate.h"
#import "Userset.h"
#import "Fmdata.h"

@interface LeftViewController ()
@property (strong, nonatomic) IBOutlet UIButton *logBtn;

@property (strong, nonatomic) IBOutlet UIButton *canBtn;

@property (strong, nonatomic) IBOutlet UIImageView *head4Img;

@property (nonatomic, strong) UploadPictuers * upload;
// 跳转到登入页面
- (IBAction)action4Login:(UIButton *)sender;
//
- (IBAction)action4Focus:(UIButton *)sender;
// 
- (IBAction)action4Collection:(UIButton *)sender;
// 注销
- (IBAction)cancelAction:(UIButton *)sender;
// 个性
- (IBAction)action4Per:(UIButton *)sender;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    // 判断用户登入状态
    AVUser * currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        self.logBtn.hidden = YES;
        self.canBtn.hidden = NO;
        self.head4Img.layer.masksToBounds = YES;
        self.head4Img.layer.cornerRadius = 5;
        // 显示头像
        AVUser * user = [AVUser currentUser];
        if ([[Fmdata fmdata] selectColorAndImgDataBase:user.username] == nil) {
            self.head4Img.image = [UIImage imageNamed:@"headImg.png"];
        }
        self.head4Img.image = [[Fmdata fmdata] selectColorAndImgDataBase:user.username];
    }else{
        self.head4Img.image = [UIImage imageNamed:@"headImg.png"];
        self.canBtn.hidden = YES;
    }
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

// 跳转到登入页面
- (IBAction)action4Login:(UIButton *)sender {
    LoginViewController * logVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:logVC];
    [self presentViewController:nav animated:YES completion:nil];
}
//
- (IBAction)action4Focus:(UIButton *)sender {
        
        FocusViewController * focusVC = [[FocusViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:focusVC];
        [self presentViewController:nav animated:YES completion:nil];
    
}
// 清除缓存
- (IBAction)action4Collection:(UIButton *)sender {
    // 计算大小
    NSInteger size = [[SDImageCache sharedImageCache] getSize];
    NSString * ste = [NSString stringWithFormat:@"清除缓存:%ldKB",size/1024/1024];
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"提示" message:ste preferredStyle:(UIAlertControllerStyleAlert)];
//    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
    __weak typeof(self) temp = self;
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [temp clearCache:cachPath];
        });
    }];
    [alter addAction:action];
    [self presentViewController:alter animated:YES completion:nil];
    // 清除缓存
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
//    cleanDisk直接清除 与 clearDisk 清除在创建一个文件
}
-(void)clearCache:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDisk];
    
}
// 注销事件
- (IBAction)cancelAction:(UIButton *)sender {
    [AVUser logOut];  //清除缓存用户对象
    self.canBtn.hidden = YES;
    [self.mm_drawerController toggleDrawerSide:(MMDrawerSideLeft) animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.logBtn.hidden = NO;
    });
}
// 个性
- (IBAction)action4Per:(UIButton *)sender {
    AVUser * currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        
        PerViewController * per = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"perViewController"];
        per.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:per animated:YES completion:nil];
    } else {
        [self action4Login:nil];
    }
}

@end

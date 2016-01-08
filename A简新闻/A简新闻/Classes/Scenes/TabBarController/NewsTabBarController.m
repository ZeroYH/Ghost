//
//  NewsTabBarController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "NewsTabBarController.h"
#import "HostViewController.h"
#import "LockTableViewController.h"

#import "MMDCViewController.h"
#import "LockMMDViewController.h"
#import "AppDelegate.h"
#import "Userset.h"

@interface NewsTabBarController ()

@property (nonatomic, strong) UINavigationController * newsNC ;

@end

@implementation NewsTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
//
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.barStyle = UIBarStyleBlackOpaque;
    self.tabBar.tintColor = [UIColor blackColor];
    
   
    
    //新闻项
    HostViewController * newsVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HostView"];
    UINavigationController * newsNC = [[UINavigationController alloc] initWithRootViewController:newsVC];
    newsNC.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.newsNC = newsNC;
    // 阅读
    LockMMDViewController * LockVC = [[LockMMDViewController alloc] init];
    // 添加到TabBarController上
    self.viewControllers = @[newsNC,LockVC];
    //
    AVUser * user = [AVUser currentUser];
    if (user != nil) {
        AppDelegate * myDelegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext * context = myDelegate.managedObjectContext;
        
        NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:@"Userset"];
        
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"user = %@",user.username];
        [fetch setPredicate:predicate];
        
        NSArray * array = [context executeFetchRequest:fetch error:nil];
        //NSLog(@"%@",array[0]);
        
        if (array.count != 0) {
            Userset *userSet = [array lastObject];
            NSNumber *red = userSet.red;
            NSNumber *green = userSet.green;
            NSNumber *blue = userSet.blue;
            NSNumber *alpha = userSet.alpha;
            self.tabBar.barTintColor = [UIColor colorWithRed:[red floatValue] green:[green floatValue] blue:[blue floatValue] alpha:[alpha floatValue]];
            self.newsNC.navigationBar.barTintColor = [UIColor colorWithRed:[red floatValue] green:[green floatValue] blue:[blue floatValue] alpha:[alpha floatValue]];
    
        }
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"changeColor" object:nil];
}
// 消息
- (void)changeColor:(NSNotification *)sender{
    self.newsNC.navigationBar.barTintColor = sender.userInfo[@"color"];
    self.tabBar.barTintColor = sender.userInfo[@"color"];
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

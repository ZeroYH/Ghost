//
//  LockMMDViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "LockMMDViewController.h"
#import "RightViewController.h"
#import "LockTableViewController.h"
#import "AppDelegate.h"
#import "Userset.h"

@interface LockMMDViewController ()

@property (nonatomic, strong) UINavigationController * LockNC;
@end

@implementation LockMMDViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"看看" image:[UIImage imageNamed:@"cinema"] tag:1002];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置滑动的距离
    self.maximumRightDrawerWidth = [UIScreen mainScreen].bounds.size.width - 120;
    
    // 找到 右视图 与 主视图
    RightViewController * right = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RightView"];
    LockTableViewController * lockTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LockTable"];
    
    // 添加navigation
     self.LockNC = [[UINavigationController alloc] initWithRootViewController:lockTVC];
    self.LockNC.navigationBar.barTintColor = [UIColor redColor];
    // 添加 主视图与右视图
    self.centerViewController = _LockNC;
    self.rightDrawerViewController = right;
    
    // 添加手势
    [self setOpenDrawerGestureModeMask:(MMOpenDrawerGestureModeAll)];
    [self setCloseDrawerGestureModeMask:(MMCloseDrawerGestureModeAll)];
    
    // 当点击 “看看” tabBar时隐藏掉低栏
    self.tabBarController.tabBar.layer.hidden = YES;
    [self colorChange];
}
- (void)colorChange{
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
          self.LockNC.navigationBar.barTintColor = [UIColor colorWithRed:[red floatValue] green:[green floatValue] blue:[blue floatValue] alpha:[alpha floatValue]];
        }
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"changeColor" object:nil];
}

// 消息
- (void)changeColor:(NSNotification *)sender{
   self.LockNC.navigationBar.barTintColor = sender.userInfo[@"color"];
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

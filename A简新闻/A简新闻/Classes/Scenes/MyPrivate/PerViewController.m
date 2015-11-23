//
//  PerViewController.m
//  A简新闻
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "PerViewController.h"
#import "AppDelegate.h"
#import "Userset.h"
#import "Fmdata.h"
#import "UploadPictuers.h"

@interface PerViewController ()<UploadDelegate>
// slide
@property (strong, nonatomic) IBOutlet UISlider *slide4R;
@property (strong, nonatomic) IBOutlet UISlider *slide4G;
@property (strong, nonatomic) IBOutlet UISlider *slide4B;
@property (strong, nonatomic) IBOutlet UISlider *slide4A;
//
@property (strong, nonatomic) IBOutlet UIButton *changeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *head4Img;

// 展示
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) UploadPictuers * upload;
@property (strong, nonatomic) UIColor * color;
@property (nonatomic, assign) BOOL temp;

@end

@implementation PerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.temp = YES;
    self.head4Img.userInteractionEnabled = YES;
    self.head4Img.layer.masksToBounds = YES;
    self.head4Img.layer.cornerRadius = 5;
    [self changeEnabled:NO];
    [self slideAddEvent];
    // 头像添加手势
    [self addGestureRecognizer];
    [self showImage];
}
// 头像
- (void)addGestureRecognizer{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadPictuers:)];
    [self.head4Img addGestureRecognizer:tap];
}
// 上传头像
- (void)uploadPictuers:(UITapGestureRecognizer *)sender{
    self.upload = [UploadPictuers new];
    [_upload imagePicker];
    _upload.delegate = self;
    [_upload showImagePicker];
    UIImage * img = [self.upload imagePickerUploadPictuers];
    self.head4Img.image = img;
    __weak typeof(self) temp = self;
    self.upload.block = ^(UIImage * img){
        [temp saveImage:img];
        temp.head4Img.image = img;
    };
}
- (void)showImagePicker:(UIImagePickerController *)imagePickerController{
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
// 图片存入本地
- (void)saveImage:(UIImage *)img{
    AVUser * user = [AVUser currentUser];
    if ([[Fmdata fmdata] selectColorAndImgDataBase:user.username] == nil) {
        [[Fmdata fmdata] addImgDataBase:user.username img:img];
    } else {
        [[Fmdata fmdata] updateColorAndImgDataBase:user.username andImg:img];
    }
    
}
// 取出图片
- (void)showImage{
    AVUser * user = [AVUser currentUser];
    if ([[Fmdata fmdata] selectColorAndImgDataBase:user.username] == nil) {
        self.head4Img.image = [UIImage imageNamed:@"headImg.png"];
    }
    self.head4Img.image = [[Fmdata fmdata] selectColorAndImgDataBase:user.username];
}





// 改变slide的enable
- (void)changeEnabled:(BOOL)sender{
    if (sender) {
        self.slide4R.enabled = YES;
        self.slide4G.enabled = YES;
        self.slide4B.enabled = YES;
        self.slide4A.enabled = YES;
    } else {
        self.slide4R.enabled = NO;
        self.slide4G.enabled = NO;
        self.slide4B.enabled = NO;
        self.slide4A.enabled = NO;
    }
}

// 给slide添加事件
- (void)slideAddEvent{
    [self.changeBtn addTarget:self action:@selector(changeEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.slide4R addTarget:self action:@selector(changeColorEvent:) forControlEvents:UIControlEventValueChanged];
    [self.slide4G addTarget:self action:@selector(changeColorEvent:) forControlEvents:UIControlEventValueChanged];
    [self.slide4B addTarget:self action:@selector(changeColorEvent:) forControlEvents:UIControlEventValueChanged];
    [self.slide4A addTarget:self action:@selector(changeColorEvent:) forControlEvents:UIControlEventValueChanged];
}

// 修改、保存Color
- (void)changeEvent:(UIButton *)sender{
    
    
    if (self.temp) {
        [self changeEnabled:YES];
        [self.changeBtn setTitle:@"保存修改" forState:UIControlStateNormal];
        self.temp = NO;
    }else {
        // 存储color
        self.color = [UIColor colorWithRed:self.slide4R.value green:self.slide4G.value blue:self.slide4B.value alpha:self.slide4A.value];
        //改变slide的enabled
        [self changeEnabled:NO];
        // 发送消息
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:nil userInfo:@{@"color":self.color}];
        if (self.color) {
            AVUser * us = [AVUser currentUser];
            // 保存个人设置
            AppDelegate * conte = [UIApplication sharedApplication].delegate;
            NSManagedObjectContext * context = conte.managedObjectContext;
            NSEntityDescription * entity = [NSEntityDescription entityForName:@"Userset" inManagedObjectContext:context];
            Userset * user = [[Userset alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            user.red = @(self.slide4R.value);
            user.green = @(self.slide4G.value);
            user.blue = @(self.slide4B.value);
            user.alpha = @(self.slide4A.value);
            //UIImage * image = [UIImage imageNamed:@"headImg.png"];
            //user.img = UIImagePNGRepresentation(image);
            user.user = us.username;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if ([context save:nil]) {
                    NSLog(@"0K");
                }else{
                    NSLog(@"NO");
                }
            });
        }
        [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
        self.temp = YES;
    }
    
}
// 展示并保存color
- (void)changeColorEvent:(UISlider *)sender{
    // 展示color
    self.backView.backgroundColor = [UIColor colorWithRed:self.slide4R.value green:self.slide4G.value blue:self.slide4B.value alpha:self.slide4A.value];
}
// 返回
- (IBAction)backAction:(UIButton *)sender {
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

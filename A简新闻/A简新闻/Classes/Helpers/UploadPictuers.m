//
//  UploadPictuers.m
//  上传图片
//
//  Created by lanou3g on 15/11/15.
//  Copyright © 2015年 MyOClesson.com. All rights reserved.
//

#import "UploadPictuers.h"

@interface UploadPictuers ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
// UIImagePickerController
@property (nonatomic, strong) UIImagePickerController * pick;

// 存自动生成的名字
@property (nonatomic, strong) NSString * str;
// 存得到的图片
@property (nonatomic, strong) UIImage * image;

@end

@implementation UploadPictuers 

/**
 *  用UIImagePickerController 类来获取图片视频，大体分为以下几个步骤：
 
 1. 初始化UIImagePickerController 类；
 
 2. 设置UIImagePickerController 实例的数据来源类型（下面解释）；
 
 3. 设置设置代理；
 
 4. 如果需要做图片修改的话设置allowsEditing =yes。
 */

 // 初始化一个UIImagePickerController
- (void)imagePicker{
    // 获取手机中的图片
    self.pick = [[UIImagePickerController alloc] init];
    _pick.view.backgroundColor = [UIColor orangeColor];
    // 设置数据来源来自相册
    _pick.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 设置代理
    _pick.delegate = self;
    // 设置可编辑
    _pick.allowsEditing = YES;
    
}


- (void)showImagePicker{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(showImagePicker:)]) {
        [_delegate showImagePicker:self.pick];
    }
}

//当用户选取完成后调用；
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [_pick dismissViewControllerAnimated:YES completion:nil];
}


//当用户取消选取时调用；
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 修改后的图片
    self.image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSLog(@"aaaaa%@",self.image);
    self.str = [NSString stringWithFormat:@"%@%@",[self generateUidString],@".png"];
    
    self.block(self.image);
    [_pick dismissViewControllerAnimated:YES completion:nil];
    
    
}

// 返回image
- (UIImage *)imagePickerUploadPictuers{
    NSLog(@"xxxxxx%@", self.image);
    return self.image;
}
// 返回name
- (NSString *)imagePickerUploadName{
    return self.str;
}

#pragma mark -- 私有方法


// 生成一个名字
- (NSString *)generateUidString{
    NSDate *date = [NSDate date];// 获取当前时间
    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
    [dateForMatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *imgName = [dateForMatter stringFromDate:date];
    return imgName;
}


@end

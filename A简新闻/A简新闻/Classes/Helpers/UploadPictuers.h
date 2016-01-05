//
//  UploadPictuers.h
//  上传图片
//
//  Created by lanou3g on 15/11/15.
//  Copyright © 2015年 MyOClesson.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol UploadDelegate <NSObject>
// 代理用于弹出imagePicker
- (void)showImagePicker:(UIImagePickerController *)imagePickerController;

@end

typedef void(^Block) ();
@interface UploadPictuers : NSObject

@property (nonatomic, assign) id<UploadDelegate> delegate;
@property (nonatomic, copy) Block block;

// 初始化一个UIImagePickerController
- (void)imagePicker;
// 打开手机相册
- (void)showImagePicker;
// 返回image
- (UIImage *)imagePickerUploadPictuers;
// 返回image的名字
- (NSString *)imagePickerUploadName;

@end

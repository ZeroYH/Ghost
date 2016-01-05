//
//  DataParsing.m
//  A简新闻
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "DataParsing.h"

#import "ContentModel.h"
#import "ScrollModel.h"

@implementation DataParsing

// 解析没个cell的数据
- (void)doDataParsing:(NSString *)url{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 1.创建AFHTTPRequestOperationManager ---HTTP请求操作管理类的对象
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        // 2.发送get请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%@",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 用字典来承接数据
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSMutableArray * muArray = [NSMutableArray array];
            NSArray * keyArray = [dic allKeys];
            for (NSString * str in keyArray) {
                NSArray * array = dic[str];
                for (NSDictionary * dicy in array) {
                    NSArray *arrays = dicy[@"imgextra"];
                    if (arrays.count != 0) {
                        continue;
                    }
                    ContentModel * content = [ContentModel new];
                    [content setValuesForKeysWithDictionary:dicy];
                    [muArray addObject:content];
                }
            }
            if (!self.dataPars) {
                NSLog(@"block未实现");
            }else {
                self.dataPars(muArray);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    });
}

// 解析轮播图
- (void)shufflingDataParsing:(NSString *)url{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        // 用于承接取到的轮播图
        NSMutableArray * imgMuArray = [NSMutableArray array];
        // 遍历外层字典
        for (NSString * str in [dic allKeys]) {
            // 编历时取到字典内的数组
            NSArray * array = dic[str];
            // 取到数组的第一个元素（只有第一个元素含有轮播图）
            NSDictionary * dicy = array[0];
            int i = 0;
            for (NSString * ste in [dicy allKeys]) {
                if ([ste isEqualToString:@"ads"]) {
                    i++;
                }
            }
            if (i != 0) {
                // 取到轮播图的数组
                NSArray * imgArray = dicy[@"ads"];
                for (NSDictionary * dicc in imgArray) {
                    ScrollModel * scroll = [ScrollModel new];
                    [scroll setValuesForKeysWithDictionary:dicc];
                    
                    [imgMuArray addObject:scroll.imgsrc];
                }
            } else {
                ContentModel * conte = [ContentModel new];
                [conte setValuesForKeysWithDictionary:dicy];
                ScrollModel * scroll1 = [ScrollModel new];
                scroll1.title = conte.title;
                scroll1.imgsrc = conte.imgsrc;
                [imgMuArray addObject:scroll1.imgsrc];
                if (conte.imgsrc2.length != 0) {
                    ScrollModel * scroll2 = [ScrollModel new];
                    scroll2.title = conte.title;
                    scroll2.imgsrc = conte.imgsrc2;
                    [imgMuArray addObject:scroll2.imgsrc];
                    
                    ScrollModel * scroll3 = [ScrollModel new];
                    scroll3.title = conte.title;
                    scroll3.imgsrc = conte.imgsrc3;
                    [imgMuArray addObject:scroll3.imgsrc];
                }
            }
        }
        if (!self.imgData) {
            NSLog(@"block没有");
        }else{
            self.imgData(imgMuArray);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
    }];
}

@end

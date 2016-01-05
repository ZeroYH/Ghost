//
//  VideoParsing.m
//  A简新闻
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "VideoParsing.h"
#import "AFNetworking.h"
#import "VideoModel.h"

@interface VideoParsing ()

@end

@implementation VideoParsing


- (void)doVideoParsing:(NSString *)url{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSMutableArray * modelArray = [NSMutableArray array];
        NSArray * array = dic[@"videoList"];
        for (NSDictionary * dicy in array) {
            VideoModel * model = [VideoModel new];
            [model setValuesForKeysWithDictionary:dicy];
            [modelArray addObject:model];
        }
        _arrayBlock(modelArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


@end

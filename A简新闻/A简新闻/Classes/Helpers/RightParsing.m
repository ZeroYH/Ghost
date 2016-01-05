//
//  RightParsing.m
//  A简新闻
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "RightParsing.h"
#import "AFNetworking.h"
#import "RightModel.h"

@implementation RightParsing


- (void)doRightParsing:(NSString *)url{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSMutableArray * modelArray = [NSMutableArray array];
        NSArray * array = dic[@"stream"];
        for (NSDictionary * dicy in array) {
            RightModel * model = [RightModel new];
            [model setValuesForKeysWithDictionary:dicy];
            [modelArray addObject:model];
        }
        _arrayBlock(modelArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


@end

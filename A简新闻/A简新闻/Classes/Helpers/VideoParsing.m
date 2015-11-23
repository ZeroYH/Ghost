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
    AFHTTPRequestOperationManager * request = [AFHTTPRequestOperationManager manager];
    request.responseSerializer = [AFHTTPResponseSerializer serializer];
    [request GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSMutableArray * modelArray = [NSMutableArray array];
        NSArray * array = dic[@"videoList"];
        for (NSDictionary * dicy in array) {
            VideoModel * model = [VideoModel new];
            [model setValuesForKeysWithDictionary:dicy];
            [modelArray addObject:model];
        }
        
        _arrayBlock(modelArray);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


@end

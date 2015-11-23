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
    AFHTTPRequestOperationManager * request = [AFHTTPRequestOperationManager manager];
    request.responseSerializer = [AFHTTPResponseSerializer serializer];
    [request GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSMutableArray * modelArray = [NSMutableArray array];
        NSArray * array = dic[@"stream"];
        for (NSDictionary * dicy in array) {
            RightModel * model = [RightModel new];
            [model setValuesForKeysWithDictionary:dicy];
            [modelArray addObject:model];
        }
        _arrayBlock(modelArray);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


@end

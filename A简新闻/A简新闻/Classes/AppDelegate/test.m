//
//  test.m
//  A简新闻
//
//  Created by lanou3g on 15/12/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "test.h"

@implementation test


- (void)test{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];// 可请求html
    
    manager.requestSerializer.HTTPRequestHeaders.allKeys;
    
    //manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
}

@end

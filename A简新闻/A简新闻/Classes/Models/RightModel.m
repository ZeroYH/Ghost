//
//  RightModel.m
//  A简新闻
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "RightModel.h"

@implementation RightModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"context"]) {
        NSDictionary * dic = value[0];
        _image = dic[@"image"];
        _url = dic[@"url"];
    }
    if ([key isEqualToString:@"icon"]) {
        _icon = value;
    }
}

@end

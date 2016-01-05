//
//  ContentModel.m
//  A简新闻
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"imgextra"]) {

        _imgsrc2 = value[0][@"imgsrc"];
        
        _imgsrc3 = value[1][@"imgsrc"];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //[super setValue:value forUndefinedKey:key];
}

@end

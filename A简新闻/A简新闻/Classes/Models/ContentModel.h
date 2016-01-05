//
//  ContentModel.h
//  A简新闻
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModel : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * digest;
@property (nonatomic, strong) NSString * imgsrc;
@property (nonatomic, strong) NSArray * imgextra;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * docid;

@property (nonatomic, strong) NSString * imgsrc2;
@property (nonatomic, strong) NSString * imgsrc3;

@end

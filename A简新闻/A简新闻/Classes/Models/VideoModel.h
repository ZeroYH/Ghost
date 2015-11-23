//
//  VideoModel.h
//  A简新闻
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic, strong) NSString * cover;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * descriptions;
@property (nonatomic, strong) NSString * mp4_url;
@property (nonatomic, assign) NSInteger length;
@property (nonatomic, assign) NSInteger playCount;
@end

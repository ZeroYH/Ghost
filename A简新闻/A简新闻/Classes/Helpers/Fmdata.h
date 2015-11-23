//
//  Fmdata.h
//  A简新闻
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fmdata : NSObject

+ (instancetype)fmdata;
- (void)addImgDataBase:(NSString *)user img:(UIImage *) img;
- (void)updateColorAndImgDataBase:(NSString *)user andImg:(UIImage *)img;
- (UIImage *)selectColorAndImgDataBase:(NSString *)user;

@end

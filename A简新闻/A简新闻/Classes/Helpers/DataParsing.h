//
//  DataParsing.h
//  A简新闻
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <Foundation/Foundation.h>
// 数据
typedef void(^DataPars) ();
// 轮播图数据
typedef void(^ImgData) ();

@interface DataParsing : NSObject
// block
@property (nonatomic, copy) DataPars dataPars;
//
@property (nonatomic, copy) ImgData imgData;
// 解析轮播图
- (void)shufflingDataParsing:(NSString *)url;

- (void)doDataParsing:(NSString *)url;

@end

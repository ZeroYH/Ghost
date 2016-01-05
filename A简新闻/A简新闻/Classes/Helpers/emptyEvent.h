//
//  emptyEvent.h
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol emptyDelegate <NSObject>

- (void)viewDoThings:(UIAlertController *)sender;

@end

@interface emptyEvent : NSObject

// 代理
@property (nonatomic, assign) id<emptyDelegate> delegate;
// 构造提示框
- (void)emptyEvent:(NSString *)title andMessage:(NSString *)message;

@end

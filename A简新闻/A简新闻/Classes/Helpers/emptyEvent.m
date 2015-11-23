//
//  emptyEvent.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "emptyEvent.h"

@implementation emptyEvent
// 对输入框为空时的动作
- (void)emptyEvent:(NSString *)title andMessage:(NSString *)message{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"👌" style:(UIAlertActionStyleDefault) handler:nil];
    [alert addAction:alertAction];
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(viewDoThings:)]) {
        [_delegate viewDoThings:alert];
    }
}
@end

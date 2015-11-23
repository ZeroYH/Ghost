//
//  VideoPlayer.h
//  A简新闻
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol videoEndDelegate <NSObject>

- (void)doSomeThingsWhenVideoEnd;

@end
@interface VideoPlayer : NSObject

@property (nonatomic, strong) UIView * view;
@property (nonatomic, assign) BOOL temp;
@property (nonatomic, assign) id<videoEndDelegate> delegate;


+ (instancetype)videoPlayer;
- (void)showVideoPlayer:(NSString *)url andFrame:(CGRect)frame andView:(UIView *)views;
- (void)playForVideo;
- (void)pauseForVideo;

@end

//
//  VideoPlayer.m
//  A简新闻
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "VideoPlayer.h"

@interface VideoPlayer ()

@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) AVPlayerLayer * playerLayer;

@end

static VideoPlayer * player = nil;
@implementation VideoPlayer

+ (instancetype)videoPlayer{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [VideoPlayer new];
    });
    return player;
}
// 添加通知，播放结束后
- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerEndEvent:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}
// 播放结束后做的事
- (void)videoPlayerEndEvent:(NSNotification *)sender{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(doSomeThingsWhenVideoEnd)]) {
        [_delegate doSomeThingsWhenVideoEnd];
    }
}

- (void)showVideoPlayer:(NSString *)url andFrame:(CGRect)frame andView:(UIView *)views{
    AVPlayerItem * item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    [self.player replaceCurrentItemWithPlayerItem:item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(frame.origin.x - 10, frame.origin.y - 10, frame.size.width, frame.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    UIView * playView = [[UIView alloc] initWithFrame:frame];
    [playView.layer addSublayer:_playerLayer];
    self.view = playView;
    
    [views addSubview:playView];
    
    [self playForVideo];
}



- (void)playForVideo{
    if (_temp) {
        return;
    }
    [self.player play];
    _temp = YES;
}

- (void)pauseForVideo{
    [self.player pause];
    _temp = NO;
    [self.view removeFromSuperview];
}
#pragma mark -- 懒加载
- (AVPlayer *)player{
    if (!_player) {
        _player = [AVPlayer new];
    }
    return _player;
}

- (AVPlayerLayer *)playerLayer{
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer new];
    }
    return _playerLayer;
}
@end

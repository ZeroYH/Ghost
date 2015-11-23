//
//  VideoCell.m
//  A简新闻
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "VideoCell.h"
#import "VideoPlayer.h"


@interface VideoCell ()

@property (strong, nonatomic) IBOutlet UIImageView *img4View;

@property (strong, nonatomic) IBOutlet UIImageView *img4Btn;

@property (strong, nonatomic) IBOutlet UILabel *titleLB;
@property (strong, nonatomic) IBOutlet UILabel *smilTitleLB;
@property (strong, nonatomic) IBOutlet UIView *bootmView;
@property (strong, nonatomic) IBOutlet UILabel *long4LB;
@property (strong, nonatomic) IBOutlet UILabel *cut4LB;
- (IBAction)btn4Action:(UIButton *)sender;

@property (nonatomic, assign)BOOL temp;
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) UIView * views;
//@property (nonatomic, assign) NSInteger te;
@end

@implementation VideoCell

- (void)awakeFromNib {
//    self.te = -1;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 5;
    self.backView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
}

- (void)setVideo:(VideoModel *)video{
    _video = video;
    [self.img4View sd_setImageWithURL:[NSURL URLWithString:video.cover]];
    self.titleLB.text = video.title;
    self.smilTitleLB.text = video.descriptions;
    self.long4LB.text = [NSString stringWithFormat:@"⏳:%ld",(long)video.length];
    self.cut4LB.text = [NSString stringWithFormat:@"🎥:%ld",video.playCount];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btn4Action:(UIButton *)sender {
//
    
    if ([VideoPlayer videoPlayer].temp) {
        [[VideoPlayer videoPlayer] pauseForVideo];
        [[VideoPlayer videoPlayer] showVideoPlayer:self.video.mp4_url andFrame:self.backView.frame andView:self.backView ];
    } else {
        [[VideoPlayer videoPlayer] showVideoPlayer:self.video.mp4_url andFrame:self.backView.frame andView:self.backView ];
    }
}
@end


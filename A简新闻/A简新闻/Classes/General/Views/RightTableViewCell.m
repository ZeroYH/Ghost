//
//  RightTableViewCell.m
//  A简新闻
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "RightTableViewCell.h"

@interface RightTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *header4Img;
@property (strong, nonatomic) IBOutlet UIImageView *back4Img;

@end

@implementation RightTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.back4Img addSubview:_header4Img];
}

- (void)setModel:(RightModel *)model{
    _model = model;
    [self.header4Img sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    [self.back4Img sd_setImageWithURL:[NSURL URLWithString:model.image]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

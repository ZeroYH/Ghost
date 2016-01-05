//
//  MoreImgTableViewCell.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "MoreImgTableViewCell.h"

#import "UIImageView+WebCache.h"

@interface MoreImgTableViewCell ()

// title
@property (nonatomic, strong) UILabel * titleLB;

// 图片
@property (nonatomic, strong) UIImageView * leftImgView;
@property (nonatomic, strong) UIImageView * middleImgView;
@property (nonatomic, strong) UIImageView * rightImgView;


@end

@implementation MoreImgTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self showView];
    }
    return self;
}

- (void)showView{
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    // 背景
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, kWidth - 10, 110)];
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 5;
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];

    // title
    self.titleLB  = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kWidth - 20, 20)];
    _titleLB.font = [UIFont systemFontOfSize:17 weight:17];
//    self.titleLB.backgroundColor = [UIColor yellowColor];
    [self addSubview:_titleLB];
    
    // imageView
    
    self.leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, (kWidth - 30) / 3, 75)];
    _leftImgView.layer.masksToBounds = YES;
    _leftImgView.layer.cornerRadius = 5;
//    _leftImgView.backgroundColor = [UIColor redColor];
    [self addSubview:_leftImgView];
    
    self.middleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (kWidth - 30) / 3 + 5, 35 , (kWidth - 30) / 3, 75)];
    _middleImgView.layer.masksToBounds = YES;
    _middleImgView.layer.cornerRadius = 5;
    
//    _middleImgView.backgroundColor = [UIColor redColor];
    [self addSubview:_middleImgView];
    
    self.rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - (10 + (kWidth - 30) / 3 ), 35 , (kWidth - 30) / 3, 75)];
    _rightImgView.layer.masksToBounds = YES;
    _rightImgView.layer.cornerRadius = 5;
//    _rightImgView.backgroundColor = [UIColor redColor];
    [self addSubview:_rightImgView];
    
    
}

- (void)setContent:(ContentModel *)content{
    _content = content;
    _titleLB.text = content.title;
    [_leftImgView sd_setImageWithURL:[NSURL URLWithString:content.imgsrc] placeholderImage:[UIImage imageNamed:@"suipian@2x.png"]];
    [_middleImgView sd_setImageWithURL:[NSURL URLWithString:content.imgsrc2] placeholderImage:[UIImage imageNamed:@"suipian@2x.png"]];
    [_rightImgView sd_setImageWithURL:[NSURL URLWithString:content.imgsrc3] placeholderImage:[UIImage imageNamed:@"suipian@2x.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

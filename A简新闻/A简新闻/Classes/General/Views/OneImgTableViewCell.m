//
//  OneImgTableViewCell.m
//  A简新闻
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "OneImgTableViewCell.h"

#import "UIImageView+WebCache.h"

@interface OneImgTableViewCell ()

// 左边的图片
@property (nonatomic, strong) UIImageView * leftImgView;

// title
@property (nonatomic, strong) UILabel * titleLB;

// 简介
@property (nonatomic, strong) UILabel * contextLB;



@end

@implementation OneImgTableViewCell

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
    
    // 左图片
    self.leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kWidth / 4 - 5, 100)];
    _leftImgView.layer.masksToBounds = YES;
    _leftImgView.layer.cornerRadius = 5;
//    _leftImgView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_leftImgView];
    
    // title
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/4 + 10, 10, kWidth/4 * 3 - 20, 30)];
    _titleLB.textAlignment = NSTextAlignmentLeft;
    _titleLB.font = [UIFont systemFontOfSize:17 weight:17];
//    _titleLB.backgroundColor = [UIColor greenColor];
    [self addSubview:_titleLB];
    
    // 简介
    self.contextLB = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/4 + 10, 45, kWidth/4 * 3 - 20, 60)];
    _contextLB.textAlignment = NSTextAlignmentLeft;
    _contextLB.numberOfLines = 0;
    _contextLB.font = [UIFont systemFontOfSize:15];
    _contextLB.textColor = [UIColor grayColor];
//    _contextLB.backgroundColor = [UIColor redColor];
    [self addSubview:_contextLB];
    
}

- (void)setContent:(ContentModel *)content{
    _content = content;
    _titleLB.text = content.title;
    _contextLB.text = content.digest;
    [_leftImgView sd_setImageWithURL:[NSURL URLWithString:content.imgsrc] placeholderImage:[UIImage imageNamed:@"suipian@2x.png"]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

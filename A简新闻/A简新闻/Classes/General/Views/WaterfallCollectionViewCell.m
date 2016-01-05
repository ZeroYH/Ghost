//
//  WaterfallCollectionViewCell.m
//  A简新闻
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "WaterfallCollectionViewCell.h"

@implementation WaterfallCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGRect imageViewFrame = CGRectMake(0, 0, CGRectGetMaxX(self.contentView.bounds), CGRectGetMaxY(self.contentView.bounds));
        
        _showImageView = [UIImageView new];
        _showImageView.contentMode = UIViewContentModeScaleAspectFill;
        _showImageView.frame = imageViewFrame;
        _showImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _showImageView.clipsToBounds = YES;
        [self addSubview:_showImageView];
        self.layer.borderWidth = 1;
        
    }
    return self;
}

@end

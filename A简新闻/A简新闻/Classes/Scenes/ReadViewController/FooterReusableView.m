//
//  FooterReusableView.m
//  A简新闻
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "FooterReusableView.h"

@implementation FooterReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 1;// 边框宽度
    }
    return self;
}
@end

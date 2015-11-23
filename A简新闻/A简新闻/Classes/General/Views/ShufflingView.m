//
//  ShufflingView.m
//  A简新闻
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "ShufflingView.h"
#import "UIImageView+WebCache.h"
#import "ScrollModel.h"
#import "ContentModel.h"

@interface ShufflingView ()

@property (nonatomic, retain) UIScrollView * scroll;
@property (nonatomic, strong) UIPageControl * page;

// 计时器
@property (nonatomic, assign) NSInteger temp;
// NSTimer
@property (nonatomic, retain) NSTimer * timer;

@property (nonatomic, strong) NSMutableArray * array;
@property (nonatomic, strong) UILabel * titleLB;
@end

@implementation ShufflingView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
        
    }
    return _array;
}

- (void)showView:(NSMutableArray *)scrollArray{
    self.array = scrollArray;
    // 背景
    UIView * backView = [[UIView alloc] initWithFrame:self.frame];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    // UIScrollView
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.bounds.size.width,self.bounds.size.height - 20)];
    _scroll.contentSize = CGSizeMake(self.bounds.size.width * scrollArray.count - 1, self.bounds.size.height - 20);
    _scroll.delegate = self;
    _scroll.pagingEnabled = YES;
    _scroll.scrollEnabled = NO;
    _scroll.bounces = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:_scroll];
    
    // 添加UIImageView
    for (int i = 0; i < scrollArray.count - 1; i++) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + self.bounds.size.width * i, 0, self.bounds.size.width, self.bounds.size.height - 20)];
        
        // model
        ScrollModel * model = scrollArray[i];
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"suipian@2x.png"]];
        [_scroll addSubview:imgView];
        
        
    }
/*
    // UIPageControl
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 40, self.bounds.size.height - 20, 40, 20)];
    _page.numberOfPages = scrollArray.count;
    _page.currentPageIndicatorTintColor = [UIColor purpleColor];
    _page.pageIndicatorTintColor = [UIColor greenColor];
    [self addSubview:_page];
    
    // UILabel
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width - 40, 20)];
    _titleLB.font = [UIFont systemFontOfSize:10];
    
    [self addSubview:_titleLB];
    */
    //创建计时器
//    if (scrollArray.count > 1) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoMove:) userInfo:nil repeats:YES];
//        [_timer fire];
//    } else {
//        ScrollModel * model = self.array[0];
//        self.titleLB.text = model.title;
//    }
    
}
/*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    ScrollModel * model = self.array[self.page.currentPage];
    self.titleLB.text = model.title;
    self.page.currentPage = self.scroll.contentOffset.x / self.bounds.size.width;
    
}
*/
// 自动轮播
/*
- (void)autoMove:(NSTimer *)sender{
    // 每次改变 UIScrollView 的偏移量 与 UIPageControl的值
    self.page.currentPage = self.temp;
    self.scroll.contentOffset = CGPointMake(self.bounds.size.width * self.page.currentPage, 0);
    ScrollModel * model = self.array[self.page.currentPage];
    self.titleLB.text = model.title;
    // 当播到最后一张时 返回第一张
    if (_temp == self.array.count - 1) {
        self.scroll.contentOffset = CGPointMake(0, 0);
        self.page.currentPage = 0;
        _temp = 0;
    }
    // 每次自增
    _temp ++;
    
    
}
*/
// UIScrollVi

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

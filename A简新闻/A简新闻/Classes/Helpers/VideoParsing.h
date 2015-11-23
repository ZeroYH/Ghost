//
//  VideoParsing.h
//  A简新闻
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^block) ();

@interface VideoParsing : NSObject

@property (nonatomic, copy)block arrayBlock;

- (void)doVideoParsing:(NSString *)url;
@end

//
//  RightParsing.h
//  A简新闻
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^block) ();
@interface RightParsing : NSObject
@property (nonatomic, copy)block arrayBlock;
- (void)doRightParsing:(NSString *)url;
@end

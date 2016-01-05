//
//  VideoCell.h
//  A简新闻
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@interface VideoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (nonatomic, strong) VideoModel * video;
//@property (nonatomic, assign) NSInteger ste;
@end

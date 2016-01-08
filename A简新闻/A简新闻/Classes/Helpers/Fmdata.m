//
//  Fmdata.m
//  A简新闻
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "Fmdata.h"
static Fmdata * dataBase = nil;
@interface Fmdata ()
@property (nonatomic, strong) FMDatabaseQueue *queue;
@end

@implementation Fmdata

+ (instancetype)fmdata{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [Fmdata new];
        [dataBase openData];
    });
    return dataBase;
}

- (void)openData{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [documentPath stringByAppendingString:@"/data.sqlite"];
    self.queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists Use (user text primary key, img BLOB);"];
        if (result) {
            NSLog(@"建表成功");
        }else{
            NSLog(@"建表失败");
        }
    }];
}
- (void)addImgDataBase:(NSString *)user img:(UIImage *) img{
    [self openData];
    [self.queue inDatabase:^(FMDatabase *db) {
        NSData * data = UIImagePNGRepresentation(img);
        [db executeUpdate:@"insert into Use (user, img) values(?, ?)", user,data];
    }];
}

- (void)updateColorAndImgDataBase:(NSString *)user andImg:(UIImage *)img{
    [self openData];
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSData * data = UIImagePNGRepresentation(img);
        [db executeUpdate:@"update Use set img = ? where user = ?",data, user];
    }];
}

- (UIImage *)selectColorAndImgDataBase:(NSString *)user{
    [self openData];
    __block UIImage * imgs = [[UIImage alloc] init];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet * rb = [db executeQuery:@"select * from Use where user = ?",user];
        while (rb.next) {
            imgs = [UIImage imageWithData:[rb dataForColumn:@"img"]];
        }
    }];
    return imgs;
}

@end

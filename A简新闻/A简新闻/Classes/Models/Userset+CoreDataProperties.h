//
//  Userset+CoreDataProperties.h
//  A简新闻
//
//  Created by lanou3g on 15/11/22.
//  Copyright © 2015年 yrh.com. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Userset.h"

NS_ASSUME_NONNULL_BEGIN

@interface Userset (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *alpha;
@property (nullable, nonatomic, retain) NSNumber *blue;
@property (nullable, nonatomic, retain) NSNumber *green;
@property (nullable, nonatomic, retain) NSNumber *red;
@property (nullable, nonatomic, retain) NSString *user;
@property (nullable, nonatomic, retain) NSData *img;

@end

NS_ASSUME_NONNULL_END

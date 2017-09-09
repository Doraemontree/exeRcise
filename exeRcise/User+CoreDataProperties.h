//
//  User+CoreDataProperties.h
//  exeRcise
//
//  Created by hemeng on 17/6/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *uid;
@property (nullable, nonatomic, copy) NSString *lastLoginTime;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *password;

@end

NS_ASSUME_NONNULL_END

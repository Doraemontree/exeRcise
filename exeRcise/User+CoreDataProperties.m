//
//  User+CoreDataProperties.m
//  exeRcise
//
//  Created by hemeng on 17/6/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic uid;
@dynamic lastLoginTime;
@dynamic name;
@dynamic password;

@end

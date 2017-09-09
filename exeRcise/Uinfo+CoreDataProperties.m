//
//  Uinfo+CoreDataProperties.m
//  exeRcise
//
//  Created by hemeng on 17/6/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "Uinfo+CoreDataProperties.h"

@implementation Uinfo (CoreDataProperties)

+ (NSFetchRequest<Uinfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Uinfo"];
}

@dynamic uid;
@dynamic sex;
@dynamic height;
@dynamic weight;
@dynamic aimC;
@dynamic aimD;
@dynamic aimT;

@end

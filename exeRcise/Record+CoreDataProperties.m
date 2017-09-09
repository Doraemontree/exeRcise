//
//  Record+CoreDataProperties.m
//  exeRcise
//
//  Created by hemeng on 17/6/26.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "Record+CoreDataProperties.h"

@implementation Record (CoreDataProperties)

+ (NSFetchRequest<Record *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Record"];
}

@dynamic calorie;
@dynamic distant;
@dynamic num;
@dynamic speed;
@dynamic time;
@dynamic type;
@dynamic uid;
@dynamic date;

@end

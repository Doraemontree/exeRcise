//
//  RunningData+CoreDataProperties.m
//  exeRcise
//
//  Created by hemeng on 17/6/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "RunningData+CoreDataProperties.h"

@implementation RunningData (CoreDataProperties)

+ (NSFetchRequest<RunningData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RunningData"];
}

@dynamic uid;
@dynamic totalC;
@dynamic totalD;
@dynamic totalT;
@dynamic todayC;
@dynamic todayD;
@dynamic todayT;

@end

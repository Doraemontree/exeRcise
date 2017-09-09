//
//  WalkingData+CoreDataProperties.m
//  exeRcise
//
//  Created by hemeng on 17/6/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "WalkingData+CoreDataProperties.h"

@implementation WalkingData (CoreDataProperties)

+ (NSFetchRequest<WalkingData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"WalkingData"];
}

@dynamic uid;
@dynamic totalC;
@dynamic totalD;
@dynamic totalT;
@dynamic todayC;
@dynamic todayD;
@dynamic todayT;

@end

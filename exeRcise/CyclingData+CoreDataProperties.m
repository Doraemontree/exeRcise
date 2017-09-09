//
//  CyclingData+CoreDataProperties.m
//  exeRcise
//
//  Created by hemeng on 17/6/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CyclingData+CoreDataProperties.h"

@implementation CyclingData (CoreDataProperties)

+ (NSFetchRequest<CyclingData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CyclingData"];
}

@dynamic uid;
@dynamic totalC;
@dynamic totalD;
@dynamic totalT;
@dynamic todayC;
@dynamic todayD;
@dynamic todayT;

@end

//
//  CyclingData+CoreDataProperties.h
//  exeRcise
//
//  Created by hemeng on 17/6/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CyclingData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CyclingData (CoreDataProperties)

+ (NSFetchRequest<CyclingData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *uid;
@property (nonatomic) float totalC;
@property (nonatomic) float totalD;
@property (nonatomic) float totalT;
@property (nonatomic) float todayC;
@property (nonatomic) float todayD;
@property (nonatomic) float todayT;

@end

NS_ASSUME_NONNULL_END

//
//  Record+CoreDataProperties.h
//  exeRcise
//
//  Created by hemeng on 17/6/26.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "Record+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Record (CoreDataProperties)

+ (NSFetchRequest<Record *> *)fetchRequest;

@property (nonatomic) float calorie;
@property (nonatomic) float distant;
@property (nonatomic) int16_t num;
@property (nullable, nonatomic, copy) NSString *speed;
@property (nonatomic) float time;
@property (nonatomic) int16_t type;
@property (nullable, nonatomic, copy) NSString *uid;
@property (nullable, nonatomic, copy) NSString *date;

@end

NS_ASSUME_NONNULL_END

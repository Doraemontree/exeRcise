//
//  Uinfo+CoreDataProperties.h
//  exeRcise
//
//  Created by hemeng on 17/6/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "Uinfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Uinfo (CoreDataProperties)

+ (NSFetchRequest<Uinfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *uid;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nonatomic) int16_t height;
@property (nonatomic) int16_t weight;
@property (nonatomic) float aimC;
@property (nonatomic) float aimD;
@property (nonatomic) float aimT;

@end

NS_ASSUME_NONNULL_END

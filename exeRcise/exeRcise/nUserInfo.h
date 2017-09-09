//
//  nUserInfo.h
//  exeRcise
//
//  Created by hemeng on 17/6/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface nUserInfo : NSObject

@property NSString *uid;
@property NSString *name;
@property NSString *password;
@property int weight;
@property int height;
@property NSString *lastLoginTime;
@property NSString *sex;
@property float aimC;
@property float aimD;
@property float aimT;

@property(nonatomic,strong)NSMutableArray *runningAr;//todayC todayD todayT  totalC totalD  totalT 大卡 公里 分钟
@property(nonatomic,strong)NSMutableArray *cyclingAr;
@property(nonatomic,strong)NSMutableArray *walkingAr;


@end

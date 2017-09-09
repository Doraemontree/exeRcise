//
//  LoginModel.m
//  exeRcise
//
//  Created by hemeng on 17/6/19.
//  Copyright © 2017年 hemeng. All rights reserved.


#import "LoginModel.h"
#import "nDataBase.h"

@implementation LoginModel

-(BOOL)isUserDataExistInLocalWithUid:(NSString *)uid{
    
    nDataBase *database = [[nDataBase alloc]init];
    
    NSArray *ar = [database loadDataFromLocalWithUserId:uid withEntity:@"User"];
    
    if(ar.count == 0)//如果返回值为空 表示从网络上加载数据
        return NO;
    else//有数据返回yes
        return YES;
}

-(void)addAllDataToLocalWithUdic:(NSDictionary *)Udic
                        withIdic:(NSDictionary *)Idic
                        withWdic:(NSDictionary *)Wdic
                        withRdic:(NSDictionary *)Rdic
                        withCdic:(NSDictionary *)Cdic{
    
    nDataBase *database = [[nDataBase alloc]init];
    
    //读取数据先加载进本地数据库在加载到userInfo
    [database addUserWithDic:Udic];
    [database addUinfoWithDic:Idic];
    [database addWalkingDataWithDic:Wdic];
    [database addRunningDataWithDic:Rdic];
    [database addCyclingDataWithDic:Cdic];
    
}

-(nUserInfo *)GetUserInfoWithUid:(NSString *)uid{
    nDataBase *database = [[nDataBase alloc]init];
    
    User *u        = [[database loadDataFromLocalWithUserId:uid withEntity:@"User"] firstObject];
    Uinfo *i       = [[database loadDataFromLocalWithUserId:uid withEntity:@"Uinfo"] firstObject];
    RunningData *r = [[database loadDataFromLocalWithUserId:uid withEntity:@"RunningData"] firstObject];
    WalkingData *w = [[database loadDataFromLocalWithUserId:uid withEntity:@"WalkingData"] firstObject];
    CyclingData *c = [[database loadDataFromLocalWithUserId:uid withEntity:@"CyclingData"] firstObject];
    
    nUserInfo *user = [[nUserInfo alloc]init];
    
    user.uid           = u.uid;
    user.password      = u.password;
    user.name          = u.name;
    user.lastLoginTime = u.lastLoginTime;
    
    user.height        = i.height;
    user.weight        = i.weight;
    user.sex           = i.sex;
    user.aimC          = i.aimC;
    user.aimD          = i.aimD;
    user.aimT          = i.aimT;
    
    
    [user.runningAr addObject:[NSNumber numberWithFloat:r.todayC]];
    [user.runningAr addObject:[NSNumber numberWithFloat:r.todayD]];
    [user.runningAr addObject:[NSNumber numberWithFloat:r.todayT]];
    [user.runningAr addObject:[NSNumber numberWithFloat:r.totalC]];
    [user.runningAr addObject:[NSNumber numberWithFloat:r.totalD]];
    [user.runningAr addObject:[NSNumber numberWithFloat:r.totalT]];
    
    [user.cyclingAr addObject:[NSNumber numberWithFloat:c.todayC]];
    [user.cyclingAr addObject:[NSNumber numberWithFloat:c.todayD]];
    [user.cyclingAr addObject:[NSNumber numberWithFloat:c.todayT]];
    [user.cyclingAr addObject:[NSNumber numberWithFloat:c.totalC]];
    [user.cyclingAr addObject:[NSNumber numberWithFloat:c.totalD]];
    [user.cyclingAr addObject:[NSNumber numberWithFloat:c.totalT]];
    
    [user.walkingAr addObject:[NSNumber numberWithFloat:w.todayC]];
    [user.walkingAr addObject:[NSNumber numberWithFloat:w.todayD]];
    [user.walkingAr addObject:[NSNumber numberWithFloat:w.todayT]];
    [user.walkingAr addObject:[NSNumber numberWithFloat:w.totalC]];
    [user.walkingAr addObject:[NSNumber numberWithFloat:w.totalD]];
    [user.walkingAr addObject:[NSNumber numberWithFloat:w.totalT]];
    
    return user;
}
@end

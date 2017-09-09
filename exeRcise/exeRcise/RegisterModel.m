//
//  RegisterModel.m
//  exeRcise
//
//  Created by hemeng on 17/6/19.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "RegisterModel.h"
#import "nDataBase.h"

@implementation RegisterModel

-(void)addDataToLocalDataBaseWithUserDic:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    
    //注册成功后加载数据到本地服务器
    NSDictionary *dic2 = @{@"id":[dic objectForKey:@"id"],
                           @"totalC":[NSNumber numberWithFloat:0],
                           @"totalD":[NSNumber numberWithFloat:0],
                           @"totalT":[NSNumber numberWithFloat:0],
                           @"todayC":[NSNumber numberWithFloat:0],
                           @"todayD":[NSNumber numberWithFloat:0],
                           @"todayT":[NSNumber numberWithFloat:0]};
    
    nDataBase *database = [[nDataBase alloc]init];
    
    [database addUserWithDic:dic];
    [database addUinfoWithDic:dic];
    [database addCyclingDataWithDic:dic2];
    [database addWalkingDataWithDic:dic2];
    [database addRunningDataWithDic:dic2];
}

-(nUserInfo *)setUserInfoWithUserInfoDic:(NSDictionary *)dic{
    //设置模型里面uid的值
    nUserInfo *user = [[nUserInfo alloc]init];
    
    user.uid           = [dic objectForKey:@"id"];
    user.password      = [dic objectForKey:@"password"];
    user.name          = [dic objectForKey:@"name"];
    user.height        = [[dic objectForKey:@"height"] intValue];
    user.weight        = [[dic objectForKey:@"weight"] intValue];
    user.lastLoginTime = [dic objectForKey:@"lastLoginTime"];
    user.sex           = [dic objectForKey:@"sex"];
    user.aimC          = [[dic objectForKey:@"aimC"] floatValue];
    user.aimD          = [[dic objectForKey:@"aimD"] floatValue];
    user.aimT          = [[dic objectForKey:@"aimT"] floatValue];
    
    for(int i=0;i<5;i++){
        [user.runningAr addObject:[NSNumber numberWithFloat:0]];
        [user.cyclingAr addObject:[NSNumber numberWithFloat:0]];
        [user.walkingAr addObject:[NSNumber numberWithFloat:0]];
        
    }
    return user;

}

@end

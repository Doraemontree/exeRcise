//
//  ViewControllerModel.m
//  exeRcise
//
//  Created by hemeng on 17/6/19.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ViewControllerModel.h"
#import "nDataBase.h"
#import <UIImageView+AFNetworking.h>
#import <UIKit+AFNetworking.h>


@implementation ViewControllerModel
-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}
-(nUserInfo *)GetUserInfo:(NSString *)uid{
    
    nDataBase *database = [[nDataBase alloc]init];
    User *u        = [[database loadDataFromLocalWithUserId:uid withEntity:@"User"] firstObject];
    Uinfo *i       = [[database loadDataFromLocalWithUserId:uid withEntity:@"Uinfo"] firstObject];
    RunningData *r = [[database loadDataFromLocalWithUserId:uid withEntity:@"RunningData"] firstObject];
    CyclingData *c = [[database loadDataFromLocalWithUserId:uid withEntity:@"CyclingData"] firstObject];
    WalkingData *w = [[database loadDataFromLocalWithUserId:uid withEntity:@"WalkingData"] firstObject];
    
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

-(void)DownloadUserImageTolocalWithUid:(NSString *)uid{

    NSString *imageName = [uid stringByAppendingString:@".jpeg"];

    NSString *urlStr = [@"http://139.199.158.105/userImage/" stringByAppendingString:imageName];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *fullpath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
        
        [responseObject writeToFile:fullpath options:NSDataWritingWithoutOverwriting error:nil];
        
        NSNotification *noti = [NSNotification notificationWithName:@"finishDownloadImage" object:nil];
        
        [[NSNotificationCenter defaultCenter]postNotification:noti];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}
-(void)autoUpdateLastLoginTimeAndTodayCDT{//自动检测最后登入日期 只会在自动登录和手动登录中调用 注册不会掉用
    NSString *date = [self getTodayDate];
    if(![self.appDelegate.userInfo.lastLoginTime isEqualToString:date]){
        
        //更新appdelegate
        self.appDelegate.userInfo.lastLoginTime = date;
        [self.appDelegate.userInfo.runningAr replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:0]];
        [self.appDelegate.userInfo.runningAr replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:0]];
        [self.appDelegate.userInfo.runningAr replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:0]];
        
        [self.appDelegate.userInfo.cyclingAr replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:0]];
        [self.appDelegate.userInfo.cyclingAr replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:0]];
        [self.appDelegate.userInfo.cyclingAr replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:0]];
        
        [self.appDelegate.userInfo.walkingAr replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:0]];
        [self.appDelegate.userInfo.walkingAr replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:0]];
        [self.appDelegate.userInfo.walkingAr replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:0]];
        
        nDataBase *database = [[nDataBase alloc]init];
        
        NSDictionary *dic = @{@"id":self.appDelegate.userInfo.uid,
                              @"isTodaySetZero":[NSNumber numberWithBool:YES]};
        //更新本地数据库
        [database updateExeciseDataWithTableName:@"RunningData" withDic:dic];
        [database updateExeciseDataWithTableName:@"CyclingData" withDic:dic];
        [database updateExeciseDataWithTableName:@"WalkingData" withDic:dic];
        
        //更新日期
        [database updateUserWithUid:self.appDelegate.userInfo.uid
                           withName:self.appDelegate.userInfo.name
                       withPassword:self.appDelegate.userInfo.password
                  withlastLoginTime:[self getTodayDate]];
        
        //更新网上数据库
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *DateDic = @{@"id":self.appDelegate.userInfo.uid,
                                  @"todayDate":[self getTodayDate]};
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:@"http://139.199.158.105/setTodayDate.php" parameters:DateDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

-(NSString *)getTodayDate{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *str = [formatter stringFromDate:date];
    
    return str;
}

@end

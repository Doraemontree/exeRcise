//
//  RunModel.m
//  exeRcise
//
//  Created by hemeng on 17/6/21.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "RunModel.h"
#import "nDataBase.h"


@implementation RunModel

-(void)UpdateDataToLocalWithExerciseType:(int)type withDic:(NSDictionary *)dic{
    nDataBase *database = [[nDataBase alloc]init];
    
    NSString *uid = self.appDelegate.userInfo.uid;
    
    NSDictionary *PostDic = @{@"id":uid,
                              @"isTodaySetZero":[NSNumber numberWithBool:NO],
                              @"calorie":[dic objectForKey:@"calorie"],
                              @"distance":[dic objectForKey:@"distance"],
                              @"time":[dic objectForKey:@"time"]};
    
    
    if(type == 0)
        [database updateExeciseDataWithTableName:@"RunningData" withDic:PostDic];
    else if(type == 1)
        [database updateExeciseDataWithTableName:@"CyclingData" withDic:PostDic];
    else if(type == 2)
       [database updateExeciseDataWithTableName:@"WalkingData" withDic:PostDic];
    
    int num;//record的记录条数
    num = (int)[[database loadDataFromLocalWithUserId:uid withEntity:@"Record"] count];
    num += 1;
    
    NSDictionary *recordDic = @{@"id":uid,
                                @"num":[NSNumber numberWithInt:num],
                                @"type":[NSNumber numberWithInt:type],
                                @"calorie":[dic objectForKey:@"calorie"],
                                @"distance":[dic objectForKey:@"distance"],
                                @"time":[dic objectForKey:@"time"],
                                @"speed":[dic objectForKey:@"speed"],
                                @"date":[self getDate]};
    
    [database addRecordWithDic:recordDic];
}

-(void)UpdateDataToNetWorkWithExerciseType:(int)type withDic:(NSDictionary *)dic{

    //添加数据进入data表与record表
    NSString *tableName;
    if(type == 0)
        tableName = @"runningData";
    else if(type == 1)
        tableName = @"cyclingData";
    else if(type == 2)
        tableName = @"walkingData";
        
    NSDictionary *postDic = @{@"id":self.appDelegate.userInfo.uid,
                              @"exerciseType":tableName,
                              @"calorie":[dic objectForKey:@"calorie"],
                              @"distance":[dic objectForKey:@"distance"],
                              @"time":[dic objectForKey:@"time"],
                              @"speed":[dic objectForKey:@"speed"],
                              @"date":[self getDate]};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://139.199.158.105/updateData.php" parameters:postDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(error.code == -1001)
            NSLog(@"网络连接失败");
        else
            NSLog(@"error:%@",error);
    }];
}

-(void)updataUserInfoWithExerciseType:(int)type withDic:(NSDictionary *)dic{
    
    float c = [[dic objectForKey:@"calorie"] floatValue];
    float d = [[dic objectForKey:@"distance"] floatValue];
    float t = [[dic objectForKey:@"time"] floatValue];
    
    NSMutableArray *ar;
    
    if(type == 0)
        ar = [NSMutableArray arrayWithArray:self.appDelegate.userInfo.runningAr];
    else if(type == 1)
        ar = [NSMutableArray arrayWithArray:self.appDelegate.userInfo.cyclingAr];
    else if(type == 2)
        ar = [NSMutableArray arrayWithArray:self.appDelegate.userInfo.walkingAr];
    
    float todayC = [[ar objectAtIndex:0] floatValue];
    float todayD = [[ar objectAtIndex:1] floatValue];
    float todayT = [[ar objectAtIndex:2] floatValue];
    float totalC = [[ar objectAtIndex:3] floatValue];
    float totalD = [[ar objectAtIndex:4] floatValue];
    float totalT = [[ar objectAtIndex:5] floatValue];
    
    todayC += c;
    todayD += d;
    todayT += t;
    totalC += c;
    totalD += d;
    totalT += t;
    
    if(type == 0){
        [self.appDelegate.userInfo.runningAr replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:todayC]];
        [self.appDelegate.userInfo.runningAr replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:todayD]];
        [self.appDelegate.userInfo.runningAr replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:todayT]];
        [self.appDelegate.userInfo.runningAr replaceObjectAtIndex:3 withObject:[NSNumber numberWithFloat:totalC]];
        [self.appDelegate.userInfo.runningAr replaceObjectAtIndex:4 withObject:[NSNumber numberWithFloat:totalD]];
        [self.appDelegate.userInfo.runningAr replaceObjectAtIndex:5 withObject:[NSNumber numberWithFloat:totalT]];
    }
    else if(type == 1){
        [self.appDelegate.userInfo.cyclingAr replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:todayC]];
        [self.appDelegate.userInfo.cyclingAr replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:todayD]];
        [self.appDelegate.userInfo.cyclingAr replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:todayT]];
        [self.appDelegate.userInfo.cyclingAr replaceObjectAtIndex:3 withObject:[NSNumber numberWithFloat:totalC]];
        [self.appDelegate.userInfo.cyclingAr replaceObjectAtIndex:4 withObject:[NSNumber numberWithFloat:totalD]];
        [self.appDelegate.userInfo.cyclingAr replaceObjectAtIndex:5 withObject:[NSNumber numberWithFloat:totalT]];
    }
    else if(type == 2){
        [self.appDelegate.userInfo.walkingAr replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:todayC]];
        [self.appDelegate.userInfo.walkingAr replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:todayD]];
        [self.appDelegate.userInfo.walkingAr replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:todayT]];
        [self.appDelegate.userInfo.walkingAr replaceObjectAtIndex:3 withObject:[NSNumber numberWithFloat:totalC]];
        [self.appDelegate.userInfo.walkingAr replaceObjectAtIndex:4 withObject:[NSNumber numberWithFloat:totalD]];
        [self.appDelegate.userInfo.walkingAr replaceObjectAtIndex:5 withObject:[NSNumber numberWithFloat:totalT]];
    }
}

-(void)postMapTrackRecordWithArray:(NSArray *)ar{
    //解析Ar
    int count = (int)ar.count;
    
    NSString *uid = self.appDelegate.userInfo.uid;
    
    nDataBase *database = [[nDataBase alloc]init];

    int num;//record的记录条数
    num = (int)[[database loadDataFromLocalWithUserId:uid withEntity:@"Record"] count];
//    num += 1;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    for(int i = 0 ; i < count ; i++){
        NSArray *a = [ar objectAtIndex:i];
        int j;
        if([[a objectAtIndex:2]boolValue] == YES)
            j = 1;
        else
            j = 0;
        
        NSDictionary *dic = @{@"id":uid,
                              @"num":[NSNumber numberWithInt:num],
                              @"latitude":[a objectAtIndex:0],
                              @"longitude":[a objectAtIndex:1],
                              @"isExercise":[NSNumber numberWithInt:j],
                              @"method":@"post"};

        [manager POST:@"http://139.199.158.105/MapRecord.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            
            
        } failure:nil];

    }
    
}

-(int)GetCalorieWithType:(int)types withSeconds:(int)seconds withDistance:(double)distances{
    int c = 0;
    
    if(types == 0){
        //跑步热量（kcal）＝体重（kg）×运动时间（小时）×指数K
        //指数K＝30÷速度（分钟400米)
        float t = (float)seconds/ 3600;
        float k = 30 / (((400 / (float)(distances * 1000)) * ((float)seconds / 60)));
        c       = self.appDelegate.userInfo.weight * t * k;
    }
    else if(types == 1){
        float t = (float)seconds/ 3600;
        float v = distances / t;
        c       = self.appDelegate.userInfo.weight * v * 9.7 * t;
    }
    else if(types == 2){
        
        
    }
    return c;
}
-(NSString *)getDate{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss EE"];
    
    NSString *DateStr = [formatter stringFromDate:date];
    
    return DateStr;
}
-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}
@end

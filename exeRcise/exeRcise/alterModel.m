//
//  alterModel.m
//  exeRcise
//
//  Created by hemeng on 17/6/25.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "alterModel.h"
#import "nDataBase.h"

@implementation alterModel
-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}
-(void)updateNetWordWithDic:(NSDictionary *)dic{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://139.199.158.105/updateUserInfo.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
-(void)updateLocalDataWithDic:(NSDictionary *)dic{
    nDataBase *database= [[nDataBase alloc]init];
    
    if([[dic objectForKey:@"value"] isEqualToString:@"U"] || [[dic objectForKey:@"value"] isEqualToString:@"P"]){//用户名或密码
        
        [database updateUserWithUid:[dic objectForKey:@"id"]
                           withName:[dic objectForKey:@"username"]
                       withPassword:[dic objectForKey:@"password"]
                  withlastLoginTime:[dic objectForKey:@"lastLoginTime"]];
    }
    else if([[dic objectForKey:@"value"] isEqualToString:@"D"] || [[dic objectForKey:@"value"] isEqualToString:@"H"]){//每日目标
        
        [database updateUinfoWithUid:[dic objectForKey:@"id"]
                             withSex:[dic objectForKey:@"sex"]
                          withHeight:[[dic objectForKey:@"height"]intValue]
                          withWeight:[[dic objectForKey:@"weight"]intValue]
                            withAimC:[[dic objectForKey:@"aimC"]floatValue]
                            withAimD:[[dic objectForKey:@"aimD"]floatValue]
                            withAimT:[[dic objectForKey:@"aimT"]floatValue]];
    }
  
}
-(void)updateAppdelegateUserInfoWithDic:(NSDictionary *)dic{
    
    if([[dic objectForKey:@"value"] isEqualToString:@"U"] || [[dic objectForKey:@"value"] isEqualToString:@"P"]){
        self.appDelegate.userInfo.name = [dic objectForKey:@"username"];
        self.appDelegate.userInfo.password = [dic objectForKey:@"password"];
    }
    else if([[dic objectForKey:@"value"] isEqualToString:@"D"] || [[dic objectForKey:@"value"] isEqualToString:@"H"]){
        self.appDelegate.userInfo.height = [[dic objectForKey:@"height"]intValue];
        self.appDelegate.userInfo.weight = [[dic objectForKey:@"weight"]intValue];
        self.appDelegate.userInfo.aimC = [[dic objectForKey:@"aimC"]floatValue];
        self.appDelegate.userInfo.aimD = [[dic objectForKey:@"aimD"]floatValue];
        self.appDelegate.userInfo.aimT = [[dic objectForKey:@"aimT"]floatValue];
        
        ;
    }
}

@end

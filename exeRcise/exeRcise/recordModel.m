//
//  recordModel.m
//  exeRcise
//
//  Created by hemeng on 17/6/26.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "recordModel.h"
#import "nDataBase.h"

@implementation recordModel

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];;
}

-(NSArray *)GetRecordDataFromDataBase{
    nDataBase *database = [[nDataBase alloc]init];
    
    NSArray *Ar = [NSArray array];
    Ar = [database loadDataFromLocalWithUserId:self.appDelegate.userInfo.uid withEntity:@"Record"];
    
    return Ar;
}

-(NSArray *)GetRecordDataFromNetWork{//删除本地 从服务器上下载到本地
    nDataBase *database = [[nDataBase alloc]init];
    
    [database deleteRecord:self.appDelegate.userInfo.uid];
    
    for(int i = 0;i < ar.count; i++){
        
        NSDictionary *dic = [ar objectAtIndex:i];
        
        [database addRecordWithDic:dic];
    }
    
    NSArray *Ar = [NSArray array];
    Ar = [database loadDataFromLocalWithUserId:self.appDelegate.userInfo.uid withEntity:@"Record"];
    
    return Ar;
}
-(void)IsEqualToNetWorkData{
    
    NSString *uid = self.appDelegate.userInfo.uid;
    
    nDataBase *database = [[nDataBase alloc]init];
    
    NSArray *localAr = [database loadDataFromLocalWithUserId:uid withEntity:@"Record"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"id":uid};
    
    [manager POST:@"http://139.199.158.105/loadRecord.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {//主线程进行
        
        ar = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dic;
        
        if(localAr.count == ar.count){//如果不相同
            dic = @{@"isEqual":@"yes"};
        }
        else{
            dic = @{@"isEqual":@"no"};
        }
        NSNotification *noti = [NSNotification notificationWithName:@"AfterCompareRecord" object:nil userInfo:dic];
        
        [[NSNotificationCenter defaultCenter]postNotification:noti];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

@end

//
//  MapRecordModel.m
//  exeRcise
//
//  Created by hemeng on 17/6/27.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "MapRecordModel.h"
#import <UIKit+AFNetworking.h>

@implementation MapRecordModel

-(void)getMapTrackRecordWithUId:(NSString *)uid withRecordNum:(int)num withBlock:(void (^)(NSArray *ar))block{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"id":uid,
                          @"num":[NSNumber numberWithInt:num],
                          @"method":@"get"};
    
    //成功,失败 BLOCK代码afnetworking会切换到主线程来执行,但是,主线程已经被wait;等死了,这样afnetworking 在切换到主线程执行BLOCK的时候也会被等死,就死锁了
    
    [manager POST:@"http://139.199.158.105/MapRecord.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * ar = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //所以需要通过block回调方式传送数据 而不是通过return
        block(ar);
        
        //发送通知 通知controller数据传送完毕
        NSNotification *noti = [NSNotification notificationWithName:@"SuccessGetRecord" object:nil];

        [[NSNotificationCenter defaultCenter]postNotification:noti];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
@end

//
//  CommentModel.m
//  exeRcise
//
//  Created by hemeng on 17/7/12.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CommentModel.h"
#import "AppDelegate.h"

@implementation CommentModel

-(void)loadCommodityCommentWithCommodityInfo:(NSDictionary *)dic withUid:(NSString *)uid{
    
    NSDictionary *postDic = @{@"num":[dic objectForKey:@"num"],
                              @"category":[dic objectForKey:@"category"]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://139.199.158.105/loadComment.php" parameters:postDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *ar = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *returnAr = [NSMutableArray array];
        
        for(int i = 0; i < ar.count; i++){
            NSMutableArray *array = [NSMutableArray array];

            [array addObject:[dic objectForKey:@"num"]];
            [array addObject:[dic objectForKey:@"category"]];
            [array addObject:[[ar objectAtIndex:i] objectForKey:@"CommentUserId"]];
            [array addObject:[[ar objectAtIndex:i] objectForKey:@"CommentUserName"]];
            [array addObject:[[ar objectAtIndex:i] objectForKey:@"CommentDate"]];
            [array addObject:[[ar objectAtIndex:i] objectForKey:@"Comment"]];
            [array addObject:[[ar objectAtIndex:i] objectForKey:@"CommentId"]];
            
            [returnAr addObject:array];
        }
        
        [self loadUserImageWithAr:returnAr withUid:uid];
        
        self.returnComment(returnAr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)loadUserImageWithAr:(NSMutableArray *)ar withUid:(NSString *)uid{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableArray *imageAr = [NSMutableArray array];
    
    NSMutableArray *nameAr = [NSMutableArray array];
    
    for(int i = 0; i < ar.count; i++){
        NSString *userId = [[ar objectAtIndex:i] objectAtIndex:2];
        
        if(![userId isEqualToString:uid]){//表示本机用户不需要下载头像
            BOOL hasSameName = NO;
            //过滤掉相同名字的用户
            for(int i = 0; i < nameAr.count; i++){
                if([[nameAr objectAtIndex:i] isEqualToString:userId]){
                    //如果有相同的名字
                    hasSameName = YES;
                }
            }
            if(hasSameName == NO)
                [nameAr addObject:userId];
        }
    }
    for(int i = 0; i < nameAr.count; i++){
        NSMutableArray *Ar = [NSMutableArray array];
        
        NSString *imageName = [[nameAr objectAtIndex:i] stringByAppendingString:@".jpeg"];
        
        NSString *urlStr = [@"http://139.199.158.105/userImage/" stringByAppendingString:imageName];
        
        [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            UIImage *image = [UIImage imageWithData:responseObject];
            
            [Ar addObject:image];//加头像
            [Ar addObject:[nameAr objectAtIndex:i]];//加用户名
            
            [imageAr addObject:Ar];
            
            if(i == nameAr.count - 1)
                self.returnImage(imageAr);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];

    }
}

-(void)uploadCommodityCommentWithAr:(NSMutableArray *)ar{
    
    NSDictionary *dic = @{@"num":[ar objectAtIndex:0],
                          @"category":[ar objectAtIndex:1],
                          @"id":[ar objectAtIndex:2],
                          @"name":[ar objectAtIndex:3],
                          @"date":[ar objectAtIndex:4],
                          @"comment":[ar objectAtIndex:5]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://139.199.158.105/insertCommodityComment.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end

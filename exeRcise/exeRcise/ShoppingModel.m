//
//  ShoppingModel.m
//  exeRcise
//
//  Created by hemeng on 17/7/7.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ShoppingModel.h"

@implementation ShoppingModel

-(void)getItemNumWithItemStr:(NSString *)str{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"item":str};
    
    [manager POST:@"http://139.199.158.105/getShoppingItemNum.php" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *ar = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        self.returnArray(ar);
        
        NSNotification *noti = [NSNotification notificationWithName:@"finishLoadItemInfo" object:nil];
        
        [[NSNotificationCenter defaultCenter]postNotification:noti];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
-(void)getCoverImageWithCategory:(NSString *)category withNumber:(int)num{//num 表示item总数
    
    NSString *first;
    
    if([category isEqualToString:@"mountainBicycle"]
       || [category isEqualToString:@"roadBicycle"]
       || [category isEqualToString:@"smallWheelBicycle"]){
        first = @"bicycle";
    }
    else if([category isEqualToString:@"ballWear"] || [category isEqualToString:@"ballUniform"]){
        first = @"uniform";
    }
    else if([category isEqualToString:@"basketballShoes"] || [category isEqualToString:@"footballShoes"]){
        first = @"shoes";
    }
    else if([category isEqualToString:@"basketball"] || [category isEqualToString:@"football"]){
        first = @"ball";
    }
    else if([category isEqualToString:@"dumbbell"]){
        first = @"equipment";
    }
    
    NSMutableArray *imageAr = [NSMutableArray array];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *str = [NSString stringWithFormat:@"%@/%@/cover/",first,category];
    
    NSString *url = [@"http://139.199.158.105/commodityImage/" stringByAppendingString:str];
    
    for(int i = 0 ; i < num ; i++){
        
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg",i + 1];
        
        NSString *urlStr = [url stringByAppendingString:imageName];
        
        [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            UIImage *image = [UIImage imageWithData:responseObject];
            
            [imageAr addObject:image];
            
            if(imageAr.count == num){
                
                NSLog(@"i:%d",i);
                
                self.returnImageAr(imageAr);
                
                NSNotification *noti = [NSNotification notificationWithName:@"finishLoadImage" object:nil];
                
                [[NSNotificationCenter defaultCenter]postNotification:noti];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
    }
    
}
@end

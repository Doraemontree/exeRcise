//
//  CartComoodityModel.m
//  exeRcise
//
//  Created by hemeng on 17/7/10.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CartComoodityModel.h"
#import "AppDelegate.h"

@implementation CartComoodityModel

-(void)updateNetWorkCartCommodityInfoWithCommodityInfo:(NSArray *)infoAr withOperation:(NSString *)operation withId:(NSString *)uid{
    NSDictionary *dic = @{@"operation":operation,
                          @"id":uid,
                          @"num":[infoAr objectAtIndex:0],
                          @"name":[infoAr objectAtIndex:1],
                          @"quantity":[infoAr objectAtIndex:2],
                          @"size":[infoAr objectAtIndex:4],
                          @"color":[infoAr objectAtIndex:5]};
    
    NSLog(@"%@",dic);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://139.199.158.105/updateCartCommodityInfo.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)uploadPurchaseCommodityWithDic:(NSDictionary *)dic{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://139.199.158.105/insertPurchaseRecord.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}
    


@end

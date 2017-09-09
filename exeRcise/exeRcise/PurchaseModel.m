//
//  PurchaseModel.m
//  exeRcise
//
//  Created by hemeng on 17/7/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "PurchaseModel.h"
#import "AppDelegate.h"
#import "CartModel.h"

@implementation PurchaseModel

-(void)getItemDetailImageWithCategory:(NSString *)category withItemNumber:(int)num{//表示item序号
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
    
    
    NSString *str = [NSString stringWithFormat:@"%@/%@/content/",first,category];
    
    NSString *url = [@"http://139.199.158.105/commodityImage/" stringByAppendingString:str];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableArray *imageAr = [NSMutableArray array];
    
    for(int i = 0; i < 3; i++){
        NSString *imageStr = [NSString stringWithFormat:@"%d-%d.jpg",num,i + 1];
        NSString *urlStr = [url stringByAppendingString:imageStr];
        [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            UIImage *image = [UIImage imageWithData:responseObject];
            [imageAr addObject:image];
            if(imageAr.count == 3){
                self.returnImageArray(imageAr);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

-(void)getCommoditySizeWithNum:(int)num{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"num":@(num)};
    
    [manager POST:@"http://139.199.158.105/getCommoditySize.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *ar = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        self.returnSizeArray(ar);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(void)getCommodityColorWithNum:(int)num{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"num":@(num)};
    
    [manager POST:@"http://139.199.158.105/getCommodityColor.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *ar = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        self.returnColorArray(ar);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(void)insertCommodityToCart:(NSDictionary *)commodityInfo{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://139.199.158.105/insertCommodity.php" parameters:commodityInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(void)loadCartCommodityInfoInsertIntoCartModelWithId:(NSString *)uid{
    
    [self getCartCommodityInfoWithId:uid];
}

-(void)getCartCommodityInfoWithId:(NSString *)uid{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSDictionary *dic = @{@"id":uid};
    
    [manager POST:@"http://139.199.158.105/loadCartCommodity.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *ar = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if(ar){//如果不为空
            NSMutableArray *categoryAr= [NSMutableArray array];
            NSMutableArray *numAr = [NSMutableArray array];
            
            for(int i = 0 ; i < ar.count; i++){
                [categoryAr addObject:[[ar objectAtIndex:i] objectForKey:@"category"]];
                [numAr addObject:[[ar objectAtIndex:i] objectForKey:@"num"]];
            }
            [self getCartCommodityCoverImageWithCommodityInfo:ar CommodityNumAr:numAr withCategory:categoryAr];
        }
        else{
            self.successLoadInfo();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
-(void)getCartCommodityCoverImageWithCommodityInfo:(NSArray *)infoAr CommodityNumAr:(NSMutableArray *)numAr withCategory:(NSMutableArray *)categoryAr{
    
    for(int i = 0; i < infoAr.count; i++){
        NSString *first;
        if([[categoryAr objectAtIndex:i] isEqualToString:@"mountainBicycle"] ||
           [[categoryAr objectAtIndex:i] isEqualToString:@"roadBicycle"] ||
           [[categoryAr objectAtIndex:i] isEqualToString:@"smallWheelBicycle"]){
            first = @"bicycle";
        }
        else if([[categoryAr objectAtIndex:i] isEqualToString:@"ballWear"] ||
                [[categoryAr objectAtIndex:i] isEqualToString:@"ballUniform"]){
            first = @"uniform";
        }
        else if([[categoryAr objectAtIndex:i] isEqualToString:@"basketballShoes"] ||
                [[categoryAr objectAtIndex:i] isEqualToString:@"footballShoes"]){
            first = @"shoes";
        }
        else if([[categoryAr objectAtIndex:i] isEqualToString:@"basketball"] ||
                [[categoryAr objectAtIndex:i] isEqualToString:@"football"]){
            first = @"ball";
        }
        else if([[categoryAr objectAtIndex:i] isEqualToString:@"dumbbell"]){
            first = @"equipment";
        }
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *str = [NSString stringWithFormat:@"%@/%@/cover/%@.jpg",first,[categoryAr objectAtIndex:i],[numAr objectAtIndex:i]];
        
        NSString *url = [@"http://139.199.158.105/commodityImage/" stringByAppendingString:str];
        
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            UIImage *image = [UIImage imageWithData:responseObject];
            
            NSMutableArray *commodity = [NSMutableArray array];
            
            [commodity addObject:[[infoAr objectAtIndex:i] objectForKey:@"num"]];
            [commodity addObject:[[infoAr objectAtIndex:i] objectForKey:@"name"]];
            [commodity addObject:[[infoAr objectAtIndex:i] objectForKey:@"quantity"]];
            [commodity addObject:[[infoAr objectAtIndex:i] objectForKey:@"price"]];
            [commodity addObject:[[infoAr objectAtIndex:i] objectForKey:@"size"]];
            [commodity addObject:[[infoAr objectAtIndex:i] objectForKey:@"color"]];
            [commodity addObject:image];
            
            CartModel *cart = [CartModel shareCartModel];
            
            [cart.CartCommodity addObject:commodity];
            
            if(i == infoAr.count - 1){
                self.successLoadInfo();
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}
@end

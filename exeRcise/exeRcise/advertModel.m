//
//  advertModel.m
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "advertModel.h"

@implementation advertModel

-(void)getAdvertImageWithNum:(int)num{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"http://139.199.158.105/advertisement/adcontent%d.jpg",num + 1];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        UIImage *image = [UIImage imageWithData:responseObject];
        
        self.returnImage(image);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

@end

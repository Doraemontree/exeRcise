//
//  shopModel.m
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "shopModel.h"

@implementation shopModel

-(void)getAdvertisementCoverImage{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableArray *ImageAr = [NSMutableArray array];
    
    for(int i = 0 ;i < 3; i++){
        
        NSString *str = [NSString stringWithFormat:@"adtitle%d.jpg",i + 1];
        
        NSString *url = [@"http://139.199.158.105/advertisement/" stringByAppendingString:str];
        
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            UIImage *image = [UIImage imageWithData:responseObject];
            
            [ImageAr addObject:image];
            
            if(ImageAr.count == 3)
                self.returnImagerAr(ImageAr);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
    
}

@end

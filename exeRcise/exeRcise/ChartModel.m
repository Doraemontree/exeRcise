//
//  ChartModel.m
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ChartModel.h"

@implementation ChartModel

-(void)getRecordWithUId:(NSString *)uid{
    
    NSDictionary *dic = @{@"id":uid};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://139.199.158.105/loadRecord.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *ar = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        self.returnRecord(ar);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

@end

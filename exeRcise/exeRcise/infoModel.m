//
//  infoModel.m
//  exeRcise
//
//  Created by hemeng on 17/6/24.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "infoModel.h"
#import <UIImageView+AFNetworking.h>

@implementation infoModel

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

-(BOOL)updateUserImageOnNetWorkWith:(NSData *)imageData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    __block BOOL judge = YES;
    
    [manager POST:@"http://139.199.158.105/UserImage.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //NSData *imageData = UIImageJPEGRepresentation(image,0.5);
        NSString *fileName = [NSString stringWithFormat:@"%@.jpeg", self.appDelegate.userInfo.uid];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *r = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if([r isEqualToString:@"toolarge"]){
            NSLog(@"图片太大");
            judge = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code == -1001){
            NSLog(@"网络错误");
        }
        else{
            NSLog(@"%@",error);
        }
        judge = NO;
    }];
    if(judge == YES)
        return YES;
    else
        return NO;
    
}
@end

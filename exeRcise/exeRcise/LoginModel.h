//
//  LoginModel.h
//  exeRcise
//
//  Created by hemeng on 17/6/19.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface LoginModel : NSObject

-(BOOL)isUserDataExistInLocalWithUid:(NSString *)uid;

-(void)addAllDataToLocalWithUdic:(NSDictionary *)Udic
                        withIdic:(NSDictionary *)Idic
                        withWdic:(NSDictionary *)Wdic
                        withRdic:(NSDictionary *)Rdic
                        withCdic:(NSDictionary *)Cdic;

-(nUserInfo *)GetUserInfoWithUid:(NSString *)uid;
@end

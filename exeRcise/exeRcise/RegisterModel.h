//
//  RegisterModel.h
//  exeRcise
//
//  Created by hemeng on 17/6/19.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface RegisterModel : NSObject


-(void)addDataToLocalDataBaseWithUserDic:(NSDictionary *)dic;

-(nUserInfo *)setUserInfoWithUserInfoDic:(NSDictionary *)dic;//设置appdelegate的userinfo的值



@end

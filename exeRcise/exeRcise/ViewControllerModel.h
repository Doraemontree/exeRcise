//
//  ViewControllerModel.h
//  exeRcise
//
//  Created by hemeng on 17/6/19.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ViewControllerModel : NSObject

@property(nonatomic,strong)AppDelegate *appDelegate;

-(nUserInfo *)GetUserInfo:(NSString *)uid;

-(void)DownloadUserImageTolocalWithUid:(NSString *)uid;

-(void)autoUpdateLastLoginTimeAndTodayCDT;//自动检测最后登录时间 在读取本地或服务器数据后对比登录时间 后更新todayCDT数据



@end

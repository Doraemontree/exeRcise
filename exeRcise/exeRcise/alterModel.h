//
//  alterModel.h
//  exeRcise
//
//  Created by hemeng on 17/6/25.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface alterModel : NSObject

@property(nonatomic,strong)AppDelegate *appDelegate;

-(void)updateNetWordWithDic:(NSDictionary *)dic;

-(void)updateLocalDataWithDic:(NSDictionary *)dic;

-(void)updateAppdelegateUserInfoWithDic:(NSDictionary *)dic;

@end

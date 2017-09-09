//
//  RunModel.h
//  exeRcise
//
//  Created by hemeng on 17/6/21.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface RunModel : NSObject

@property(nonatomic,strong)AppDelegate *appDelegate;

-(void)UpdateDataToLocalWithExerciseType:(int)type withDic:(NSDictionary *)dic;

-(void)UpdateDataToNetWorkWithExerciseType:(int)type withDic:(NSDictionary *)dic;

-(void)updataUserInfoWithExerciseType:(int)type withDic:(NSDictionary *)dic;

-(void)postMapTrackRecordWithArray:(NSArray *)ar;

-(int)GetCalorieWithType:(int)types withSeconds:(int)seconds withDistance:(double)distances;
@end

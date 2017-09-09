//
//  exerciseModel.m
//  exeRcise
//
//  Created by hemeng on 17/6/23.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "exerciseModel.h"


@implementation exerciseModel

//param type 0代表 卡路里 2表示时间 1表示距离
-(float)calculatePercentageWithType:(int)type withAimFloat:(float)aFloat{
 
    float aim;
    
    aim = ([[self.appDelegate.userInfo.runningAr objectAtIndex:type] floatValue] + [[self.appDelegate.userInfo.cyclingAr objectAtIndex:type] floatValue] + [[self.appDelegate.userInfo.walkingAr objectAtIndex:type] floatValue])/aFloat;

    if(aim > 1)
        aim = 1;
    
    NSLog(@"%f",aim);
    return aim;
}

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

@end

//
//  exerciseModel.h
//  exeRcise
//
//  Created by hemeng on 17/6/23.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface exerciseModel : NSObject

@property(nonatomic,strong)AppDelegate *appDelegate;

-(float)calculatePercentageWithType:(int)type withAimFloat:(float)aFloat;

@end

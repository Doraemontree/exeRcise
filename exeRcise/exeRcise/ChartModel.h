//
//  ChartModel.h
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ChartModel : NSObject

@property(nonatomic,strong)void (^returnRecord)(NSArray *);

-(void)getRecordWithUId:(NSString *)uid;

@end

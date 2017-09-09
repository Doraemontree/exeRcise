//
//  MapRecordModel.h
//  exeRcise
//
//  Created by hemeng on 17/6/27.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface MapRecordModel : NSObject

@property(nonatomic,strong)AppDelegate *appDelegate;

-(void)getMapTrackRecordWithUId:(NSString *)uid withRecordNum:(int)num withBlock:(void (^)(NSArray *ar))block;

@end

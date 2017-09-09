//
//  recordModel.h
//  exeRcise
//
//  Created by hemeng on 17/6/26.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface recordModel : NSObject{
    NSArray *ar;
}

@property(nonatomic,strong)AppDelegate *appDelegate;

-(NSArray *)GetRecordDataFromDataBase;

-(void)IsEqualToNetWorkData;

-(NSArray *)GetRecordDataFromNetWork;

@end

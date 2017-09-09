//
//  infoModel.h
//  exeRcise
//
//  Created by hemeng on 17/6/24.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface infoModel : NSObject

@property(nonatomic,strong)AppDelegate *appDelegate;


-(BOOL)updateUserImageOnNetWorkWith:(NSData *)imageData;

@end

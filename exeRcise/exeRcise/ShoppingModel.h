//
//  ShoppingModel.h
//  exeRcise
//
//  Created by hemeng on 17/7/7.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ShoppingModel : NSObject

@property(nonatomic,strong)void (^returnArray)(NSArray *ar);

@property(nonatomic,strong)void (^returnImageAr)(NSMutableArray *ar);

-(void)getItemNumWithItemStr:(NSString *)str;

-(void)getCoverImageWithCategory:(NSString *)category withNumber:(int)num;

@end

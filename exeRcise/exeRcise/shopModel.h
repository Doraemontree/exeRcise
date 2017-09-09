//
//  shopModel.h
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface shopModel : NSObject

@property(nonatomic,strong)void (^returnImagerAr)(NSMutableArray *);

-(void)getAdvertisementCoverImage;

@end

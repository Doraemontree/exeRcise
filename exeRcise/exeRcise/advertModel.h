//
//  advertModel.h
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface advertModel : NSObject

@property(nonatomic,strong)void (^returnImage)(UIImage *);

-(void)getAdvertImageWithNum:(int)num;

@end

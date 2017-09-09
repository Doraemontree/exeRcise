//
//  CartModel.m
//  exeRcise
//
//  Created by hemeng on 17/7/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CartModel.h"

@implementation CartModel

static CartModel *_instance;

+(instancetype)shareCartModel{
    return [[self alloc]init];
}

- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        
        self.CartCommodity = [NSMutableArray array];
        
    });
    return _instance;
}

-(void)clearCart{
    [self.CartCommodity removeAllObjects];
}

@end

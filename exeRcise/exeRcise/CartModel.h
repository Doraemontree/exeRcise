//
//  CartModel.h
//  exeRcise
//
//  Created by hemeng on 17/7/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartModel : NSObject

/*
 保存购物车的所有信息
 是一个单例类
 */
+(instancetype)shareCartModel;

/*num name quantity price size color coverImage*/
@property(nonatomic,strong)NSMutableArray *CartCommodity;

-(void)clearCart;

@end

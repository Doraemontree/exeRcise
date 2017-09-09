//
//  PurchaseModel.h
//  exeRcise
//
//  Created by hemeng on 17/7/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PurchaseModel : NSObject

@property(nonatomic,strong)void (^returnImageArray)(NSMutableArray *);

@property(nonatomic,strong)void (^returnSizeArray)(NSArray *);

@property(nonatomic,strong)void (^returnColorArray)(NSArray *);

-(void)getItemDetailImageWithCategory:(NSString *)category withItemNumber:(int)num;

-(void)getCommoditySizeWithNum:(int)num;

-(void)getCommodityColorWithNum:(int)num;

-(void)insertCommodityToCart:(NSDictionary *)commodityInfo;

@property(nonatomic,strong)void (^successLoadInfo)(void);

-(void)loadCartCommodityInfoInsertIntoCartModelWithId:(NSString *)uid;

@end


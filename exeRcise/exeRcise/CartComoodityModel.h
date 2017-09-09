//
//  CartComoodityModel.h
//  exeRcise
//
//  Created by hemeng on 17/7/10.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CartComoodityModel : NSObject

-(void)updateNetWorkCartCommodityInfoWithCommodityInfo:(NSArray *)infoAr
                                         withOperation:(NSString *)operation
                                                withId:(NSString *)uid;

-(void)uploadPurchaseCommodityWithDic:(NSDictionary *)dic;

@end

//
//  CommentModel.h
//  exeRcise
//
//  Created by hemeng on 17/7/12.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property(nonatomic,strong)void (^returnComment)(NSArray *);

@property(nonatomic,strong)void (^returnImage)(NSArray *);

-(void)loadCommodityCommentWithCommodityInfo:(NSDictionary *)dic withUid:(NSString *)uid;

-(void)uploadCommodityCommentWithAr:(NSMutableArray *)ar;

@end

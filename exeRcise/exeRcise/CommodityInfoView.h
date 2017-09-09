//
//  CommodityInfoView.h
//  exeRcise
//
//  Created by hemeng on 17/7/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityInfoView : UIView{
    NSString *str;//折扣前价格字符串长度
}

- (instancetype)initWithFrame:(CGRect)frame
                   withCprice:(NSString *)price
                withCdiscount:(NSString *)discount
                    withCname:(NSString *)name
               withCintroduce:(NSString *)introduce;

@end

//
//  CommoditySizeColorVIew.h
//  exeRcise
//
//  Created by hemeng on 17/7/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommoditySizeColorVIew : UIView

@property(nonatomic,assign)int sizeBtnTag;//所选取的size按钮的tag值

@property(nonatomic,assign)int colorBtnTag;//所选取的color按钮的tag值

-(void)refreshSizeColorBtnWithSizeAr:(NSArray *)array withcOs:(NSString *)cOs;

- (instancetype)initWithFrame:(CGRect)frame withColorOrSize:(NSString *)cOs;

@end

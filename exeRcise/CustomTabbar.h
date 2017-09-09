//
//  CustomTabbar.h
//  exeRcise
//
//  Created by hemeng on 17/4/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabbar;

@protocol CustomTabbarDelegate <NSObject>

-(void)tabbarDidClickButton:(CustomTabbar *)view withButtonNumber:(int)num;

@end

@interface CustomTabbar : UIView

@property(nonatomic,strong)UIButton *middle;
@property(nonatomic,strong)UIButton *left;
@property(nonatomic,strong)UIButton *right;

@property(nonatomic,weak)id<CustomTabbarDelegate>delegate;

@end

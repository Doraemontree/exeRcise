//
//  CartViewController.h
//  exeRcise
//
//  Created by hemeng on 17/7/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PayView.h"

@interface CartViewController : UIViewController

- (instancetype)initWithLastVcIsPurchaseVc:(BOOL)flag;

@property(nonatomic,strong)void (^returnCartCommodityNum)(int);

@property(nonatomic,strong)AppDelegate *appDelegate;

@property(nonatomic,strong)PayView *payView;

@property(nonatomic,strong)UIImageView *blurView;//模糊view


@end

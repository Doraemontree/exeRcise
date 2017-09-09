//
//  ViewController.h
//  exeRcise
//
//  Created by hemeng on 17/4/19.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabbar.h"
#import "MainView.h"
#import "UserView.h"
#import "MultfunctionView.h"
#import "POP.h"

@interface ViewController : UIViewController<CustomTabbarDelegate,UserViewDelegate>

@property(nonatomic,strong)CustomTabbar *Ctabbar;

@property(nonatomic,strong)MainView *mainView;

@property(nonatomic,strong)UserView *userView;

@property(nonatomic,strong)MultfunctionView *multfunctionView;

@end


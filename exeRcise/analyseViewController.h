//
//  analyseViewController.h
//  exeRcise
//
//  Created by hemeng on 17/5/15.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalyseView.h"

@interface analyseViewController : UIViewController

@property(nonatomic,strong)UIButton *running;

@property(nonatomic,strong)UIButton *cycling;

@property(nonatomic,strong)UIButton *walking;

@property(nonatomic,strong)AnalyseView *r_analyse;

@property(nonatomic,strong)AnalyseView *c_analyse;

@property(nonatomic,strong)AnalyseView *w_analyse;

@property(nonatomic,strong)UIImageView *background;

@property(nonatomic,strong)NSArray *recordAr;//存放读取出来的纪录



@end

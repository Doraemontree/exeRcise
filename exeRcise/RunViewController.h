//
//  RunViewController.h
//  exeRcise
//
//  Created by hemeng on 17/4/21.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapView.h"
#import "ResultView.h"
#import "AppDelegate.h"
#import "StopButton.h"
#import "POP.h"

@interface RunViewController : UIViewController

@property(nonatomic,strong)UILabel *L_timer;

@property(nonatomic,strong)UIImageView *background;

@property(nonatomic,strong)UILabel *L_distance;

@property(nonatomic,strong)UIButton *PauseBtn;//暂停按钮

@property(nonatomic,strong)StopButton *stopBtn;//停止按钮

@property(nonatomic,strong)UIButton *ToMapBtn;//显示地图

@property(nonatomic,strong)UIButton *startBtn;//开始按钮

@property(nonatomic,strong)mapView *map;//地图

@property(nonatomic,strong)NSTimer *timer;//计时器

@property(nonatomic,strong)ResultView *result;//结算界面

@property(nonatomic,strong)UIImageView *blurView;

@property(nonatomic,strong)AppDelegate *appDelegate;

@property(nonatomic,strong)UILabel *velocity;//跑步是配速 骑车是平均速度 步行是平均速度

- (instancetype)initWithCellNum:(int)num;

@end

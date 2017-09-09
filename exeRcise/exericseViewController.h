//
//  exericseViewController.h
//  exeRcise
//
//  Created by hemeng on 17/4/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customRect.h"

@interface exericseViewController : UIViewController

@property(nonatomic,strong)UIImageView *background;

@property(nonatomic,strong)UIView *circleView;
@property(nonatomic,strong)CAShapeLayer *circleShapeRun;

@property(nonatomic,strong)customRect *rect;

@property(nonatomic,strong)UIButton *goBtn;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *setBtn;
@property(nonatomic,strong)UIButton *setCalorie;
@property(nonatomic,strong)UIButton *setTime;
@property(nonatomic,strong)UIButton *setDistance;
@property(nonatomic,strong)UIButton *setAim;

@property(nonatomic)float Acaloire;
@property(nonatomic)float Adistance;
@property(nonatomic)float Atime;

-(instancetype)initWithCellNumber:(int)num;

@end

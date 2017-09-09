//
//  ResultView.h
//  exeRcise
//
//  Created by hemeng on 17/5/1.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "POP.h"
@class ResultView;
@protocol ResultViewDelegate <NSObject>

-(void)didClickConfirmBtn:(ResultView *)view;

@end

@interface ResultView : UIImageView{
    double distances;//公里
    int seconds;//分钟
    int calories;//单位大卡
    int types;
    
}

@property(nonatomic,strong)AppDelegate *appDelegate;

@property(nonatomic,strong)UILabel *L_distance;

@property(nonatomic,strong)UILabel *L_calorie;

@property(nonatomic,strong)UILabel *L_time;

@property(nonatomic,strong)UIButton *confrimBtn;

@property(nonatomic,strong)UIImageView *blurView;

@property(nonatomic,weak)id<ResultViewDelegate>delegate;

- (instancetype)initWithTime:(int)second
                withDistance:(double)distance
                 withCalorie:(int)calorie
                    withType:(int)type;

@end

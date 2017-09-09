//
//  ChartView.h
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartView : UIView

@property(nonatomic,strong)UIView *view1;

@property(nonatomic,strong)UIView *view2;

@property(nonatomic,strong)UIView *view3;

@property(nonatomic,strong)UIView *view4;

@property(nonatomic,strong)UIView *view5;

@property(nonatomic,strong)UIView *view6;

@property(nonatomic,strong)UIView *view7;

-(void)ViewAnimationWithDataOne:(float)one
                            two:(float)two
                          three:(float)three
                           four:(float)four
                           five:(float)five
                            six:(float)six
                          seven:(float)seven;

- (instancetype)initWithFrame:(CGRect)frame withTodayDate:(NSDate *)date;

@end

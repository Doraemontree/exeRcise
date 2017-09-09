//
//  customRect.m
//  exeRcise
//
//  Created by hemeng on 17/5/8.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "customRect.h"

@implementation customRect


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 85, 30);
    
    CGContextAddLineToPoint(context, self.bounds.size.width - 10, 30);
    
    CGContextAddLineToPoint(context, self.bounds.size.width - 10, 350);
    
    CGContextAddArc(context, 175, 350, 170, Arc(0), Arc(180), 0);
    
    CGContextAddLineToPoint(context, 5, 30);
    
    CGContextMoveToPoint(context, 50, 190);
    
    CGContextAddLineToPoint(context, self.bounds.size.width - 10, 190);
    
    CGContextSetLineWidth(context, 1.f);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetLineCap(context, kCGLineCapRound);

    [[UIColor blackColor]set];
    
    CGContextStrokePath(context);
    
}
//角度转弧度
CGFloat Arc(CGFloat angle){
    return angle * (M_PI / 180);
    
}
-(void)CreateLabel{
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 90, 30)];
    title1.text = @"今日成果";
    [title1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 175, 70, 30)];
    title2.text = @"目标";
    [title2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    
    [self addSubview:title1];
    [self addSubview:title2];
}
-(UILabel *)aim{
    if(!_aim){
        _aim = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - 95, 210, 135, 30)];
        _aim.text = @"卡 路 里(大卡):";
        _aim.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_aim];
    }
    return _aim;
}
-(UILabel *)aim_num{
    if(!_aim_num){
        _aim_num = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 + 30, 210, 70, 30)];
        _aim_num.text = @"0";
        _aim_num.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_aim_num];
    }
    return _aim_num;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self CreateLabel];
        
        [self calorie];
        
        [self distance];
        
        [self time];
        
        [self aim];
        
        [self aim_num];

    }
    return self;
}

-(UILabel *)calorie{
    if(!_calorie){
        
        _calorie               = [[UILabel alloc]initWithFrame:CGRectMake(155, 28, 100, 50)];
        _calorie.text          = @"0";
        _calorie.font          = [UIFont systemFontOfSize:30];
        _calorie.textAlignment = NSTextAlignmentRight;
        
        UILabel *calorieStr      = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 250, 50)];
        calorieStr.text          = @"今日已经消耗了                      大卡";
        calorieStr.textColor     = [UIColor grayColor];
        calorieStr.font          = [UIFont systemFontOfSize:16];
        calorieStr.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_calorie];
        [self addSubview:calorieStr];
    }
    return _calorie;
}
-(UILabel *)distance{
    if(!_distance){
        
        _distance               = [[UILabel alloc]initWithFrame:CGRectMake(155, 73, 100, 50)];
        _distance.text          = @"0";
        _distance.font          = [UIFont systemFontOfSize:30];
        _distance.textAlignment = NSTextAlignmentRight;
        
        UILabel *distanceStr      = [[UILabel alloc]initWithFrame:CGRectMake(50, 75, 250, 50)];
        distanceStr.text          = @"今日已经前进了                      公里";
        distanceStr.textColor     = [UIColor grayColor];
        distanceStr.font          = [UIFont systemFontOfSize:16];
        distanceStr.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_distance];
        [self addSubview:distanceStr];
    }
    return _distance;
}
-(UILabel *)time{
    if(!_time){
        
        _time               = [[UILabel alloc]initWithFrame:CGRectMake(155, 118, 100, 50)];
        _time.text          = @"0";
        _time.font          = [UIFont systemFontOfSize:30];
        _time.textAlignment = NSTextAlignmentRight;
        
        UILabel *timeStr      = [[UILabel alloc]initWithFrame:CGRectMake(50, 120, 250, 50)];
        timeStr.text          = @"今日已经运动了                      分钟";
        timeStr.textColor     = [UIColor grayColor];
        timeStr.font          = [UIFont systemFontOfSize:16];
        timeStr.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:timeStr];
        [self addSubview:_time];
    }
    return _time;
}

@end

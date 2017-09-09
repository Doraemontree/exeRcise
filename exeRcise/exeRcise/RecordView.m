//
//  RecordView.m
//  exeRcise
//
//  Created by hemeng on 17/5/3.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "RecordView.h"
#import "AppDelegate.h"

@implementation RecordView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 0, 40);
    
    CGContextAddLineToPoint(context, self.bounds.size.width, 40);
    
    CGContextSetLineWidth(context, 1.f);
    
    [[UIColor blackColor]set];
    
    CGContextStrokePath(context);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self title];
        
        [self todayDate];
        
        [self L_distance];
        
        [self front];
        
        [self back];
        
        [self exerciseType];
        
        [self detail];
        
    }
    return self;
}
-(UILabel *)todayDate{
    if(!_todayDate){
        _todayDate           = [[UILabel alloc]initWithFrame:CGRectMake(20, 33, 100, 30)];
        _todayDate.font      = [UIFont systemFontOfSize:13];
        _todayDate.textColor = [UIColor grayColor];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        //_todayDate.text = [formatter stringFromDate:self.appDelegate.UserInfoM.todayDate];
        
        [self addSubview:_todayDate];
    }
    return _todayDate;
}
-(UILabel *)title{
    if(!_title){
        _title      = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 30)];
        _title.text = @"运动记录";
        
        [self addSubview:_title];
    }
    return _title;
}
-(UILabel *)L_distance{
    if(!_L_distance){
        _L_distance           = [[UILabel alloc]initWithFrame:CGRectMake(155, 56, 200, 50)];
        _L_distance.font      = [UIFont systemFontOfSize:35];
        _L_distance.textColor = [UIColor blueColor];
       // _L_distance.text      = [NSString stringWithFormat:@"%.2f",self.appDelegate.UserInfoM.R_todayDistance];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 66, 290, 40)];
        label.text     = @"今日运动距离:                             千米";
        label.font     = [UIFont systemFontOfSize:17];
        
        [self addSubview:label];
        [self addSubview:_L_distance];
    }
    return  _L_distance;
}
-(UIButton *)front{
    if(!_front){
        _front        = [UIButton buttonWithType:UIButtonTypeCustom];
        _front.frame  = CGRectMake(0, 0, 20, 20);
        _front.center = CGPointMake(310, 20);

        [_front setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_front setTitle:@">" forState:UIControlStateNormal];
        [_front addTarget:self action:@selector(frontAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_front];
    }
    return  _front;
}
-(UIButton *)back{
    if(!_back){
        _back        = [UIButton buttonWithType:UIButtonTypeCustom];
        _back.frame  = CGRectMake(0, 0, 20, 20);
        _back.center = CGPointMake(230, 20);

        [_back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_back setTitle:@"<" forState:UIControlStateNormal];
        [_back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_back];
    }
    return _back;
}
-(UIButton *)detail{
    if(!_detail){
        _detail                 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 220, 35)];
        _detail.center          = CGPointMake(self.bounds.size.width/2, 130);
        _detail.backgroundColor = [UIColor colorWithRed:60/255.0 green:104/255.0 blue:175/255.0 alpha:1];
        
        [_detail setTitle:@"点击此处查看详细记录" forState:UIControlStateNormal];
        [_detail addTarget:self action:@selector(detailBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_detail];
        
    }
    return _detail;
}
-(UILabel *)exerciseType{
    if(!_exerciseType){
        _exerciseType        = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        _exerciseType.center = CGPointMake(285, 20);
        _exerciseType.text   = @"跑步";
        
        [self addSubview:_exerciseType];
    }
    return _exerciseType;
}
-(void)frontAction{
    if([_exerciseType.text isEqualToString:@"跑步"]){
       // _L_distance.text   = [NSString stringWithFormat:@"%.2f",self.appDelegate.UserInfoM.C_todayDistance];
        _exerciseType.text = @"骑行";
    }
    else if([_exerciseType.text isEqualToString:@"骑行"]){
        //_L_distance.text   = [NSString stringWithFormat:@"%.2f",self.appDelegate.UserInfoM.W_todayDistance];
        _exerciseType.text = @"步行";
    }
    else if([_exerciseType.text isEqualToString:@"步行"]){
        //_L_distance.text   = [NSString stringWithFormat:@"%.2f",self.appDelegate.UserInfoM.R_todayDistance];
        _exerciseType.text = @"跑步";
    }
    
}
-(void)backAction{
    if([_exerciseType.text isEqualToString:@"跑步"]){
       // _L_distance.text = [NSString stringWithFormat:@"%.2f",self.appDelegate.UserInfoM.W_todayDistance];
        _exerciseType.text = @"步行";
    }
    else if([_exerciseType.text isEqualToString:@"骑行"]){
        //_L_distance.text = [NSString stringWithFormat:@"%.2f",self.appDelegate.UserInfoM.R_todayDistance];
        _exerciseType.text = @"跑步";
    }
    else if([_exerciseType.text isEqualToString:@"步行"]){
        //_L_distance.text = [NSString stringWithFormat:@"%.2f",self.appDelegate.UserInfoM.C_todayDistance];
        _exerciseType.text = @"骑行";
    }

}
-(void)detailBtnAction{
    
    NSNotification *notication = [NSNotification notificationWithName:@"openRecordController" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter]postNotification:notication];
    
}
-(void)refreshRecordView{
   // _L_distance.text   = [NSString stringWithFormat:@"%.2f",self.appDelegate.UserInfoM.C_todayDistance];
    _exerciseType.text = @"骑行";
}

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}
@end

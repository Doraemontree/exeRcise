//
//  ResultView.m
//  exeRcise
//
//  Created by hemeng on 17/5/1.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ResultView.h"

@implementation ResultView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (instancetype)initWithTime:(int)second
                withDistance:(double)distance
                 withCalorie:(int)calorie
                    withType:(int)type//km type指运动类型
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        seconds   = second;
        distances = distance;
        types     = type;
        calories  = calorie;
        [self L_calorie];
        [self L_time];
        [self L_distance];
        [self confrimBtn];
        
        [self performSelector:@selector(DOAnimation) withObject:nil afterDelay:1.f];
       
    }
    return self;
}

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

-(UILabel *)L_distance{
    if(!_L_distance){
        UILabel *label      = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 300, 40)];
        label.text          = @"您的运动距离为                     千米";
        label.font          = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentLeft;
        
        _L_distance               = [[UILabel alloc]initWithFrame:CGRectMake(130, 20, 110, 40)];
        _L_distance.text          = @"0.0";
        _L_distance.font          = [UIFont systemFontOfSize:30];
        _L_distance.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_L_distance];
        [self addSubview:label];
        
    }
    return _L_distance;
}

-(UILabel *)L_calorie{
    if(!_L_calorie){
        
        UILabel *label      = [[UILabel alloc]initWithFrame:CGRectMake(20, 160, 300, 40)];
        label.text          = @"您消耗卡路里为                     大卡";
        label.font          = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentLeft;
        
        _L_calorie               = [[UILabel alloc]initWithFrame:CGRectMake(130, 160, 110, 40)];
        _L_calorie.text          = @"0";
        _L_calorie.font          = [UIFont systemFontOfSize:30];
        _L_calorie.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_L_calorie];
        [self addSubview:label];
        
    }
    return _L_calorie;
}

-(UILabel *)L_time{
    if(!_L_time){
        
        UILabel *label      = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, 300, 40)];
        label.text          = @"您的运动时间为                     分钟";
        label.font          = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentLeft;
        
        _L_time               = [[UILabel alloc]initWithFrame:CGRectMake(130, 90, 110, 40)];
        _L_time.text          = @"0";
        _L_time.font          = [UIFont systemFontOfSize:30];
        _L_time.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_L_time];
        [self addSubview:label];
    }
    return _L_time;
}

-(UIButton *)confrimBtn{
    if(!_confrimBtn){
        _confrimBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        _confrimBtn.center = CGPointMake(160, 260);
        _confrimBtn.layer.borderWidth = 2.f;
        _confrimBtn.layer.cornerRadius = 35;
        
        [_confrimBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confrimBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_confrimBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_confrimBtn];
    }
    return _confrimBtn;
}

-(void)DOAnimation{
    
    [_L_distance pop_addAnimation:[self getPopbasicLinearAnmationWithFromVale:[NSNumber numberWithDouble:0.0]
                                                                  withToValue:[NSNumber numberWithDouble:distances]
                                                                 withDuration:1.2f
                                                                withDelayTime:0.f
                                                                 withProperty:[self getPropertyWithDecimals:1]]
                          forKey:nil];
    [_L_time pop_addAnimation:[self getPopbasicLinearAnmationWithFromVale:[NSNumber numberWithDouble:0.0]
                                                              withToValue:[NSNumber numberWithDouble:(seconds / 60)]
                                                             withDuration:1.2f
                                                            withDelayTime:1.3f
                                                             withProperty:[self getPropertyWithDecimals:0]]
                          forKey:nil];
    [_L_calorie pop_addAnimation:[self getPopbasicLinearAnmationWithFromVale:[NSNumber numberWithDouble:0.0]
                                                                 withToValue:[NSNumber numberWithDouble:calories]
                                                                withDuration:1.2f
                                                               withDelayTime:2.6f
                                                                withProperty:[self getPropertyWithDecimals:0]]
                          forKey:nil];
}

-(POPAnimatableProperty *)getPropertyWithDecimals:(int)decimals{
    POPAnimatableProperty *property = [POPAnimatableProperty propertyWithName:nil initializer:^(POPMutableAnimatableProperty *prop){
        prop.readBlock = ^(id obj, CGFloat values[]){
            
        };
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            UILabel *lable2 = (UILabel *)obj;
            if(decimals == 0)
                lable2.text = [NSString stringWithFormat:@"%.f",values[0]];
            else if(decimals == 1)
                lable2.text = [NSString stringWithFormat:@"%.1f",values[0]];
        };
        prop.threshold = 0.01;
    }];
    return property;
}
-(POPBasicAnimation *)getPopbasicLinearAnmationWithFromVale:(NSNumber *)fromvalue
                                                withToValue:(NSNumber *)tovalue
                                               withDuration:(CFTimeInterval)time
                                              withDelayTime:(CFTimeInterval)delaytime
                                               withProperty:(POPAnimatableProperty *)property{
    
    POPBasicAnimation *basic = [POPBasicAnimation linearAnimation];
    basic.duration           = time;
    basic.fromValue          = fromvalue;
    basic.toValue            = tovalue;
    basic.property           = property;
    basic.beginTime          = CACurrentMediaTime() + delaytime;
    return basic;
    
}

-(void)confirmBtnAction{
    [self.delegate didClickConfirmBtn:self];
}


@end

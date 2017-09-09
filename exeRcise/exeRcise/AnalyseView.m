//
//  AnalyseView.m
//  exeRcise
//
//  Created by hemeng on 17/5/15.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "AnalyseView.h"

@implementation AnalyseView

- (instancetype)initWithFrame:(CGRect)frame withType:(int)typ withMaxDis:(float)dis withMaxTime:(float)maxtime withTotalCalorie:(float)c withTotalTime:(float)t withTotalDis:(float)d withFavouriteType:(NSString *)f
{
    self = [super initWithFrame:frame];
    if (self) {

        maxDis    = dis;
        maxTime   = maxtime;
        Tcalorie  = c;
        Ttime     = t;
        Tdistance = d;
        type      = typ;
        fStr      = f;
        
        [self background];
        [self MostDis];
        [self MostTime];
        [self distance];
        [self time];
        [self calorie];
        [self favourite];
        
    }
    return self;
}
-(UIImageView *)background{
    if(!_background){
        _background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 100)];
        
        if(type == -1)
            _background.image = [UIImage imageNamed:@"r"];
        else if(type == 0)
            _background.image = [UIImage imageNamed:@"c"];
        else if(type == 1)
            _background.image = [UIImage imageNamed:@"w"];
        
        [self addSubview:_background];
    }
    return _background;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //画上面
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextMoveToPoint(context, 0, 100);
    
    CGContextAddLineToPoint(context, self.bounds.size.width, 100);
    
    CGContextMoveToPoint(context, 0, 220);
 
    CGContextAddLineToPoint(context, self.bounds.size.width, 220);
    
    CGContextMoveToPoint(context, self.bounds.size.width/2, 220);
    
    CGContextAddLineToPoint(context, self.bounds.size.width/2, 310);
    
    CGContextMoveToPoint(context, 0, 310);
    
    CGContextAddLineToPoint(context, self.bounds.size.width, 310);
    
    CGContextMoveToPoint(context, 0, 430);
    
    CGContextAddLineToPoint(context, self.bounds.size.width, 430);

    CGContextMoveToPoint(context, self.bounds.size.width/2, 430);
    
    CGContextAddLineToPoint(context, self.bounds.size.width/2, 520);

    CGContextStrokePath(context);
}
-(CGFloat)Arc:(CGFloat)angle{
    return angle * (M_PI / 180);
}
#pragma mark ui
-(UILabel *)MostDis{
    if(!_MostDis){
        _MostDis = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 150)];

        NSString *str = @"最高运动距离\n";
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%.2f公里",maxDis]];
        NSInteger i = str.length;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, i)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 6)];

        _MostDis.attributedText = attrStr;
        _MostDis.numberOfLines  = 2;
        _MostDis.textAlignment  = NSTextAlignmentCenter;
        _MostDis.center         = CGPointMake(self.bounds.size.width/2 - 70.5, 265);

        [self addSubview:_MostDis];

    }
    return _MostDis;
}
-(UILabel *)MostTime{
    if(!_MostTime){
        _MostTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 150)];

        NSString *str = @"最高运动时间\n";
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%d分钟",(int)maxTime/60]];
        NSInteger i = str.length;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, i)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 6)];

        _MostTime.attributedText = attrStr;
        _MostTime.numberOfLines  = 2;
        _MostTime.textAlignment  = NSTextAlignmentCenter;
        _MostTime.center         = CGPointMake(self.bounds.size.width/2 + 70.5, 265);

        [self addSubview:_MostTime];
    }
    return _MostTime;
}
-(UILabel *)distance{
    if(!_distance){
        _distance = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 85)];

        NSString *str = @"一共运动了";
        float d = Tdistance;
        str = [str stringByAppendingString:[NSString stringWithFormat:@"\n%.2f公里",d]];
        NSInteger i = str.length;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, i)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 5)];

        _distance.attributedText = attrStr;
        _distance.numberOfLines  = 2;
        _distance.textAlignment  = NSTextAlignmentCenter;
        _distance.center         = CGPointMake(self.bounds.size.width/2, 160);

        [self addSubview:_distance];
    }
    return _distance;
}
-(UILabel *)time{
    if(!_time){
        _time = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 85)];

        NSString *str = @"一共运动了";
        float d = Ttime;
        str = [str stringByAppendingString:[NSString stringWithFormat:@"\n%.0f分钟",d]];
        NSInteger i = str.length;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:28] range:NSMakeRange(0, i)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];

        _time.attributedText = attrStr;
        _time.numberOfLines  = 2;
        _time.textAlignment  = NSTextAlignmentCenter;
        _time.center         = CGPointMake(self.bounds.size.width/2, 370);

        [self addSubview:_time];
    }
    return _time;
}
-(UILabel *)calorie{
    if(!_calorie){
        _calorie= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 150)];

        NSString *str = @"累计消耗了\n";
        float c = Tcalorie;
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%.0f大卡",c]];
        NSInteger i = str.length;
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, i)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 5)];

        _calorie.attributedText = attriStr;
        _calorie.numberOfLines  =  2;
        _calorie.textAlignment  = NSTextAlignmentCenter;
        _calorie.center         = CGPointMake(self.bounds.size.width/2 - 70.5, 475);

        [self addSubview:_calorie];

    }
    return _calorie;
}
-(UILabel *)favourite{
    if(!_favourite){
        _favourite = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 150)];

        NSString *str = @"最喜爱的运动方式\n";
        str = [str stringByAppendingString:fStr];
        NSInteger i = str.length;
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, i)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 8)];

        _favourite.attributedText = attriStr;
        _favourite.numberOfLines  = 2;
        _favourite.textAlignment  = NSTextAlignmentCenter;
        _favourite.center         = CGPointMake(self.bounds.size.width/2 + 70.5, 475);

        [self addSubview:_favourite];

    }
    return _favourite;
}

@end

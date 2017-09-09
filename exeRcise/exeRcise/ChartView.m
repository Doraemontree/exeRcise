//
//  ChartView.m
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ChartView.h"

@implementation ChartView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 30, 440);
    
    CGContextAddLineToPoint(context, 345, 440);
    
    CGContextSetLineWidth(context, 3.5);
    
    [[UIColor grayColor] set];
    
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 0.5);
    
    CGContextMoveToPoint(context, 30, 360);
    
    CGContextAddLineToPoint(context, 345, 360);
    
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 30, 280);
    
    CGContextAddLineToPoint(context, 345, 280);
    
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 30, 200);
    
    CGContextAddLineToPoint(context, 345, 200);
    
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 30, 120);
    
    CGContextAddLineToPoint(context, 345, 120);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextStrokePath(context);
    
}
- (instancetype)initWithFrame:(CGRect)frame withTodayDate:(NSDate *)date
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self printLastWeakDateWithTodayDate:date];
        
        [self createLabel];
        
        [self createView];

    }
    return self;
}
-(void)printLastWeakDateWithTodayDate:(NSDate *)date{
    
    NSTimeInterval timeInterval1 = 24 * 60 * 60;
    NSTimeInterval timeInterval2 = 24 * 60 * 60 * 2;
    NSTimeInterval timeInterval3 = 24 * 60 * 60 * 3;
    NSTimeInterval timeInterval4 = 24 * 60 * 60 * 4;
    NSTimeInterval timeInterval5 = 24 * 60 * 60 * 5;
    NSTimeInterval timeInterval6 = 24 * 60 * 60 * 6;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM-dd"];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25, 440, 345, 50)];
    
    NSString *str1 = [formatter stringFromDate:date];
    NSString *str2 = [formatter stringFromDate:[date dateByAddingTimeInterval:-timeInterval1]];
    NSString *str3 = [formatter stringFromDate:[date dateByAddingTimeInterval:-timeInterval2]];
    NSString *str4 = [formatter stringFromDate:[date dateByAddingTimeInterval:-timeInterval3]];
    NSString *str5 = [formatter stringFromDate:[date dateByAddingTimeInterval:-timeInterval4]];
    NSString *str6 = [formatter stringFromDate:[date dateByAddingTimeInterval:-timeInterval5]];
    NSString *str7 = [formatter stringFromDate:[date dateByAddingTimeInterval:-timeInterval6]];
    
    NSString *labelStr = [NSString stringWithFormat:@"%@  %@  %@  %@  %@  %@  %@",str7,str6,str5,str4,str3,str2,str1];
    
    label.text = labelStr;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    [self addSubview:label];
}
-(void)createView{
    for(int i = 0; i < 7; i++){
        int x;
        switch (i) {
            case 0:
                x = 30;
                break;
            case 1:
                x = 77;
                break;
            case 2:
                x = 125;
                break;
            case 3:
                x = 172;
                break;
            case 4:
                x = 218;
                break;
            case 5:
                x = 264;
                break;
            case 6:
                x = 310;
                break;
            default:
                break;
        }
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x, 435, 35, 0)];
        view.tag = i + 1;
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.locations = @[@(0.3),@(0.5),(@0.7)];
        layer.colors = @[(__bridge id)[UIColor colorWithRed:91.0/255.0 green:126.0/255.0 blue:87.0/255.0 alpha:1].CGColor,
                         (__bridge id)[UIColor colorWithRed:91.0/255.0 green:166.0/255.0 blue:108.0/255.0 alpha:1].CGColor,
                         (__bridge id)[UIColor colorWithRed:81.0/255.0 green:227.0/255.0 blue:216.0/255.0 alpha:1].CGColor];
        
        layer.startPoint = CGPointMake(0, 1);
        layer.endPoint = CGPointMake(0, 0);
        layer.frame = CGRectMake(0, 0, 35, 320);
        
        [view.layer addSublayer:layer];
    }

}
-(void)createLabel{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 109, 40, 20)];
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"20";
    label1.textColor = [UIColor grayColor];
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 189, 40, 20)];
    label2.font = [UIFont systemFontOfSize:15];
    label2.text = @"15";
    label2.textColor = [UIColor grayColor];
    [self addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 269, 40, 20)];
    label3.font = [UIFont systemFontOfSize:15];
    label3.text = @"10";
    label3.textColor = [UIColor grayColor];
    [self addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 349, 40, 20)];
    label4.font = [UIFont systemFontOfSize:15];
    label4.text = @"5";
    label4.textColor = [UIColor grayColor];
    [self addSubview:label4];
}
-(void)ViewAnimationWithDataOne:(float)one
                            two:(float)two
                          three:(float)three
                           four:(float)four
                           five:(float)five
                            six:(float)six
                          seven:(float)seven{
    for(int i = 0; i < 7; i++){
        int x,y;
        switch (i) {
            case 0:
                x = 30;
                y = one * 15;
                break;
            case 1:
                x = 77;
                y = two * 15;
                break;
            case 2:
                x = 125;
                y = three * 15;
                break;
            case 3:
                x = 172;
                y = four * 15;
                break;
            case 4:
                x = 218;
                y = five * 15;
                break;
            case 5:
                x = 264;
                y = six * 15;
                break;
            case 6:
                x = 310;
                y = seven * 15;
                break;
            default:
                break;
        }
        UIView *view = (UIView *)[self viewWithTag:i + 1];
        
        [UIView animateWithDuration:1 animations:^{
            view.frame = CGRectMake(x, 435 - y, 35, y);
            
        }];
    }
}

@end

//
//  ToolView.m
//  exeRcise
//
//  Created by hemeng on 17/5/4.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ToolView.h"

@implementation ToolView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 0, 0);
    
    CGContextAddLineToPoint(context, self.bounds.size.width/2 + 5, 0);
    
    CGContextAddLineToPoint(context, self.bounds.size.width/2 - 15, self.bounds.size.height);

    CGContextAddLineToPoint(context, 0, self.bounds.size.height);
    
    [[UIColor yellowColor] setFill];
    
    CGContextSetLineWidth(context, 1.f);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextAddLineToPoint(context, 0, 0);
    
    CGContextFillPath(context);
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 + 15, 0);
    
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    
    CGContextAddLineToPoint(context, self.bounds.size.width/2 - 5, self.bounds.size.height);
    
    [[UIColor orangeColor] setFill];
    
    CGContextSetLineWidth(context, 1.f);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextAddLineToPoint(context, self.bounds.size.width/2 + 15, 0);
    
    CGContextFillPath(context);
    
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self createLabel];
        
        [self BMICalculateTool];
        
        [self calorieCalculateTool];
        
    }
    return self;
}
-(void)createLabel{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 30)];
    label1.text     = @"卡路里";
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 100, 30)];
    label2.text     = @"消耗计算器";
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(290, 50, 60, 30)];
    label3.text     = @"BMI";
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(270, 70, 100, 30)];
    label4.text     = @"计算器";
    
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];
    [self addSubview:label4];
}
-(UIButton *)calorieCalculateTool{
    if(!_calorieCalculateTool){
        _calorieCalculateTool                 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width/2 - 10, self.bounds.size.height)];
        _calorieCalculateTool.backgroundColor = [UIColor clearColor];
        
        [_calorieCalculateTool addTarget:self action:@selector(calorieCalculateBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_calorieCalculateTool];
    }
    return _calorieCalculateTool;
}
-(UIButton *)BMICalculateTool{
    if(!_BMICalculateTool){
        _BMICalculateTool                 = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 +10, 0, self.bounds.size.width/2, self.bounds.size.height)];
        _BMICalculateTool.backgroundColor = [UIColor clearColor];
        
        [_BMICalculateTool addTarget:self action:@selector(BMICalculateBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_BMICalculateTool];
    }
    return _BMICalculateTool;
    
}
-(void)calorieCalculateBtnAction{
    [self.delegate calorieCalculateToolDidClick:self];
   
}
-(void)BMICalculateBtnAction{
    [self.delegate BMICalculateToolDidClick:self];
}

@end

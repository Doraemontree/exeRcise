//
//  CommodityInfoView.m
//  exeRcise
//
//  Created by hemeng on 17/7/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CommodityInfoView.h"

@implementation CommodityInfoView

- (instancetype)initWithFrame:(CGRect)frame
                   withCprice:(NSString *)price
                withCdiscount:(NSString *)discount
                    withCname:(NSString *)name
               withCintroduce:(NSString *)introduce
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createViewWithPrice:price withDiscount:discount withName:name withIntroduce:introduce];
    }
    return self;
}
-(void)createViewWithPrice:(NSString *)price withDiscount:(NSString *)discount withName:(NSString *)name withIntroduce:(NSString *)introduce{
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 50)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = [@"¥" stringByAppendingString:price];
    label1.font = [UIFont systemFontOfSize:27];
    [self addSubview:label1];
    
    float originPrice = [price floatValue] / ([discount floatValue]/10);
    str = [NSString stringWithFormat:@"%f",originPrice];

    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(120, 30, 140, 35)];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = [[[NSString stringWithFormat:@"¥%.0f   ",originPrice] stringByAppendingString:discount] stringByAppendingString:@"折"];
    label2.font = [UIFont systemFontOfSize:17];
    label2.textColor = [UIColor grayColor];
    [self addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, 55, 330, 55)];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont systemFontOfSize:24];
    label3.text = name;
    [self addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(20, 102, self.frame.size.width - 40, 60)];
    label4.numberOfLines = 3;
    label4.textAlignment = NSTextAlignmentLeft;
    label4.layer.cornerRadius = 12;
    label4.layer.masksToBounds = YES;
    label4.font = [UIFont systemFontOfSize:14];
    label4.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:232.0/255.0 blue:255.0/255.0 alpha:1];
    label4.textColor = [UIColor grayColor];
    label4.text = introduce;
    [self addSubview:label4];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 119, 47);
    
    CGContextAddLineToPoint(context, 119 + str.length * 2.25 * 2.25, 47);
    
    [[UIColor grayColor]set];
    
    CGContextStrokePath(context);
    
    
}


@end

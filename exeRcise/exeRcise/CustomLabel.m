//
//  CustomLabel.m
//  exeRcise
//
//  Created by hemeng on 17/7/4.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self createImage];
        
        [self createLabel];
    }
    return self;
}
-(void)createLabel{
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(38, 0, 100, 40)];
    _label1.text = @"24小时刷新";
    _label1.textAlignment = NSTextAlignmentLeft;
    _label1.textColor = [UIColor colorWithRed:43.0/255.0 green:185.0/255.0 blue:149.0/255.0 alpha:1];
    
    [self addSubview:_label1];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(178, 0, 100, 40)];
    _label2.text = @"100%正品";
    _label2.textAlignment = NSTextAlignmentLeft;
    _label2.textColor = [UIColor colorWithRed:18.0/255.0 green:162.0/255.0 blue:228.0/255.0 alpha:1];
    
    [self addSubview:_label2];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(299, 0, 100, 40)];
    _label3.text = @"7天退换";
    _label3.textAlignment = NSTextAlignmentLeft;
    _label3.textColor = [UIColor colorWithRed:166.0/255.0 green:49.0/255.0 blue:34.0/255.0 alpha:1];
    
    [self addSubview:_label3];
    

    
}
-(void)createImage{
    _image1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
    _image1.image = [UIImage imageNamed:@"customlabel_time"];
    
    [self addSubview:_image1];
    
    _image2 = [[UIImageView alloc]initWithFrame:CGRectMake(147, 5, 25, 25)];
    _image2.image = [UIImage imageNamed:@"customlabel_goods"];
    
    [self addSubview:_image2];
    
    _image3 = [[UIImageView alloc]initWithFrame:CGRectMake(265, 5, 30, 30)];
    _image3.image = [UIImage imageNamed:@"customlabel_exchange"];
    
    [self addSubview:_image3];
}

@end

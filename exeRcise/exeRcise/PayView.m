//
//  PayView.m
//  exeRcise
//
//  Created by hemeng on 17/7/12.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "PayView.h"

@implementation PayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 0, 50);
    
    CGContextAddLineToPoint(context, 280, 50);
    
    CGContextSetLineWidth(context, 1);
    
    [[UIColor grayColor]set];
    
    CGContextStrokePath(context);
}

- (instancetype)initWithFrame:(CGRect)frame withMoney:(NSString *)money
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self label1];
        
        [self money];
        self.money.text = [@"¥" stringByAppendingString:money];
        
        [self confrimBtn];
        
        [self deleteBtn];
        
        [self label2];
        
    }
    return self;
}

-(UIButton *)confrimBtn{
    if(!_confrimBtn){
        _confrimBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 280, 50)];
        _confrimBtn.center = CGPointMake(140, 175);
        [_confrimBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confrimBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        _confrimBtn.backgroundColor = [UIColor purpleColor];
        
        [self addSubview:_confrimBtn];
    }
    return _confrimBtn;
}
-(UIButton *)deleteBtn{
    if(!_deleteBtn){
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        [_deleteBtn setTitle:@"✕" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_deleteBtn];
    }
    return _deleteBtn;
}
-(UILabel *)money{
    if(!_money){
        _money = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 50)];
        _money.center = CGPointMake(140, 85);
        _money.font = [UIFont systemFontOfSize:23];
        _money.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_money];
    }
    return _money;
}
-(UILabel *)label2{
    if(!_label2){
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        _label2.text = @"收款方:exeRcise官方店";
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.center = CGPointMake(140, 115);
        
        [self addSubview:_label2];
    }
    return _label2;
}
-(UILabel *)label1{
    if(!_label1){
        _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        _label1.text = @"支付";
        _label1.center = CGPointMake(140, 25);
        _label1.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_label1];
    }
    return _label1;
}
-(void)deleteAction{
    [self.delegate didClickPayViewDeleteBtn:self];
}
-(void)btnAction{
    [self.delegate didClickConfirmBtn:self];
}
@end

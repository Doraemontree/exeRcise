//
//  CustomTabbar.m
//  exeRcise
//
//  Created by hemeng on 17/4/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CustomTabbar.h"

@implementation CustomTabbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self middle];
        
        [self left];
        
        [self right];
    }
    return self;
}

-(UIButton *)middle{
    if(!_middle){
        UIView *back = [[UIView alloc]init];
        
        back.backgroundColor = [UIColor whiteColor];
        
        back.frame = CGRectMake(0, 0, 84, 84);
        
        back.layer.cornerRadius = 42;
        
        back.center = CGPointMake(self.bounds.size.width/2, 10);
        
        [self addSubview:back];
        
        _middle = [[UIButton alloc]init];
        
        _middle.frame = CGRectMake(0, 0, 75, 75);
        
        _middle.center = CGPointMake(self.bounds.size.width/2 , 10);
        
        [_middle setImage:[UIImage imageNamed:@"middleimage"] forState:UIControlStateNormal];
        
        [_middle addTarget:self action:@selector(middleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_middle];
    }
    return _middle;
}

-(UIButton *)left{
    if(!_left){
        _left = [[UIButton alloc]init];
        
        _left.frame = CGRectMake(0, 0, 50, 50);
        
        [_left setImage:[UIImage imageNamed:@"store_icon_default"] forState:UIControlStateNormal];
        
        [_left setImage:[UIImage imageNamed:@"store_icon_pressed"] forState:UIControlStateSelected];
        
        _left.center = CGPointMake(77, 23);
        
        [_left addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:_left];
        
    }
    return _left;
}

-(UIButton *)right{
    if(!_right){
        _right = [[UIButton alloc]init];
        
        _right.frame = CGRectMake(0, 0, 43, 43);
        
        [_right setImage:[UIImage imageNamed:@"rightimage"] forState:UIControlStateNormal];
        
        [_right setImage:[UIImage imageNamed:@"rightimage-1"] forState:UIControlStateSelected];
        
        _right.center = CGPointMake(self.bounds.size.width - 76, 23);
        
        [_right addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_right];
    }
    return _right;
}

-(void)middleClick:(UIButton *)btn{
    self.left.selected = NO;
    self.right.selected = NO;
    
    if([self.delegate respondsToSelector:@selector(tabbarDidClickButton:withButtonNumber:)]){
        
        [self.delegate tabbarDidClickButton:self withButtonNumber:1];
    }
}

-(void)leftClick:(UIButton *)btn{
    self.left.selected = YES;
    self.right.selected = NO;
    
    if([self.delegate respondsToSelector:@selector(tabbarDidClickButton:withButtonNumber:)]){
        
        [self.delegate tabbarDidClickButton:self withButtonNumber:0];
    }
}

-(void)rightClick:(UIButton *)btn{
    self.left.selected = NO;
    self.right.selected = YES;
    
    if([self.delegate respondsToSelector:@selector(tabbarDidClickButton:withButtonNumber:)]){
        
        [self.delegate tabbarDidClickButton:self withButtonNumber:2];
    }
}
@end

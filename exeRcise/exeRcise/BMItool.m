//
//  BMItool.m
//  exeRcise
//
//  Created by hemeng on 17/5/13.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "BMItool.h"

@implementation BMItool

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self weight];
        
        [self height];
        
        [self result];
        
        [self heightTextfield];
        
        [self weightTextfield];
        
        [self okBtn];
        
        [self backBtn];
        
        [self resultReveal];
        
    }
    return self;
}

-(UILabel *)weight{
    if(!_weight){
        _weight = [[UILabel alloc]initWithFrame:CGRectMake(75, 40, 200, 35)];
        _weight.text = @"体重:                    KG";
        _weight.textColor = [UIColor blackColor];
        
        [self addSubview:_weight];
        
    }
    return _weight;
}

-(UILabel *)result{
    if(!_result){
        _result = [[UILabel alloc]initWithFrame:CGRectMake(75, 150, 200, 35)];
        _result.text = @"结果:";
        
        [self addSubview:_result];
    }
    return _result;
}

-(UILabel *)height{
    if(!_height){
        _height = [[UILabel alloc]initWithFrame:CGRectMake(75, 95, 200, 35)];
        _height.text = @"身高:                    CM";
        
        [self addSubview:_height];
    }
    return _height;
}

-(UILabel *)resultReveal{
    if(!_resultReveal){
        _resultReveal = [[UILabel alloc]initWithFrame:CGRectMake(130, 150, 60, 35)];
        
        
        [self addSubview:_resultReveal];
    }
    return _resultReveal;
}

-(UITextField *)weightTextfield{
    if(!_weightTextfield){
        _weightTextfield = [[UITextField alloc]initWithFrame:CGRectMake(130, 45, 60, 25)];
        _weightTextfield.borderStyle = UITextBorderStyleRoundedRect;
        _weightTextfield.keyboardType = UIKeyboardTypeDecimalPad;
        
        [self addSubview:_weightTextfield];
    }
    return _weightTextfield;
}

-(UITextField *)heightTextfield{
    if(!_heightTextfield){
        _heightTextfield = [[UITextField alloc]initWithFrame:CGRectMake(130, 100, 60, 25)];
        _heightTextfield.borderStyle = UITextBorderStyleRoundedRect;
        _heightTextfield.keyboardType = UIKeyboardTypeDecimalPad;
        
        [self addSubview:_heightTextfield];
    }
    return _heightTextfield;
}

-(UIButton *)okBtn{
    if(!_okBtn){
        _okBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 200, 75, 35)];
        _okBtn.layer.cornerRadius = 17.5;
        _okBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _okBtn.layer.borderWidth = 1.f;
        
        [_okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_okBtn setTitle:@"计算" forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_okBtn];
    }
    return _okBtn;
}

-(UIButton *)backBtn{
    if(!_backBtn){
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 200, 75, 35)];
        _backBtn.layer.cornerRadius = 17.5;
        _backBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _backBtn.layer.borderWidth = 1.f;
        
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_backBtn];
    }
    return _backBtn;
}

-(void)backAction{
    [self.delegate DidClickBMIBackBtn:self];
}

-(void)okAction{
    float v;//BMI计算器的值
    float w = [_weightTextfield.text floatValue];
    float h = [_heightTextfield.text floatValue];

    v = w / (h/100) / (h/100);
    
    _resultReveal.text = [NSString stringWithFormat:@"%.1f",v];
    
}
@end

//
//  calorieTool.m
//  exeRcise
//
//  Created by hemeng on 17/5/11.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "calorieTool.h"

@implementation calorieTool


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.close = 0;
        
        [self weight];
        
        [self time];
        
        [self weightTextfield];
        
        [self timeTextfield];
        
        [self type];
        
        [self result];
        
        [self okBtn];
        
        [self backBtn];
        
        [self resultReveal];
        
        [self pickerView];
        
        [self confirm];

    }
    return self;
}

-(UILabel *)resultReveal{
    if(!_resultReveal){
        _resultReveal = [[UILabel alloc]initWithFrame:CGRectMake(130, 200, 60, 35)];

        
        [self addSubview:_resultReveal];
    }
    return _resultReveal;
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
        _result = [[UILabel alloc]initWithFrame:CGRectMake(75, 200, 200, 35)];
        _result.text = @"结果:                    KC";
        
        [self addSubview:_result];
    }
    return _result;
}

-(UILabel *)time{
    if(!_time){
        _time = [[UILabel alloc]initWithFrame:CGRectMake(75, 95, 200, 35)];
        _time.text = @"时间:                    MIN";
        
        [self addSubview:_time];
    }
    return _time;
}

-(UILabel *)type{
    if(!_type){
        _type = [[UILabel alloc]initWithFrame:CGRectMake(40, 150, 90, 35)];
        _type.text = @"运动方式:";
        
        [self addSubview:_type];
    }
    return _type;
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

-(UITextField *)timeTextfield{
    if(!_timeTextfield){
        _timeTextfield = [[UITextField alloc]initWithFrame:CGRectMake(130, 100, 60, 25)];
        _timeTextfield.borderStyle = UITextBorderStyleRoundedRect;
        _timeTextfield.keyboardType = UIKeyboardTypeDecimalPad;
        
        [self addSubview:_timeTextfield];
    }
    return _timeTextfield;
}

-(UIPickerView *)pickerView{
    if(!_pickerView){
        _pickerView            = [[UIPickerView alloc]initWithFrame:self.bounds];
        _pickerView.center     = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate   = self;
        _pickerView.dataSource = self;
        _pickerView.hidden     = YES;
        
        
        [self createData];
        
        _button                   = [[UIButton alloc]initWithFrame:CGRectMake(125, 153, 70, 30)];
        _button.backgroundColor   = [UIColor clearColor];
        _button.layer.borderWidth = 0.5;
        _button.layer.borderColor = [UIColor blackColor].CGColor;
        
        NSString *str = @"点击选择";
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:str];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
        
        [_button setAttributedTitle:attString forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_button];
        [self addSubview:_pickerView];
    }
    return _pickerView;
}

-(UIButton *)confirm{
    if(!_confirm){
        _confirm                    = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _confirm.layer.cornerRadius = 25;
        _confirm.backgroundColor    = [UIColor redColor];
        _confirm.layer.borderColor  = [ UIColor blackColor].CGColor;
        _confirm.center             = CGPointMake(self.bounds.size.width/2 + 100, self.bounds.size.height/2);
        _confirm.hidden             = YES;
        
        [_confirm setTitle:@"确定" forState:UIControlStateNormal];
        [_confirm addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_confirm];
    }
    return _confirm;
}

-(UIButton *)okBtn{
    if(!_okBtn){
        _okBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 260, 75, 35)];
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
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 260, 75, 35)];
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
    [self.delegate DidClickBackButton:self];
}

-(void)okAction{
    if(self.close != 0){
        float reliang;
        float s;//运动对应的卡路里
        
        switch (self.close) {
            case 1:
                reliang=150;
                break;
            case 2:
                reliang=600;
                break;
            case 3:
                reliang=480;
                break;
            case 4:
                reliang=550;
                break;
            case 5:
                reliang=500;
                break;
            case 6:
                reliang=400;
                break;
            case 7:
                reliang=350;
                break;
            case 8:
                reliang=120;
                break;
            default:
                break;
        }
        float w = [_weightTextfield.text floatValue];//体重实际值 转换为float
        float t = [_timeTextfield.text floatValue];
        
        s = (w / 75) * reliang * (t / 60);

        _resultReveal.text = [NSString stringWithFormat:@"%.0f",s];
    }
    
}
-(void)buttonAction{
    _pickerView.hidden = NO;
    _confirm.hidden    = NO;
    
    
    [self endEditing:YES];
}
-(void)confirmAction{
    _pickerView.hidden = YES;
    _confirm.hidden    = YES;
    
    if([self.Str isEqualToString:@""]){
        self.Str = @"散步";
        self.close =  1;
    }
    
    [_button setAttributedTitle:nil forState:UIControlStateNormal];
    [_button setTitle:self.Str forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}
-(void)createData{
    self.province = @[@"散步",@"跑步",@"爬楼",@"游泳",@"篮球",@"羽毛球",@"骑车",@"干家务"];
    
    self.Str      = [[NSString alloc]init];
}
#pragma mark pickview 代理
//一共多少列 pick view的代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}

//第component列一共有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.province.count;
}

//指定列列表项的文本标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.province[row];
}

//返回选中列表项调用此方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.close = (int)row + 1;
    
    self.Str = self.province[row];
}
//代理方法(UIPickerViewDelegate)
// 第component列的宽度是多少
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 100;
}

// 第component列的行高是多少
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 45;
}


@end

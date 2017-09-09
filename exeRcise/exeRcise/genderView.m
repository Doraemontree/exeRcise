//
//  genderView.m
//  exeRcise
//
//  Created by hemeng on 17/6/12.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "genderView.h"

@implementation genderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self createBtn];
        
        [self createImage];
        
        [self createLabel];
        
        [self createSliderAndLabel];
   
    }
    return self;
}

-(void)createBtn{
    _btnOne                    = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
    _btnOne.center             = CGPointMake(self.bounds.size.width/2, 160);
    _btnOne.layer.cornerRadius = 70;
    _btnOne.backgroundColor    = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1];
    _btnOne.layer.borderColor  = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1].CGColor;
    [_btnOne addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnOne setTitle:@"" forState:UIControlStateNormal];
    
    [self addSubview:_btnOne];
    
    _btnTwo                    = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
    _btnTwo.center             = CGPointMake(self.bounds.size.width/2, 410);
    _btnTwo.layer.cornerRadius = 70;
    _btnTwo.backgroundColor    = [UIColor colorWithRed:236/255.0 green:192/255.0 blue:243/255.0 alpha:1];
    _btnTwo.layer.borderColor  = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1].CGColor;
    [_btnTwo addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnTwo setTitle:@"" forState:UIControlStateNormal];
    
    [self addSubview:_btnTwo];
    
    _back                        = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    _back.layer.cornerRadius     = 35;
    _back.center                 = CGPointMake(self.bounds.size.width/2 - 80, 600);
    _back.layer.borderColor      = [UIColor blackColor].CGColor;
    _back.layer.borderWidth      = 2.5f;
    _back.alpha                  = 0;
    _back.userInteractionEnabled = NO;
    [_back setTitle:@"返回" forState:UIControlStateNormal];
    [_back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_back];
    
    _confirm                        = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    _confirm.layer.cornerRadius     = 35;
    _confirm.layer.borderColor      = [UIColor blackColor].CGColor;
    _confirm.layer.borderWidth      = 2.5f;
    _confirm.alpha                  = 0;
    _confirm.userInteractionEnabled = NO;
    _confirm.center                 = CGPointMake(self.bounds.size.width/2 + 80, 600);
    [_confirm setTitle:@"确定" forState:UIControlStateNormal];
    [_confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_confirm addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_confirm];
}

-(void)backAction{
    [self.delegate DidClickBackBtn:self];
}

-(void)registerAction{
    _h = _sliderOne.value;
    _w = _sliderTwo.value;
    
    [self.delegate DidClickConfirmBtn:self];
}

-(void)createImage{
    UIImageView *male = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 74, 82)];
    male.image = [UIImage imageNamed:@"male"];
    male.center = CGPointMake(70,70);
    
    [_btnOne addSubview:male];
    
    UIImageView *female = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 56, 94)];
    female.image = [UIImage imageNamed:@"female"];
    female.center = CGPointMake(70,70);
    
    [_btnTwo addSubview:female];
    
}

-(void)createLabel{
    label1               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    label1.textColor     = [UIColor redColor];
    label1.text          = @"性别选定后无法更改";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.center        = CGPointMake(self.bounds.size.width/2, 560);
    
    [self addSubview:label1];
    
    label2               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    label2.text          = @"男\nMale";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.center        = CGPointMake(self.bounds.size.width/2, 256);
    label2.textColor     = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1];
    label2.numberOfLines = 2;
    
    [self addSubview:label2];
    
    label3               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 100)];
    label3.text          = @"女\nFemale";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.center        = CGPointMake(self.bounds.size.width/2, 505);
    label3.textColor     = [UIColor colorWithRed:236/255.0 green:192/255.0 blue:243/255.0 alpha:1];
    label3.numberOfLines = 2;
    
    [self addSubview:label3];
    
}

-(void)createSliderAndLabel{
    _sliderOne        = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, 280, 10)];
    _sliderOne.center = CGPointMake(self.bounds.size.width/2, 130);
    _sliderOne.minimumTrackTintColor = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1];
    _sliderOne.minimumValue = 130;
    _sliderOne.maximumValue = 220;
    _sliderOne.value        = 175;
    _sliderOne.alpha        = 0;
    _sliderOne.userInteractionEnabled = NO;
    [_sliderOne setThumbImage:[UIImage imageNamed:@"vernierM"] forState:UIControlStateNormal];
    [_sliderOne addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_sliderOne];
    
    _sliderTwo        = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, 280, 10)];
    _sliderTwo.center = CGPointMake(self.bounds.size.width/2, 270);
    _sliderTwo.minimumTrackTintColor = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1];
    _sliderTwo.minimumValue = 30;
    _sliderTwo.maximumValue = 150;
    _sliderTwo.value        = 90;
    _sliderTwo.alpha        = 0;
    _sliderTwo.userInteractionEnabled = NO;
    [_sliderTwo setThumbImage:[UIImage imageNamed:@"vernierM"] forState:UIControlStateNormal];
    [_sliderTwo addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_sliderTwo];
    
    height               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    height.center        = CGPointMake(self.bounds.size.width/2 - 18, 90);
    height.text          = @"175";
    height.textColor     = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1];
    height.textAlignment = NSTextAlignmentCenter;
    height.font          = [UIFont systemFontOfSize:27];
    height.alpha         = 0;
    
    [self addSubview:height];
    
    cm               = [[UILabel alloc]initWithFrame:CGRectMake(100, 310, 70, 40)];
    cm.text          = @"cm";
    cm.center        = CGPointMake(self.bounds.size.width/2 + 20, 90);
    cm.textColor     = [UIColor blackColor];
    cm.textAlignment = NSTextAlignmentCenter;
    cm.font          = [UIFont systemFontOfSize:19];
    cm.alpha         = 0;
    
    [self addSubview:cm];
    
    weight               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    weight.center        = CGPointMake(self.bounds.size.width/2 - 12, 230);
    weight.text          = @"90";
    weight.textAlignment = NSTextAlignmentCenter;
    weight.textColor     = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1];
    weight.font          = [UIFont systemFontOfSize:27];
    weight.alpha         = 0;
    
    [self addSubview:weight];
    
    kg               = [[UILabel alloc]initWithFrame:CGRectMake(100, 310, 70, 40)];
    kg.text          = @"kg";
    kg.center        = CGPointMake(self.bounds.size.width/2 + 22, 230);
    kg.textColor     = [UIColor blackColor];
    kg.textAlignment = NSTextAlignmentCenter;
    kg.font          = [UIFont systemFontOfSize:19];
    kg.alpha         = 0;
    
    [self addSubview:kg];
    
    minmaxH      = [[UILabel alloc]initWithFrame:CGRectMake(30, 130, self.bounds.size.width - 60, 40)];
    minmaxH.text          = @"130                                                        220";
    minmaxH.textAlignment = NSTextAlignmentCenter;
    minmaxH.alpha         = 0;
    
    [self addSubview:minmaxH];
    
    minmaxW      = [[UILabel alloc]initWithFrame:CGRectMake(30, 270, self.bounds.size.width - 60, 40)];
    minmaxW.text          = @"30                                                         150";
    minmaxW.textAlignment = NSTextAlignmentCenter;
    minmaxW.alpha         = 0;
    
    [self addSubview:minmaxW];
}

-(void)nextAction:(UIButton *)btn{
    if(btn == _btnOne && _btnTwo.alpha == 1){
        
        [self MaleAnimation];
        self.sex = @"male";
    }
    else if(btn == _btnTwo && _btnOne.alpha == 1){
        
        [self FemaleAnimation];
        self.sex = @"female";
    }
}

-(void)sliderChange:(UISlider *)slider{
    if(slider == _sliderOne){

        height.text = [NSString stringWithFormat:@"%.f",slider.value];
        
    }
    else if(slider == _sliderTwo){

        weight.text = [NSString stringWithFormat:@"%.f",slider.value];
    }
}
-(void)MaleAnimation{
    
    _btnTwo.alpha = 0;
    label1.alpha  = 0;
    label3.alpha  = 0;
    
    _sliderOne.center                 = CGPointMake(self.bounds.size.width/2, 360);
    _sliderOne.minimumTrackTintColor  = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1];
    _sliderOne.userInteractionEnabled = YES;
    
    _sliderTwo.center                 = CGPointMake(self.bounds.size.width/2, 500);
    _sliderTwo.minimumTrackTintColor  = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1];
    _sliderTwo.userInteractionEnabled = YES;
    
    height.textColor = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1];
    weight.textColor = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1];
    
    height.center  = CGPointMake(self.bounds.size.width/2 - 18, 310);
    cm.center      = CGPointMake(self.bounds.size.width/2 + 20, 310);
    weight.center  = CGPointMake(self.bounds.size.width/2 - 10, 450);
    kg.center      = CGPointMake(self.bounds.size.width/2 + 20, 450);
    minmaxH.frame  = CGRectMake(30, 360, self.bounds.size.width - 60, 40);
    minmaxW.frame  = CGRectMake(30, 500, self.bounds.size.width - 60, 40);
    
    _back.layer.borderColor    = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1].CGColor;
    _confirm.layer.borderColor = [UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1].CGColor;
    [_back setTitleColor:[UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1] forState:UIControlStateNormal];
    [_confirm setTitleColor:[UIColor colorWithRed:166/255.0 green:229/255.0 blue:243/255.0 alpha:1] forState:UIControlStateNormal];
    
    _back.userInteractionEnabled    = YES;
    _confirm.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:1.f animations:^{
        _sliderOne.alpha = 1;
        _sliderTwo.alpha = 1;
        height.alpha     = 1;
        weight.alpha     = 1;
        cm.alpha         = 1;
        kg.alpha         = 1;
        minmaxW.alpha    = 1;
        minmaxH.alpha    = 1;
        _back.alpha      = 1;
        _confirm.alpha   = 1;
    }];
}

-(void)FemaleAnimation{
    
    _btnOne.alpha = 0;
    label1.alpha  = 0;
    label2.alpha  = 0;
    
    _sliderOne.center                 = CGPointMake(self.bounds.size.width/2, 130);
    _sliderOne.minimumTrackTintColor  = [UIColor colorWithRed:236/255.0 green:192/255.0 blue:243/255.0 alpha:1];
    _sliderOne.userInteractionEnabled = YES;
    
    _sliderTwo.center                 = CGPointMake(self.bounds.size.width/2, 270);
    _sliderTwo.minimumTrackTintColor  = [UIColor colorWithRed:236/255.0 green:192/255.0 blue:243/255.0 alpha:1];
    _sliderTwo.userInteractionEnabled = YES;
    
    height.textColor = [UIColor colorWithRed:236/255.0 green:192/255.0 blue:243/255.0 alpha:1];
    weight.textColor = [UIColor colorWithRed:236/255.0 green:192/255.0 blue:243/255.0 alpha:1];
    
    height.center  = CGPointMake(self.bounds.size.width/2 - 18, 90);
    cm.center      = CGPointMake(self.bounds.size.width/2 + 20, 90);
    weight.center  = CGPointMake(self.bounds.size.width/2 - 12, 230);
    kg.center      = CGPointMake(self.bounds.size.width/2 + 22, 230);
    minmaxH.frame  = CGRectMake(30, 130, self.bounds.size.width - 60, 40);
    minmaxW.frame  = CGRectMake(30, 270, self.bounds.size.width - 60, 40);
    
    _back.layer.borderColor    = [UIColor colorWithRed:236/255.0 green:192/255.0 blue:243/255.0 alpha:1].CGColor;
    _confirm.layer.borderColor = [UIColor colorWithRed:236/255.0 green:192/255.0 blue:243/255.0 alpha:1].CGColor;
    [_back setTitleColor:[UIColor colorWithRed:236/255.0 green:192/255.0 blue:243/255.0 alpha:1] forState:UIControlStateNormal];
    [_confirm setTitleColor:[UIColor colorWithRed:236/255.0 green:192/255.0 blue:243/255.0 alpha:1] forState:UIControlStateNormal];
    
    _back.userInteractionEnabled    = YES;
    _confirm.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:1.f animations:^{
        _sliderOne.alpha = 1;
        _sliderTwo.alpha = 1;
        height.alpha     = 1;
        weight.alpha     = 1;
        cm.alpha         = 1;
        kg.alpha         = 1;
        minmaxW.alpha    = 1;
        minmaxH.alpha    = 1;
        _confirm.alpha   = 1;
        _back.alpha      = 1;
    }];

}

@end

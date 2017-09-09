//
//  exericseViewController.m
//  exeRcise
//
//  Created by hemeng on 17/4/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "exericseViewController.h"
#import "RunViewController.h"
#import "AppDelegate.h"
#import "POP.h"
#import "exerciseModel.h"


@interface exericseViewController ()<CAAnimationDelegate>{
    float aim;//完成目标的百分比 用于动画
    
    UILabel *percentage;
    
    int whichOne;//保存是哪个板块的界面
}

@property(nonatomic,strong)AppDelegate *appdelegate;

@end

@implementation exericseViewController

-(AppDelegate *)appdelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

//num [0，2] 0 跑步 R 1骑车 C 2步行 W
-(instancetype)initWithCellNumber:(int)num{
    self = [super init];
    if(self) {
        _Acaloire  = self.appdelegate.userInfo.aimC;//卡路里
        _Adistance = self.appdelegate.userInfo.aimD;//距离
        _Atime     = self.appdelegate.userInfo.aimT;//时间
        
        whichOne = num;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshView) name:@"AfterRunRefreshUI" object:nil];
        
        self.view.userInteractionEnabled = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self background];

    [self rect];
    
    _rect.aim_num.text = [NSString stringWithFormat:@"%.0f",_Acaloire];
    
    [self circleView];
    
    [self setTime];
    
    [self setDistance];
    
    [self setCalorie];
    
    [self setBtn];
    
    [self setAim];
    
    [self goBtn];
    
    [self backBtn];
    
    [self setLabelText];
    
}

//刷新运动数值
-(void)refreshView{
    [self setLabelText];
}

-(void)setCircleShape{//设置circleshaperun
    exerciseModel *model = [[exerciseModel alloc]init];
    
    if([self.rect.aim.text isEqualToString:@"卡 路 里(大卡):"]){
        self.rect.aim_num.text = [NSString stringWithFormat:@"%.0f",_Acaloire];
        aim = [model calculatePercentageWithType:0 withAimFloat:_Acaloire];
    }
    else if([self.rect.aim.text isEqualToString:@"运动时间(分钟):"]){
        self.rect.aim_num.text = [NSString stringWithFormat:@"%.0f",_Atime];
        aim = [model calculatePercentageWithType:2 withAimFloat:_Atime];
    }
    else if([self.rect.aim.text isEqualToString:@"运动距离(公里):"]){
        self.rect.aim_num.text = [NSString stringWithFormat:@"%.2f",_Adistance];
        aim = [model calculatePercentageWithType:1 withAimFloat:_Adistance];
    }
    percentage.text = [NSString stringWithFormat:@"%.0f",aim * 100];
    [self performSelector:@selector(circleRunAnimation) withObject:nil afterDelay:0.5];
    
}

-(void)setLabelText{//根据whichone设置labeltext
    NSArray *ar;
    
    if(whichOne == 0)
        ar = self.appdelegate.userInfo.runningAr;
    else if(whichOne == 1)
        ar = self.appdelegate.userInfo.cyclingAr;
    else if(whichOne == 2)
        ar = self.appdelegate.userInfo.walkingAr;
    
    _rect.calorie.text  = [NSString stringWithFormat:@"%.0f",[[ar objectAtIndex:0] floatValue]];
    _rect.distance.text = [NSString stringWithFormat:@"%.2f",[[ar objectAtIndex:1] floatValue]];
    _rect.time.text     = [NSString stringWithFormat:@"%.0f",[[ar objectAtIndex:2] floatValue]];
   
    [self setCircleShape];
}

-(void)circleRunAnimation{
    
    POPSpringAnimation *popspring = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    popspring.toValue             = @(aim);
    popspring.springBounciness    = 14.f;
    popspring.springSpeed         = 2.5f;
    
    [_circleShapeRun pop_addAnimation:popspring forKey:nil];
    
}

#pragma mark view
//框
-(customRect *)rect{
    if(!_rect){
        _rect = [[customRect alloc]initWithFrame:CGRectMake(10, 35, self.view.bounds.size.width - 20, 350 + self.view.bounds.size.width/2 - 5)];
        
        _rect.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:self.rect];
    }
    return _rect;
}
//圆
-(UIView *)circleView{
    if(!_circleView){
        _circleView                     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        _circleView.layer.cornerRadius  = 75;
        _circleView.layer.borderWidth   = 1.f;
        _circleView.center              = CGPointMake(self.view.bounds.size.width/2 , 435);
        _circleView.backgroundColor     = [UIColor colorWithRed:24.0/255.0 green:157.0/255.0 blue:216.0/255.0 alpha:1];
        _circleView.layer.borderColor   = [UIColor colorWithRed:24.0/255.0 green:157.0/255.0 blue:216.0/255.0 alpha:1].CGColor;
        _circleView.layer.shadowOpacity = 1.f;
        _circleView.layer.shadowColor   = [UIColor colorWithRed:24.0/255.0 green:157.0/255.0 blue:216.0/255.0 alpha:1].CGColor;
        _circleView.layer.shadowOffset  = CGSizeMake(0, 3);
        
        [self.view addSubview:_circleView];
        
        percentage               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
        percentage.text          = @"0";
        percentage.textColor     = [UIColor whiteColor];
        percentage.textAlignment = NSTextAlignmentCenter;
        percentage.font          = [UIFont systemFontOfSize:40];
        percentage.center        = CGPointMake(75, 75);
        
        [self.circleView addSubview:percentage];
        
        UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        label.textColor = [UIColor whiteColor];
        label.text      = @"%";
        label.font      = [UIFont systemFontOfSize:13];
        label.center    = CGPointMake(125, 80);
        
        [self.circleView addSubview:label];
        
        UIBezierPath *circle        = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 155, 155)];
        _circleShapeRun             = [CAShapeLayer layer];
        _circleShapeRun.frame       = CGRectMake(0, 0, 155, 155);
        _circleShapeRun.position    = _circleView.center;
        _circleShapeRun.fillColor   = [UIColor clearColor].CGColor;
        _circleShapeRun.path        = circle.CGPath;
        _circleShapeRun.strokeStart = 0.f;
        _circleShapeRun.strokeEnd   = 0.f;
        _circleShapeRun.lineWidth   = 3.f;
        _circleShapeRun.transform   = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
        _circleShapeRun.strokeColor = [UIColor purpleColor].CGColor;
        
        [self.view.layer addSublayer:_circleShapeRun];
        
    }
    return _circleView;
}

-(UIImageView *)background{
    if(!_background){
        
        _background = [[UIImageView alloc]initWithFrame:self.view.bounds];
        
        [_background setImage:[UIImage imageNamed:@"background2"]];
        [self.view addSubview:_background];
        
    }
    return _background;
}

#pragma mark button
-(UIButton *)goBtn{
    if(!_goBtn){
        _goBtn                     = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 45)];
        _goBtn.layer.cornerRadius  = 22.5;
        _goBtn.center              = CGPointMake(self.view.bounds.size.width/2 + 100, 600);
        _goBtn.layer.shadowOpacity = 0.7;
        _goBtn.layer.borderWidth   = 1.f;
        _goBtn.layer.borderColor   = [UIColor blackColor].CGColor;
        _goBtn.layer.shadowOffset  = CGSizeMake(-1, -1);
        
        [_goBtn setTitle:@"GO" forState:UIControlStateNormal];
        [_goBtn addTarget:self action:@selector(goAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_goBtn];
    }
    return _goBtn;
}

-(UIButton *)backBtn{
    if(!_backBtn){
        _backBtn                     = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 45)];
        _backBtn.layer.cornerRadius  = 22.5;
        _backBtn.center              = CGPointMake(self.view.bounds.size.width/2 - 100, 600);
        _backBtn.layer.shadowOpacity = 0.7;
        _backBtn.layer.borderWidth   = 1.f;
        _backBtn.layer.borderColor   = [UIColor blackColor].CGColor;
        _backBtn.layer.shadowOffset  = CGSizeMake(-1, -1);
        
        [_backBtn setTitle:@"BACK" forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backBtn];
    }
    return _backBtn;
}

-(UIButton *)setAim{
    if(!_setAim){
        _setAim = [[UIButton alloc]initWithFrame:CGRectMake(270, 235, 50, 50)];
        _setAim.adjustsImageWhenHighlighted = NO;
        
        [_setAim setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];

        [self.view addSubview:_setAim];
    }
    return _setAim;
}

-(UIButton *)setBtn{
    if(!_setBtn){
        _setBtn                             = [[UIButton alloc]initWithFrame:CGRectMake(90, 470, 25, 25)];
        _setBtn.layer.cornerRadius          = 12.5;
        _setBtn.backgroundColor             = [UIColor whiteColor];
        _setBtn.layer.masksToBounds         = YES;
        _setBtn.adjustsImageWhenHighlighted = NO;
        _setBtn.tag                         = -1;
        
        [_setBtn setImage:[UIImage imageNamed:@"setBtn"] forState:UIControlStateNormal];
        [_setBtn addTarget:self action:@selector(setBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_setBtn];
    }
    return _setBtn;
}

-(UIButton *)setTime{
    if(!_setTime){
        _setTime = [[UIButton alloc]initWithFrame:CGRectMake(90, 470, 25, 25)];
        _setTime.layer.cornerRadius = 12.5;
        _setTime.backgroundColor    = [UIColor whiteColor];
        
        [_setTime setTitle:@"时" forState:UIControlStateNormal];
        [_setTime setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_setTime addTarget:self action:@selector(setTimeAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_setTime];
    }
    return _setTime;
}

-(UIButton *)setCalorie{
    if(!_setCalorie){
        _setCalorie = [[UIButton alloc]initWithFrame:CGRectMake(90, 470, 25, 25)];
        _setCalorie.layer.cornerRadius = 12.5;
        _setCalorie.backgroundColor    = [UIColor colorWithRed:24.0/255.0 green:157.0/255.0 blue:216.0/255.0 alpha:1];
        
        [_setCalorie setTitle:@"卡" forState:UIControlStateNormal];
        [_setCalorie setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_setCalorie addTarget:self action:@selector(setCalorieAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_setCalorie];
    }
    return _setCalorie;
}

-(UIButton *)setDistance{
    if(!_setDistance){
        _setDistance = [[UIButton alloc]initWithFrame:CGRectMake(90, 470, 25, 25)];
        _setDistance.layer.cornerRadius = 12.5;
        _setDistance.backgroundColor    = [UIColor whiteColor];
        
        [_setDistance setTitle:@"距" forState:UIControlStateNormal];
        [_setDistance setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_setDistance addTarget:self action:@selector(setDistanceAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_setDistance];
    }
    return _setDistance;
}

#pragma  mark btnAction

-(void)goAction:(UIButton *)btn{
    RunViewController *run = [[RunViewController alloc]initWithCellNum:whichOne];

    [self.navigationController pushViewController:run animated:YES];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setCalorieAction{
    _setCalorie.backgroundColor  = [UIColor colorWithRed:24.0/255.0 green:157.0/255.0 blue:216.0/255.0 alpha:1];
    _setTime.backgroundColor     = [UIColor whiteColor];
    _setDistance.backgroundColor = [UIColor whiteColor];
    
    [_setDistance setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_setCalorie setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_setTime setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.rect.aim.text = @"卡 路 里(大卡):";
    self.rect.aim_num.text = [NSString stringWithFormat:@"%.0f",_Acaloire];
    [self setCircleShape];

}

-(void)setTimeAction{
    _setTime.backgroundColor     = [UIColor colorWithRed:24.0/255.0 green:157.0/255.0 blue:216.0/255.0 alpha:1];
    _setCalorie.backgroundColor  = [UIColor whiteColor];
    _setDistance.backgroundColor = [UIColor whiteColor];
    
    [_setDistance setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_setTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_setCalorie setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.rect.aim.text = @"运动时间(分钟):";
    self.rect.aim_num.text =  [NSString stringWithFormat:@"%.0f",_Atime];
    [self setCircleShape];
}

-(void)setDistanceAction{
    _setDistance.backgroundColor = [UIColor colorWithRed:24.0/255.0 green:157.0/255.0 blue:216.0/255.0 alpha:1];
    _setTime.backgroundColor     = [UIColor whiteColor];
    _setCalorie.backgroundColor  = [UIColor whiteColor];
    
    [_setCalorie setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_setDistance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_setTime setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.rect.aim.text = @"运动距离(公里):";
    self.rect.aim_num.text =  [NSString stringWithFormat:@"%.2f",_Adistance];
    [self setCircleShape];

}

-(void)setBtnAction{

    if(self.setBtn.tag == -1){
        self.setBtn.tag = 1;
        [self.setBtn setImage:nil forState:UIControlStateNormal];
        [self.setBtn setTitle:@"<" forState:UIControlStateNormal];
        
        self.setBtn.titleLabel.textColor = [UIColor whiteColor];
        self.setBtn.backgroundColor      = [UIColor colorWithRed:24.0/255.0 green:157.0/255.0 blue:216.0/255.0 alpha:1];
        
        UIBezierPath *bezierD = [UIBezierPath bezierPathWithArcCenter:CGPointMake(187, 435) radius:100 startAngle:[self returnArc:152] endAngle:[self returnArc:270] clockwise:1];
        
        [self.setDistance.layer addAnimation:[self getKeyframeAnimationWithBeizer:bezierD] forKey:nil];
        
        UIBezierPath *bezierC = [UIBezierPath bezierPathWithArcCenter:CGPointMake(187, 435) radius:100 startAngle:[self returnArc:152] endAngle:[self returnArc:220] clockwise:1];
        
        [self.setCalorie.layer addAnimation:[self getKeyframeAnimationWithBeizer:bezierC] forKey:nil];
        
        UIBezierPath *bezierT = [UIBezierPath bezierPathWithArcCenter:CGPointMake(187, 435) radius:100 startAngle:[self returnArc:152] endAngle:[self returnArc:320] clockwise:1];
        
        [self.setTime.layer addAnimation:[self getKeyframeAnimationWithBeizer:bezierT] forKey:nil];
        
        UIBezierPath *bezierB = [UIBezierPath bezierPathWithArcCenter:CGPointMake(187, 435) radius:100 startAngle:[self returnArc:152] endAngle:[self returnArc:36] clockwise:0];
        
        [self.setBtn.layer addAnimation:[self getKeyframeAnimationWithBeizer:bezierB] forKey:nil];

        self.setTime.layer.position     = CGPointMake(self.view.bounds.size.width/2 + 76.5, 370.5);
        self.setDistance.layer.position = CGPointMake(self.view.bounds.size.width/2, 335);
        self.setCalorie.layer.position  = CGPointMake(self.view.bounds.size.width/2 - 76.5, 370.5);
        self.setBtn.layer.position      = CGPointMake(self.view.bounds.size.width/2 + 80.8, 493.5);
        
        [UIView animateWithDuration:0.32 animations:^{
            self.circleView.center           = CGPointMake(self.view.bounds.size.width/2, 450);
            self.setTime.layer.transform     = CATransform3DMakeScale(1.5, 1.5, 1.5);
            self.setDistance.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
            self.setCalorie.layer.transform  = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }];
        
        [UIView commitAnimations];
        
        POPBasicAnimation *layerMove = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
        layerMove.duration           = 0.31;
        layerMove.toValue            = [NSValue valueWithCGPoint:CGPointMake(self.view.bounds.size.width/2, 450)];
        layerMove.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.circleShapeRun pop_addAnimation:layerMove forKey:nil];
        
    }
    else{
        self.setBtn.tag = -1;
        [self.setBtn setImage:[UIImage imageNamed:@"setBtn"] forState:UIControlStateNormal];
        self.setBtn.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *bezierD = [UIBezierPath bezierPathWithArcCenter:CGPointMake(187, 435) radius:100 startAngle:[self returnArc:270] endAngle:[self returnArc:152] clockwise:0];
        
        [self.setDistance.layer addAnimation:[self getKeyframeAnimationWithBeizer:bezierD] forKey:nil];
        
        UIBezierPath *bezierC = [UIBezierPath bezierPathWithArcCenter:CGPointMake(187, 435) radius:100 startAngle:[self returnArc:220] endAngle:[self returnArc:152] clockwise:0];
        
        [self.setCalorie.layer addAnimation:[self getKeyframeAnimationWithBeizer:bezierC] forKey:nil];
        
        UIBezierPath *bezierT = [UIBezierPath bezierPathWithArcCenter:CGPointMake(187, 435) radius:100 startAngle:[self returnArc:320] endAngle:[self returnArc:152] clockwise:0];
        
        [self.setTime.layer addAnimation:[self getKeyframeAnimationWithBeizer:bezierT] forKey:nil];
        
        UIBezierPath *bezierB = [UIBezierPath bezierPathWithArcCenter:CGPointMake(187, 435) radius:100 startAngle:[self returnArc:36] endAngle:[self returnArc:152] clockwise:1];
        
        [self.setBtn.layer addAnimation:[self getKeyframeAnimationWithBeizer:bezierB] forKey:nil];

        self.setTime.frame      = CGRectMake(90, 470, 25, 25);
        self.setDistance.frame  = CGRectMake(90, 470, 25, 25);
        self.setCalorie.frame   = CGRectMake(90, 470, 25, 25);
        self.setBtn.layer.frame = CGRectMake(90, 470, 25, 25);
        
        [UIView animateWithDuration:0.32 animations:^{
            self.circleView.center           = CGPointMake(self.view.bounds.size.width/2, 435);
            self.setTime.layer.transform     = CATransform3DMakeScale(1, 1, 1);
            self.setDistance.layer.transform = CATransform3DMakeScale(1, 1, 1);
            self.setCalorie.layer.transform  = CATransform3DMakeScale(1, 1, 1);
        }];
        
        [UIView commitAnimations];
        
        POPBasicAnimation *layerMove = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
        layerMove.duration           = 0.35;
        layerMove.toValue            = [NSValue valueWithCGPoint:CGPointMake(self.view.bounds.size.width/2, 435)];
        layerMove.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.circleShapeRun pop_addAnimation:layerMove forKey:nil];
    }
}

-(CGFloat)returnArc:(CGFloat)angle{
    return angle * (M_PI / 180);
}

#pragma mark animation
-(CAKeyframeAnimation *)getKeyframeAnimationWithBeizer:(UIBezierPath *)bezierPath{
    CAKeyframeAnimation *key = [CAKeyframeAnimation animation];
    key.path                 = bezierPath.CGPath;
    key.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    key.keyPath              = @"position";
    key.duration             = 0.32;

    return key;
}

@end

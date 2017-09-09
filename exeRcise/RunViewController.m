//
//  RunViewController.m
//  exeRcise
//
//  Created by hemeng on 17/4/21.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "RunViewController.h"
#import "RunModel.h"

@interface RunViewController ()<MapViewDelegate,StopButtonDelegate,ResultViewDelegate>{
    int whichOne;//第几模块 代表运动方式
    int distanceFilter;//距离过滤器
    double distance;//获取从mapview取得的距离 单位 km
    int totaltime;//总计时间 单位s
    float calorie;
    
    CAGradientLayer *gradientLayer;
    
    NSOperationQueue *queue;
    
    int theSecond;//时分秒
    int theMinute;
    int theHour;
    
    BOOL btnIshidden;//判断开始按钮是显示还是隐藏 默认隐藏 值yes
}

@end

@implementation RunViewController

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (instancetype)initWithCellNum:(int)num
{
    self = [super init];
    if (self) {
        whichOne       = num;
        distanceFilter = 0;
        distance       = 0;
        totaltime      = 0;
        btnIshidden    = YES;
        
        if(num == 0)//设定定位点更新距离(根据不同的运动方式)
            distanceFilter = 10;
        else if(num == 1)
            distanceFilter = 30;
        else if(num == 2)
            distanceFilter = 5;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    theSecond = 0;
    theMinute = 0;
    theHour = 0;

    //创建地图
    [self map];
    
    [self background];
    //创建label
    [self createLabel];
    //暂停按钮
    [self PauseBtn];
    //停止按钮
    [self stopBtn];
    //开始按钮
    [self startBtn];
    //查看地图按钮
    [self ToMapBtn];
    
    queue = [[NSOperationQueue alloc]init];//开启子线程用来计时
    
    [queue setMaxConcurrentOperationCount:5];
    
    NSInvocationOperation *invo = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(queueMission:) object:nil];
    
    [queue addOperation:invo];

    
    // Do any additional setup after loading the view.
}
#pragma mark view
-(mapView *)map{
    if(!_map){
        _map = [[mapView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) withDistanceFilter:distanceFilter];
        _map.userInteractionEnabled = NO;
        _map.delegate = self;
        
        [self.view addSubview:_map];

    }
    return _map;
}

-(ResultView *)result{
    if(!_result){
        
        _result = [[ResultView alloc]initWithTime:totaltime
                                     withDistance:distance
                                      withCalorie:calorie
                                         withType:whichOne];
                   
        _result.frame                  = CGRectMake(0, 0, 320, 320);
        _result.center                 = self.view.center;
        _result.layer.cornerRadius     = 15;
        _result.layer.masksToBounds    = YES;
        _result.delegate               = self;
        _result.userInteractionEnabled = YES;
        
        [self.view addSubview:_result];
        
    }
    return _result;
}

-(UIImageView *)background{
    if(!_background){
        _background                        = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _background.image                  = [UIImage imageNamed:@"background2"];
        _background.userInteractionEnabled = YES;
        
        [self.view addSubview:_background];
        
        CGRect rect = self.background.bounds;
        rect.size.height += 20;
        rect.size.width  += 20;
        //创建gradientLayer 颜色渐变图层
        gradientLayer                  = [CAGradientLayer layer];;
        gradientLayer.frame            = rect;
        gradientLayer.colors           = @[(__bridge id)[UIColor blackColor].CGColor,
                                           (__bridge id)[UIColor clearColor].CGColor];
        gradientLayer.locations        = @[@(0.97),@(1)];
        gradientLayer.startPoint       = CGPointMake(0, 0);
        gradientLayer.endPoint         = CGPointMake(0.75, 1);
        
        UIView *contanier = [[UIView alloc]initWithFrame:self.background.bounds];
        [contanier.layer addSublayer:gradientLayer];
        
        self.background.maskView = contanier;

    }
    return _background;
}

-(void)createLabel{
    if(!_velocity){
        NSString *str;
        NSMutableAttributedString *attributeStr;
        if(whichOne == 0)
            str = @"配速\n\n\nm's\"";
        else
            str = @"平均速度\n\n\nkm/h";
        
        attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        
        UILabel *label       = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 150)];
        label.center         = CGPointMake(self.view.bounds.size.width/2, 320);
        label.textAlignment  = NSTextAlignmentCenter;
        label.font           = [UIFont systemFontOfSize:18];
        label.textColor      = [UIColor grayColor];
        label.attributedText = attributeStr;
        label.numberOfLines  = 4;
        
        [self.background addSubview:label];
        
        _velocity               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 80)];
        _velocity.center        = CGPointMake(self.view.bounds.size.width/2, 320);
        _velocity.text          = @"0.0";
        _velocity.textColor     = [UIColor whiteColor];
        _velocity.textAlignment = NSTextAlignmentCenter;
        _velocity.font          = [UIFont systemFontOfSize:42];
        
        [self.background addSubview:_velocity];
    }
    if(!_L_timer){
        
        NSString *str = @"运动时间\n\n\nhh:mm:ss";
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        
        UILabel *label       = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 150)];
        label.center         = CGPointMake(self.view.bounds.size.width/2, 90);
        label.textAlignment  = NSTextAlignmentCenter;
        label.attributedText = attributeStr;
        label.numberOfLines  = 4;
        label.font           = [UIFont systemFontOfSize:18];
        label.textColor      = [UIColor grayColor];
        [self.background addSubview:label];
        
        _L_timer               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 80)];
        _L_timer.center        = CGPointMake(self.view.bounds.size.width/2, 90);
        _L_timer.text          = @"00:00:00";
        _L_timer.textAlignment = NSTextAlignmentCenter;
        _L_timer.textColor     = [UIColor whiteColor];
        _L_timer.font          = [UIFont systemFontOfSize:42];
        
        [self.background addSubview:_L_timer];
    }
    if(!_L_distance){
        NSString *str = @"里程\n\n\nkm";
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        
        UILabel *label       = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 150)];
        label.center         = CGPointMake(self.view.bounds.size.width/2, 210);
        label.textAlignment  = NSTextAlignmentCenter;
        label.attributedText = attributeStr;
        label.numberOfLines  = 4;
        label.font           = [UIFont systemFontOfSize:18];
        label.textColor      = [UIColor grayColor];
        
        [self.background addSubview:label];
        
        _L_distance               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 80)];
        _L_distance.center        = CGPointMake(self.view.bounds.size.width/2, 210);
        _L_distance.text          = @"0.00";
        _L_distance.textColor     = [UIColor whiteColor];
        _L_distance.textAlignment = NSTextAlignmentCenter;
        _L_distance.font          = [UIFont systemFontOfSize:42];
        
        [self.background addSubview:_L_distance];
    }
}

#pragma mark Delegate
-(void)DidFinishedClickStopButton{
    if(totaltime < 60 || distance < 0.2){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您运动距离或时间过短,无法统计,请问是否结束?" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
            self.stopBtn.shapeLayer.strokeEnd = 0.f;//动画效果重置
        }];
        
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        //创建模糊背景
        [self createBlurEffectiveView];
        
        self.ToMapBtn.userInteractionEnabled = NO;
        self.stopBtn.userInteractionEnabled = NO;
        
        //计算卡路里
        RunModel *model = [[RunModel alloc]init];
        calorie = [model GetCalorieWithType:whichOne withSeconds:totaltime/60 withDistance:distance];
        
        [self result];//显示结算界面
        [_timer invalidate];//停止计时器
        [queue cancelAllOperations];//取消对列任务
    }
    
}
-(void)DidClickBackMapButton:(mapView *)view{
    
    self.background.userInteractionEnabled = YES;
    
    [self.map DoAnimationOut];
    
    [UIView animateWithDuration:2.f animations:^{
        
        gradientLayer.locations = @[@(0.97),@(1)];
    }];
    
    [UIView setAnimationDelay:1.f];
    
    [UIView commitAnimations];
    
    if(btnIshidden == YES){
        
        self.stopBtn.hidden                   = NO;
        self.PauseBtn.hidden                  = NO;
        self.stopBtn.userInteractionEnabled   = YES;
        self.PauseBtn.userInteractionEnabled  = YES;
    }
    else{
        _startBtn.hidden                 = NO;
        _startBtn.userInteractionEnabled = YES;
    }
    
    self.ToMapBtn.userInteractionEnabled   = YES;
    self.map.userInteractionEnabled        = NO;
}

-(void)didClickConfirmBtn:(ResultView *)view{
    //释放blur内存
    self.blurView = nil;
    
    RunModel *model = [[RunModel alloc]init];
    NSString *newStr = @"";
    if(whichOne == 0){//把跑步的速度显示成小数 服务器上的数据库才能接受
        NSString *oldStr = self.velocity.text;
        
        int length = (int)oldStr.length;
        for(int i = 0;i < length; i++){
            unichar c = [oldStr characterAtIndex:i];
            
            if([[NSString stringWithFormat:@"%C",c] isEqualToString:@"'"]){
                newStr = [newStr stringByAppendingString:@"."];
            }
            else if([[NSString stringWithFormat:@"%C",c] isEqualToString:@"\""]){
                ;
            }
            else{
                newStr = [newStr stringByAppendingString:[NSString stringWithFormat:@"%C",c]];
            }
        }
    }
    else{
        newStr = self.velocity.text;
    }
    
    NSDictionary *dic = @{@"calorie":[NSNumber numberWithFloat:(int)calorie],
                          @"distance":[NSNumber numberWithFloat:distance],
                          @"time":[NSNumber numberWithFloat:totaltime/60],
                          @"speed":newStr};
    
    //保存数据进入本地以及服务器
    //先更新数据库再更新userinfo 因为是根据useinfo的数据上传到数据库
    //添加data与record数据
    
    [model UpdateDataToLocalWithExerciseType:whichOne withDic:dic];
    [model UpdateDataToNetWorkWithExerciseType:whichOne withDic:dic];
    [model updataUserInfoWithExerciseType:whichOne withDic:dic];
    
    NSNotification *noti = [NSNotification notificationWithName:@"AfterRunRefreshUI" object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:noti];
    
    //向服务器提交maprecord
    
    [model postMapTrackRecordWithArray:self.map.MapReocrdAr];
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
}

#pragma mark ButtonAndAction
-(UIButton *)startBtn{
    if(!_startBtn){
        _startBtn                        = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
        _startBtn.center                 = CGPointMake(self.view.bounds.size.width/2, 480);
        _startBtn.layer.cornerRadius     = 45;
        _startBtn.layer.borderColor      = [UIColor blackColor].CGColor;
        _startBtn.layer.borderWidth      = 1.f;
        _startBtn.userInteractionEnabled = NO;
        _startBtn.hidden                 = YES;
        
        [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.background addSubview:_startBtn];
    }
    return _startBtn;
}

-(UIButton *)PauseBtn{
    if(!_PauseBtn){
        _PauseBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
        _PauseBtn.center             = CGPointMake(self.view.bounds.size.width/2 - 100, 480);
        _PauseBtn.layer.cornerRadius = 45;
        _PauseBtn.layer.borderWidth  = 1.f;
        _PauseBtn.layer.borderColor  = [UIColor blackColor].CGColor;

        [_PauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [_PauseBtn addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.background addSubview:_PauseBtn];
    }
    return _PauseBtn;
}

-(StopButton *)stopBtn{
    if(!_stopBtn){
        _stopBtn          = [[StopButton alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
        _stopBtn.center   = CGPointMake(self.view.bounds.size.width/2 + 100, 480);
        _stopBtn.delegate = self;

        
        [self.background addSubview:_stopBtn];
    }
    return _stopBtn;
}

-(UIButton *)ToMapBtn{
    if(!_ToMapBtn){
        _ToMapBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 70, self.view.bounds.size.height - 90, 70, 90)];
        _ToMapBtn.backgroundColor = [UIColor clearColor];
        
        [_ToMapBtn addTarget:self action:@selector(ToMapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_ToMapBtn];
    }
    return _ToMapBtn;
}

-(void)pauseAction:(UIButton *)btn{//暂停或开始
    [_timer setFireDate:[NSDate distantFuture]];
    
    self.map.isExercising = NO;
    btnIshidden           = NO;
    
    [self ButtonAnimation];
}

-(void)startAction:(UIButton *)btn{
    [_timer setFireDate:[NSDate distantPast]];
    
    self.map.isExercising = YES;
    btnIshidden           = YES;
    
    [self ButtonAnimation];
}

-(void)ToMapAction:(UIButton *)btn{//进入地图btn
    _background.userInteractionEnabled = NO;
    
    [self.map DoAnimationIn];
    
    [UIView animateWithDuration:2.f animations:^{
        gradientLayer.locations = @[@(0),@(0.15)];
    }];
    
    [UIView commitAnimations];
    
    if(_startBtn.hidden == YES){//开始按钮是隐藏
        btnIshidden = YES;
        self.stopBtn.userInteractionEnabled  = NO;
        self.PauseBtn.userInteractionEnabled = NO;
        self.stopBtn.hidden                  = YES;
        self.PauseBtn.hidden                 = YES;
        
    }
    else{//开始按钮是显示
        btnIshidden                          = NO;
        self.startBtn.userInteractionEnabled = NO;
        self.startBtn.hidden                 =YES;
    }
    self.ToMapBtn.userInteractionEnabled = NO;
    self.map.userInteractionEnabled      = YES;
}

#pragma mark Animtaion
-(void)ButtonAnimation{
    POPBasicAnimation *pop = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    POPBasicAnimation *pop2 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    pop.duration  = 0.3f;
    pop2.duration = 0.3f;
    
    if(_startBtn.userInteractionEnabled == NO){
        
        pop.toValue   = [NSValue valueWithCGRect:CGRectMake(self.view.bounds.size.width/2, 480, 90, 90)];
        pop2.toValue  = [NSValue valueWithCGRect:CGRectMake(self.view.bounds.size.width/2, 480, 90, 90)];
    }
    else {
        _startBtn.hidden = YES;
        _stopBtn.hidden  = NO;
        _PauseBtn.hidden = NO;
        
        _stopBtn.userInteractionEnabled  = YES;
        _PauseBtn.userInteractionEnabled = YES;
        
        pop.toValue   = [NSValue valueWithCGRect:CGRectMake(self.view.bounds.size.width/2 - 100, 480, 90, 90)];
        pop2.toValue  = [NSValue valueWithCGRect:CGRectMake(self.view.bounds.size.width/2 + 100, 480, 90, 90)];
    }
    [_PauseBtn.layer pop_addAnimation:pop forKey:nil];
    [_stopBtn.layer pop_addAnimation:pop2 forKey:nil];
    
    [self performSelector:@selector(btnMethods) withObject:nil afterDelay:0.28f];
    
}

-(void)btnMethods{
    if(_startBtn.userInteractionEnabled == NO){
        
        _startBtn.hidden = NO;
        _stopBtn.hidden  = YES;
        _PauseBtn.hidden = YES;
        
        _startBtn.userInteractionEnabled = YES;
        _stopBtn.userInteractionEnabled  = NO;
        _PauseBtn.userInteractionEnabled = NO;
    }
    else{
        _startBtn.userInteractionEnabled = NO;
    }
}

#pragma mark queueAndTimeAction
-(void)queueMission:(NSInvocationOperation *)invo{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];//计时器
    
    [[NSRunLoop currentRunLoop] run];
}

-(void)timerAction{
    theSecond++;//0-60s
    totaltime++;//总时间 单位s
    
    if(theSecond > 59){
        theSecond = 0;
        theMinute++;
    }
    if(theMinute > 59){
        theMinute = 0;
        theHour++;
    }
    
    NSString *str1;
    NSString *str2;
    NSString *str3;
    
    if(theSecond <= 9)
        str1 = [NSString stringWithFormat:@":0%d",theSecond];
    else
        str1 = [NSString stringWithFormat:@":%d",theSecond];
    
    if(theMinute <= 9)
        str2 = [NSString stringWithFormat:@":0%d",theMinute];
    else
        str2 = [NSString stringWithFormat:@":%d",theMinute];
    
    if(theHour <= 9)
        str3 = [NSString stringWithFormat:@"0%d",theHour];
    else
        str3 = [NSString stringWithFormat:@"%d",theHour];
    
    _L_timer.text    = [[str3 stringByAppendingString:str2] stringByAppendingString:str1];

    if(totaltime % 5 == 0){//每5秒刷新距离和速度
        distance         = self.map.distance;//公里
        _L_distance.text = [NSString stringWithFormat:@"%.2f",distance];
        
        if(distance != 0){
            if(whichOne == 0){
                int velocity = (1/distance) * totaltime;
                _velocity.text = [NSString stringWithFormat:@"%d'%d\"", velocity / 60, velocity % 60];//配速指多少分秒完成一公里
            }
            else{
                double speed = distance / ((double)totaltime / 3600);
                _velocity.text = [NSString stringWithFormat:@"%.2f",speed];
            }
        }
    }
}

#pragma mark blurEffect
-(UIImage *)snapShot{
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    return image;
}

-(void)createBlurEffectiveView{
    UIImage * image = [self snapShot];
    
    self.blurView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.blurView.image = image;
    [self.view addSubview:self.blurView];
    
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //创建模糊view
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.view.bounds;
    
    [self.blurView addSubview:effectView];
    
}


@end

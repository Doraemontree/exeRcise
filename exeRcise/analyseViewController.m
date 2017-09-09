//
//  analyseViewController.m
//  exeRcise
//
//  Created by hemeng on 17/5/15.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "analyseViewController.h"
#import "AppDelegate.h"
#import "nDataBase.h"

#define card_top_margin 6
#define card_margin 5

@interface analyseViewController (){
    float maxDis_R;
    int maxTime_R;//单位 miao
    float maxDis_C;
    int maxTime_C;
    float maxDis_W;
    int maxTime_W;
    
    NSString *favouriteStr;
    
    CATransform3D ForiginalT;//保存3个卡片的transform
    CATransform3D SoriginalT;
    CATransform3D ToriginalT;
    
    CGPoint originalCenter;//187.5 380
    
    NSMutableArray *arrange;//三个analyse顺序
}

@property(nonatomic,strong)AppDelegate *appDelegate;

@end

@implementation analyseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        maxDis_R  = 0;
        maxTime_R = 0;
        maxDis_C  = 0;
        maxTime_C = 0;
        maxDis_W  = 0;
        maxTime_W = 0;
    }
    return self;
}

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nDataBase *database = [[nDataBase alloc]init];
    
    self.recordAr = [database loadDataFromLocalWithUserId:self.appDelegate.userInfo.uid withEntity:@"Record"];
    
    int i1 = 0,i2 = 0,i3 = 0;
    for(Record *r in self.recordAr){
        if(r.type == 0){
            if(r.distant > maxDis_R)
                maxDis_R = r.distant;
            if(r.time > maxTime_R)
                maxTime_R = r.time;
            i1++;
        }
        else if(r.type == 1){
            if(r.distant > maxDis_C)
                maxDis_C = r.distant;
            if(r.time > maxTime_C)
                maxTime_C = r.time;
            i2++;
        }
        else if(r.type == 2){
            if(r.distant > maxDis_W)
                maxDis_W = r.distant;
            if(r.time > maxTime_W)
                maxTime_W = r.time;
            i3++;
        }
    }
    if(i1 > i2){
        if(i1 > i3)
            favouriteStr = @"跑步";
        else
            favouriteStr = @"步行";
    }
    else{
        if(i2 > i3)
            favouriteStr = @"骑行";
        else
            favouriteStr = @"步行";
    }
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationItem.title = @"运动生涯";
    
    UIBarButtonItem *backbtn  = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(BarbackAction)];
    backbtn.tintColor         = [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = backbtn;
    
    [self background];
    
    [self running];
    
    [self cycling];
    
    [self walking];
    
    originalCenter = CGPointMake(187.5, 380);
    
    [self w_analyse];
    [self c_analyse];
    [self r_analyse];

    arrange = [NSMutableArray array];//按顺序初始化
    [arrange addObject:self.r_analyse];
    [arrange addObject:self.c_analyse];
    [arrange addObject:self.w_analyse];
    
    self.running.selected = YES;
    // Do any additional setup after loading the view.
}

-(void)BarbackAction{
    self.navigationController.navigationBar.hidden = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIImageView *)background{
    if(!_background){
        _background = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _background.layer.transform = CATransform3DMakeTranslation(0, 0, -460);
        
        [_background setImage:[UIImage imageNamed:@"background2"]];
        [self.view addSubview:_background];
        
    }
    return _background;
}

-(AnalyseView *)w_analyse{
    if(!_w_analyse){
        _w_analyse = [[AnalyseView alloc]initWithFrame:CGRectMake(40, 120, self.view.bounds.size.width - 80, 520)
                                              withType:1
                                            withMaxDis:maxDis_W
                                           withMaxTime:maxTime_W
                                      withTotalCalorie:[[self.appDelegate.userInfo.walkingAr objectAtIndex:3] floatValue]
                                         withTotalTime:[[self.appDelegate.userInfo.walkingAr objectAtIndex:5] floatValue]
                                          withTotalDis:[[self.appDelegate.userInfo.walkingAr objectAtIndex:4] floatValue]
                                     withFavouriteType:favouriteStr];
        
        _w_analyse.backgroundColor     = [UIColor whiteColor];
        _w_analyse.layer.cornerRadius  = 10;
        _w_analyse.layer.masksToBounds = YES;
        _w_analyse.layer.borderColor   = [UIColor blackColor].CGColor;
        _w_analyse.layer.borderWidth   = 1.f;
        _w_analyse.layer.transform     = CATransform3DMakeScale(0.9, 0.9, 1);
        _w_analyse.center              = CGPointMake(originalCenter.x, originalCenter.y - 40);
        
        ToriginalT = _w_analyse.layer.transform;
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanGesture:)];
        
        [_w_analyse addGestureRecognizer:panGesture];
        
        [self.view addSubview:_w_analyse];
    }
    
    return _w_analyse;
}

-(AnalyseView *)r_analyse{
    if(!_r_analyse){
        _r_analyse = [[AnalyseView alloc]initWithFrame:CGRectMake(40, 120, self.view.bounds.size.width - 80, 520)
                                              withType:-1
                                            withMaxDis:maxDis_R
                                           withMaxTime:maxTime_R
                                      withTotalCalorie:[[self.appDelegate.userInfo.runningAr objectAtIndex:3] floatValue]
                                         withTotalTime:[[self.appDelegate.userInfo.runningAr objectAtIndex:5] floatValue]
                                          withTotalDis:[[self.appDelegate.userInfo.runningAr objectAtIndex:4] floatValue]
                                     withFavouriteType:favouriteStr];
        
        _r_analyse.backgroundColor     = [UIColor whiteColor];
        _r_analyse.layer.cornerRadius  = 10;
        _r_analyse.layer.borderColor   = [UIColor blackColor].CGColor;
        _r_analyse.layer.masksToBounds = YES;
        _r_analyse.layer.borderWidth   = 1.f;
        
        ForiginalT      = self.r_analyse.layer.transform;

        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanGesture:)];
        
        [_r_analyse addGestureRecognizer:panGesture];
        
        [self.view addSubview:_r_analyse];
    }
    return _r_analyse;
}

-(AnalyseView *)c_analyse{
    if(!_c_analyse){
        _c_analyse = [[AnalyseView alloc]initWithFrame:CGRectMake(40, 120, self.view.bounds.size.width - 80, 520)
                                              withType:0
                                            withMaxDis:maxDis_C
                                           withMaxTime:maxTime_C
                                      withTotalCalorie:[[self.appDelegate.userInfo.cyclingAr objectAtIndex:3] floatValue]
                                         withTotalTime:[[self.appDelegate.userInfo.cyclingAr objectAtIndex:5] floatValue]
                                          withTotalDis:[[self.appDelegate.userInfo.cyclingAr objectAtIndex:4] floatValue]
                                     withFavouriteType:favouriteStr];
        
        _c_analyse.backgroundColor     = [UIColor whiteColor];
        _c_analyse.layer.cornerRadius  = 10;
        _c_analyse.layer.borderColor   = [UIColor blackColor].CGColor;
        _c_analyse.layer.masksToBounds = YES;
        _c_analyse.layer.borderWidth   = 1.f;
        _c_analyse.layer.transform     = CATransform3DMakeScale(0.95, 0.95, 1);
        _c_analyse.center              = CGPointMake(originalCenter.x, originalCenter.y - 20);
        
        SoriginalT = _c_analyse.layer.transform;
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanGesture:)];
        
        [_c_analyse addGestureRecognizer:panGesture];
        
        [self.view addSubview:_c_analyse];
    }
    return _c_analyse;
}

#pragma mark button
-(UIButton *)running{
    if(!_running){
        _running = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
        _running.center = CGPointMake(187.5 - 100, 85);
        
        [_running setTitle:@"跑步" forState:UIControlStateNormal];
        [_running setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_running setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        [self.view addSubview:_running];
    }
    return _running;
}

-(UIButton *)cycling{
    if(!_cycling){
        _cycling = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
        _cycling.center = CGPointMake(187.5, 85);
        
        [_cycling setTitle:@"骑行" forState:UIControlStateNormal];
        [_cycling setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_cycling setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        [self.view addSubview:_cycling];
    }
    return _cycling;
}

-(UIButton *)walking{
    if(!_walking){
        _walking = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
        _walking.center = CGPointMake(187.5 + 100, 85);
        
        [_walking setTitle:@"步行" forState:UIControlStateNormal];
        [_walking setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_walking setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
  
        [self.view addSubview:_walking];
    }
    return _walking;
}

#pragma mark gesture

-(void)PanGesture:(UIPanGestureRecognizer *)recognizer{
 
    CGPoint movePoint = [recognizer translationInView:self.view];//移动点到初始点的距离

    AnalyseView *firstObject  = (AnalyseView *)[arrange objectAtIndex:0];
    AnalyseView *secondObject = (AnalyseView *)[arrange objectAtIndex:1];
    AnalyseView *threeObject  = (AnalyseView *)[arrange objectAtIndex:2];

    if(recognizer.state == UIGestureRecognizerStateChanged){//在变幻

        firstObject.center  = CGPointMake(originalCenter.x + movePoint.x, originalCenter.y + movePoint.y);
        secondObject.center = CGPointMake(originalCenter.x + movePoint.x/12, originalCenter.y - 20 + movePoint.y/12);
        threeObject.center  = CGPointMake(originalCenter.x + movePoint.x/24, originalCenter.y - 40 + movePoint.y/24);
        
        if(firstObject.center.x < 184.5 && firstObject.center.x > 157.5){//在左边
            firstObject.layer.transform  = CATransform3DRotate(ForiginalT,-(182.5 - firstObject.center.x)/3.5 * M_PI / 180, 0, 0, 1);
            secondObject.layer.transform = CATransform3DRotate(SoriginalT,-(182.5 - firstObject.center.x)/5.5 * M_PI / 180, 0, 0, 1);
            threeObject.layer.transform  = CATransform3DRotate(ToriginalT,-(182.5 - firstObject.center.x)/8 * M_PI / 180, 0, 0, 1);
        }
        else if(firstObject.center.x >= 184.5 && firstObject.center.x < 190.5){//中间
            
            firstObject.layer.transform  = ForiginalT;
            secondObject.layer.transform = SoriginalT;
            threeObject.layer.transform  = ToriginalT;
        }
        else if(firstObject.center.x > 190.5 && firstObject.center.x < 217.5){//右边
            
            firstObject.layer.transform  = CATransform3DRotate(ForiginalT,-(182.5 - firstObject.center.x)/3.5 * M_PI / 180, 0, 0, 1);
            secondObject.layer.transform = CATransform3DRotate(SoriginalT,-(182.5 - firstObject.center.x)/5.5 * M_PI / 180, 0, 0, 1);
            threeObject.layer.transform  = CATransform3DRotate(ToriginalT,-(182.5 - firstObject.center.x)/8 * M_PI / 180, 0, 0, 1);
        }
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded){//结束拉拽

        if(firstObject.center.x < 50){//左滑卡片将卡片拖出去
            
            [UIView animateWithDuration:0.25f animations:^{
                firstObject.center = CGPointMake(firstObject.center.x - 200, firstObject.center.y + 50);
            } completion:^(BOOL finished){
                [self dragAnimation:firstObject :secondObject :threeObject];
                
            }];
            
        }
        else if(firstObject.center.x > 325){//右滑卡片将卡片拖出去
            [UIView animateWithDuration:0.25f animations:^{
                firstObject.center = CGPointMake(firstObject.center.x + 200, firstObject.center.y + 50);
            } completion:^(BOOL finished){
                 [self dragAnimation:firstObject :secondObject :threeObject];
            }];
        }
        else{//没有拖出去
            [self turnBackAnimation:firstObject :secondObject :threeObject];//恢复原状
        }
    }
}

-(void)turnBackAnimation:(AnalyseView *)firstObject :(AnalyseView *)secondObject :(AnalyseView *)threeObject{
    [UIView animateWithDuration:0.35f animations:^{
        
        firstObject.center           = originalCenter;
        secondObject.center          = CGPointMake(originalCenter.x, originalCenter.y - 20);
        threeObject.center           = CGPointMake(originalCenter.x, originalCenter.y - 40);
        firstObject.layer.transform  = ForiginalT;
        secondObject.layer.transform = SoriginalT;
        threeObject.layer.transform  = ToriginalT;
    }];
}

-(void)dragAnimation:(AnalyseView *)firstObject :(AnalyseView *)secondObject :(AnalyseView *)threeObject{
    
    [arrange addObject:firstObject];
    [arrange removeObjectAtIndex:0];
    
    //设置按钮
    self.running.selected = NO;
    self.walking.selected = NO;
    self.cycling.selected = NO;
    if([[arrange objectAtIndex:0] isEqual:self.r_analyse])
        self.running.selected = YES;
    else if([[arrange objectAtIndex:0] isEqual:self.c_analyse])
        self.cycling.selected = YES;
    else if([[arrange objectAtIndex:0] isEqual:self.w_analyse])
        self.walking.selected = YES;
    
    secondObject.layer.transform = SoriginalT;
    threeObject.layer.transform  = ToriginalT;
    threeObject.center           = CGPointMake(originalCenter.x, originalCenter.y - 40);
    secondObject.center          = CGPointMake(originalCenter.x, originalCenter.y - 20);
    
    //firstobject要变成fourobject的位置
    firstObject.layer.transform = ForiginalT;
    firstObject.layer.transform = CATransform3DMakeScale(0.85, 0.85, 1);
    firstObject.center          = CGPointMake(originalCenter.x, originalCenter.y - 60);
    
    [self.view bringSubviewToFront:threeObject];
    [self.view bringSubviewToFront:secondObject];
    
    [UIView animateWithDuration:0.2f delay:0.05f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        secondObject.layer.transform = CATransform3DMakeScale(1, 1, 1);
        secondObject.center = originalCenter;
    } completion:nil];
    [UIView animateWithDuration:0.2f delay:0.15f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        threeObject.layer.transform  = CATransform3DMakeScale(0.95, 0.95, 1);
        threeObject.center  = CGPointMake(originalCenter.x, originalCenter.y - 20);
    } completion:nil];
    [UIView animateWithDuration:0.2f delay:0.25f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        firstObject.layer.transform  = CATransform3DMakeScale(0.9, 0.9, 1);
        firstObject.center  = CGPointMake(originalCenter.x, originalCenter.y - 40);
    } completion:nil];
    
}


@end

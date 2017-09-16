//
//  ViewController.m
//  exeRcise
//
//  Created by hemeng on 17/4/19.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "exericseViewController.h"
#import "LoginViewController.h"
#import "DetailRecordViewController.h"
#import "EssayViewController.h"
#import "analyseViewController.h"
#import "ViewControllerModel.h"
#import "nDataBase.h"
#import "InfoViewController.h"
#import "ShopViewController.h"
#import "ChartViewController.h"
#import "QRCodeViewController.h"
#import "QRScanViewController.h"
#import "ViewControllerHelper.h"


@interface ViewController (){
    ViewControllerModel *model;
}

@property(nonatomic,strong)AppDelegate *appDelegate;

@property BOOL didLogin;

@end

@implementation ViewController

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (instancetype)initWithDidLogin
{
    self = [super init];
    if (self) {
        
        _didLogin = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self);
    
    //个人界面UI
    [self userView];
    //多功能界面UI
    [self multfunctionView];
//preprocessor macros 命令 区别target
#if KE
    //主界面UI
    [self mainView];
#endif
    //横条UI
    [self Ctabbar];
    
    //notification
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(gotoExerciseControllerWithNumber:) name:@"gotoExerciseVC" object:nil];
    [center addObserver:self selector:@selector(gotoDetailRecordViewController) name:@"openRecordController" object:nil];
    [center addObserver:self selector:@selector(gotoInfoViewController) name:@"openInfoController" object:nil];
    [center addObserver:self selector:@selector(reLoginAction) name:@"reLogin" object:nil];
    [center addObserver:self selector:@selector(gotoEssayControllerWithNumber:) name:@"passItemToMain" object:nil];
    [center addObserver:self selector:@selector(openAnaylseViewController) name:@"openAnaylseController" object:nil];
    [center addObserver:self selector:@selector(openChartViewController) name:@"openChartController" object:nil];
    [center addObserver:self selector:@selector(refreshMainView) name:@"RefreshAfterAlterInfo" object:nil];
    [center addObserver:self selector:@selector(gotoShopViewController) name:@"openShopViewController" object:nil];
    [center addObserver:self selector:@selector(finishDownloadImage) name:@"finishDownloadImage" object:nil];
    [center addObserver:self selector:@selector(gotoQRCodeViewController) name:@"openQRCodeController" object:nil];
    [center addObserver:self selector:@selector(gotoQRScanViewController) name:@"openQRScanViewController" object:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)finishDownloadImage{
    [self.userView setImage];
    
}

-(MainView *)mainView{
    if(!_mainView){
        _mainView = [[MainView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        [self.view addSubview:_mainView];
    }
    return _mainView;
}

-(UserView *)userView{
    if(!_userView){
        
        _userView = [[UserView alloc]initWithFrame:self.view.bounds];
        _userView.delegate = self;
        
        //设置头像
        [self.view addSubview:_userView];
    }
    return _userView;
}

-(MultfunctionView *)multfunctionView{
    if(!_multfunctionView){
        _multfunctionView = [[MultfunctionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        [self.view addSubview:_multfunctionView];
    }
    return _multfunctionView;
}

-(CustomTabbar *)Ctabbar{
    if(!_Ctabbar){
        _Ctabbar = [[CustomTabbar alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50)];
        
        _Ctabbar.backgroundColor = [UIColor whiteColor];
        _Ctabbar.delegate = self;
        
        [self.view addSubview:_Ctabbar];
    }
    return _Ctabbar;
}

#pragma mark delegate
-(void)tabbarDidClickButton:(CustomTabbar *)view withButtonNumber:(int)num{//tabbar
    if(num == 0){//left
        
        [self.view bringSubviewToFront:_multfunctionView];
        [self.view bringSubviewToFront:_Ctabbar];
    }
    else if(num == 1){//middle
        [self.view bringSubviewToFront:_mainView];
        [self.view bringSubviewToFront:_Ctabbar];
        
    }
    else if(num == 2){//right
        
        [self.view bringSubviewToFront:_userView];
        [self.view bringSubviewToFront:_Ctabbar];
    }
}

-(void)DidClickExitButton:(UserView *)view{//退出登录按钮代理方法
  
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"" forKey:@"id"];
    
    LoginViewController *login = [[LoginViewController alloc]init];
    
    NaviController *navi = [[NaviController alloc]initWithRootViewController:login];
    
    login.refreshViewBlock = ^(void){
        [self refreshMainView];
    };
    login.checkLastLoginTime = ^{
        [model autoUpdateLastLoginTimeAndTodayCDT];
        
        //这个时候userinfo的uid已经初始化了
        [model DownloadUserImageTolocalWithUid:self.appDelegate.userInfo.uid];
    };
    
    [ViewControllerHelper changeRootViewControllerWithController:navi
                                                     withOptions:UIViewAnimationOptionTransitionNone
                                                withDurationTime:0.5 withComplietion:nil];

}

-(void)refreshMainView{//重新登录刷新所有显示界面
    
    self.Ctabbar.right.selected = NO;//重新进入主界面后需要把tabbar按钮selected也重置
    
    [self.userView refreshUserView];
    
    [self.multfunctionView refreshMultfunctionView];
    
    [self.view bringSubviewToFront:_mainView];
    [self.view bringSubviewToFront:_Ctabbar];
}

#pragma mark notifation
-(void)gotoEssayControllerWithNumber:(NSNotification *)notification{
    EssayViewController *vc = [[EssayViewController alloc]init];
    
    NSNotification *no = [NSNotification notificationWithName:@"essay" object:nil userInfo:notification.userInfo];
    
    [[NSNotificationCenter defaultCenter]postNotification:no];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoShopViewController{
    ShopViewController *vc = [[ShopViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoExerciseControllerWithNumber:(NSNotification *)notification{
    
    int n = (int)[[notification.userInfo objectForKey:@"number"]integerValue];
    
    exericseViewController *vc = [[exericseViewController alloc]initWithCellNumber:n];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)openAnaylseViewController{
    analyseViewController *analyse = [[analyseViewController alloc]init];
    
    [self.navigationController pushViewController:analyse animated:YES];
}

-(void)openChartViewController{
    ChartViewController *vc = [[ChartViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoDetailRecordViewController{
    DetailRecordViewController *detail = [[DetailRecordViewController alloc]init];
    
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)gotoInfoViewController{
    InfoViewController *info = [[InfoViewController alloc]init];
    
    info.refreshUserImage = ^(void){
        [self.userView setImage];
    };
    
    [self.navigationController pushViewController:info animated:YES];
}

-(void)gotoQRCodeViewController{
    QRCodeViewController *qr = [[QRCodeViewController alloc]init];
    
    [self.navigationController pushViewController:qr animated:YES];
}

-(void)gotoQRScanViewController{
    QRScanViewController *scan = [[QRScanViewController alloc]init];
    
    [self.navigationController pushViewController:scan animated:YES];
}

-(void)reLoginAction{//登录和注册都要执行这方法刷新原来数据和界面
    [self.view bringSubviewToFront:_mainView];
    [self.view bringSubviewToFront:_Ctabbar];

    [self refreshMainView];
    
}

-(void)test{
    //    [userDefault setObject:@"" forKey:@"id"];
    //
    //    nDataBase *database = [[nDataBase alloc]init];
    //
    //    Record *u = [[database loadDataFromLocalWithUserId:@"18328035630" withEntity:@"Record"] firstObject];
    //    NSLog(@"%@",u.uid);
    //    NSLog(@"%f",u.calorie);
    //    NSLog(@"%f",u.time);
    //    NSLog(@"%d",u.num);
    //    NSLog(@"%@",u.date);
    
    ////
    //    User *u = [[database loadDataFromLocalWithUserId:uid withEntity:@"User"] firstObject];
    //    NSLog(@"%@",u.uid);
    //    NSLog(@"%@",u.password);
    //    NSLog(@"%@",u.lastLoginTime);
    //
    //    RunningData *ar = [[database loadDataFromLocalWithUserId:uid withEntity:@"RunningData"] firstObject];
    //    NSLog(@"%f",ar.todayC);
    //    NSLog(@"%f",ar.todayT);
    //    NSLog(@"%f",ar.todayD);
    //    NSLog(@"%f",ar.totalC);
    //    NSLog(@"%f",ar.totalD);
    //    NSLog(@"%f",ar.totalT);
    //
    //    CyclingData *s = [[database loadDataFromLocalWithUserId:uid withEntity:@"CyclingData"] firstObject];
    //    NSLog(@"%f",s.todayC);
    //
    //    NSLog(@"%f",s.todayD);
    //    NSLog(@"%f",s.todayT);
    //
    //    NSLog(@"%f",s.totalC);
    //    NSLog(@"%f",s.totalD);
    //    NSLog(@"%f",s.totalT);
    //
    //    Uinfo *a = [[database loadDataFromLocalWithUserId:uid withEntity:@"Uinfo"] firstObject];
    //
    //    NSLog(@"%f",a.aimC);
    //    NSLog(@"%d",a.height);
    //    NSLog(@"%d",a.weight);
    //
    //    NSArray *r = [database loadDataFromLocalWithUserId:uid withEntity:@"Record"];
    //    for (Record *q in r) {
    //        NSLog(@"%@",q.speed);
    //        NSLog(@"%f",q.distant);
    //        NSLog(@"%f",q.time);
    //        NSLog(@"%d",q.num);
    //    }

}
@end

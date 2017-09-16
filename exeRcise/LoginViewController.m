//
//  LoginViewController.m
//  exeRcise
//
//  Created by hemeng on 17/4/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "LoginModel.h"
#import "nDataBase.h"
#import "ViewControllerHelper.h"
#import "ViewController.h"
#import "NaviController.h"



@interface LoginViewController ()<UITextFieldDelegate>{
    UIView *underLine1;
    UIView *underLine2;
    
    LoginModel *Lmodel;

}

@property(nonatomic,strong)AppDelegate *appdelegate;

@end

@implementation LoginViewController

-(AppDelegate *)appdelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Lmodel = [[LoginModel alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self icon];
    
    [self createBtn];
    
    [self createLabel];
    
    [self createTextfield];
    
    //开场动画
    [self performSelector:@selector(DoAnimation) withObject:nil afterDelay:0.5];
    
}
#pragma mark UI
-(UIImageView *)icon{
    if(!_icon){
        _icon        = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        _icon.image  = [UIImage imageNamed:@"icon"];
        _icon.center = CGPointMake(self.view.bounds.size.width/2, 140);
        
        [self.view addSubview:_icon];
    }
    return _icon;
}

-(void)createTextfield{
    _password                 = [[UITextField alloc]initWithFrame:CGRectMake(-185, 330, 185, 35)];
    _password.backgroundColor = [UIColor clearColor];
    _password.borderStyle     =  UITextBorderStyleNone;
    _password.secureTextEntry = YES;
    _password.placeholder     = @"请输入密码";
    
    [self.view addSubview:_password];
    
    underLine1 = [[UIView alloc]initWithFrame:CGRectMake(-185, 356, 175, 1)];
    underLine1.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:underLine1];
    
    _userid                 = [[UITextField alloc]initWithFrame:CGRectMake(-185, 260, 185, 35)];
    _userid.backgroundColor = [UIColor clearColor];
    _userid.borderStyle     =  UITextBorderStyleNone;
    _userid.placeholder     = @"请输入11位手机号";
    _userid.keyboardType    = UIKeyboardTypeNumberPad;
    _userid.delegate        = self;
    
    [self.view addSubview:_userid];
    
    underLine2 = [[UIView alloc]initWithFrame:CGRectMake(-185, 286, 175, 1)];
    underLine2.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:underLine2];
}

-(void)createLabel{
    _L_userid               = [[UILabel alloc]initWithFrame:CGRectMake(-255, 260, 70, 35)];
    _L_userid.text          = @"用户名:";
    _L_userid.textColor     = [UIColor grayColor];
    _L_userid.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:_L_userid];
    
    _L_password               = [[UILabel alloc]initWithFrame:CGRectMake(-255, 330, 70, 35)];
    _L_password.text          = @"密码:";
    _L_password.textColor     = [UIColor grayColor];
    _L_password.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:_L_password];
}

-(void)createBtn{
    _registerBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 60)];
    _registerBtn.center             = CGPointMake(-150, 540);
    _registerBtn.layer.cornerRadius = 30;
    _registerBtn.layer.borderWidth  = 2.f;
    _registerBtn.layer.borderColor  = [UIColor grayColor].CGColor;
    
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    _loginBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 60)];
    _loginBtn.center             = CGPointMake(-150, 450);
    _loginBtn.layer.cornerRadius = 30;
    _loginBtn.layer.borderWidth  = 2.f;
    _loginBtn.layer.borderColor  = [UIColor grayColor].CGColor;
    
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
}

-(customAlert *)alert{
    if(!_alert){
        _alert                        = [[customAlert alloc]initWithFrame:CGRectMake(0, 0, 250, 170)];
        _alert.center                 = self.view.center;
        self.alert.backgroundColor    = [UIColor grayColor];
        self.alert.alpha              = 0.7;
        self.alert.layer.cornerRadius = 25;
        
        [self.view addSubview:_alert];
    }
    return _alert;
}

#pragma mark action
-(void)registerAction:(UIButton *)btn{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)loginBtnAction{//登入
    [self.alert setMessage:@"正在登陆中" isCenter:NO];
    [self alert];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = 10.f;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"id":_userid.text,@"password":_password.text};
    
    [manager POST:@"http://139.199.158.105/login.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *r = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        if([r isEqualToString:@"success"]){
            
            [self releaseAlert];
            
            NSLog(@"登入成功");            
//            //储存登陆用户id 在第一次加载程序时候检查id是否为空 若为空则进入登陆界面
//            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//            [userDefault setObject:_userid.text forKey:@"id"];
            [self afterSuccess];
            
        }
        else if([r isEqualToString:@"error"]){
            //设置alert
            [self.alert setMessage:@"帐号或密码错误" isCenter:YES];
            [self.alert ActivityIndicatorViewHidden];
            [self performSelector:@selector(releaseAlert) withObject:nil afterDelay:2.f];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if(error.code == -1001 || error.code == -1009){
            //设置alert
            [self.alert setMessage:@"连接超时,请检查网络" isCenter:YES];
            [self.alert ActivityIndicatorViewHidden];
            [self performSelector:@selector(releaseAlert) withObject:nil afterDelay:2.f];
        }
    }];
}

#pragma mark animation
-(void)DoAnimation{
    [UIView animateWithDuration:0.55 animations:^{
        
        self.L_userid.frame  = CGRectMake(50, 260, 70, 35);
        self.userid.frame    = CGRectMake(130, 260, 185, 35);
        underLine2.frame     = CGRectMake(130, 286, 175, 1);
    }];
    [UIView animateWithDuration:0.55 delay:0.4 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        self.L_password.frame = CGRectMake(50, 330, 70, 35);
        self.password.frame   = CGRectMake(130, 330, 185, 35);
        underLine1.frame      = CGRectMake(130, 356, 175, 1);
        
    } completion:^(BOOL finished){}];
    [UIView animateWithDuration:0.55 delay:0.8 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        self.loginBtn.center = CGPointMake(self.view.bounds.size.width/2, 450);
        
    } completion:^(BOOL finished){}];
    [UIView animateWithDuration:0.55 delay:1.2 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        self.registerBtn.center = CGPointMake(self.view.bounds.size.width/2, 540);
        
    } completion:^(BOOL finished){}];
}

#pragma mark textfield

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(range.location <= 10)
        return YES;
    else
        return NO;
}

#pragma mark releaseAction
-(void)releaseAlert{
    [self.alert removeFromSuperview];
    
    self.alert = nil;
}


-(void)afterSuccess{
    //只加载userinfo cdata wdata rdata表
    
    /*登陆成功后检查本地数据是否有该用户的数据
     若有该用户的数据 则不做操作
     若没有该用户的数据 则下载数据
     */
    //if([Lmodel isUserDataExistInLocalWithUid:_userid.text] == NO){//查看本地是否有数据 no为没有
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //到服务器下载数据
        [manager GET:@"http://139.199.158.105/loadData.php" parameters:@{@"id":_userid.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //用返回json数据用dic保存
            //然后存进本地
            NSArray *jsonAr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            //dic0-4表示 user uinfo running cycling walking
            //下载的数据转换成5个表的data
            NSMutableDictionary *Udic = [NSMutableDictionary dictionaryWithDictionary:[jsonAr objectAtIndex:0]];
            NSMutableDictionary *Idic = [NSMutableDictionary dictionaryWithDictionary:[jsonAr objectAtIndex:1]];
            NSMutableDictionary *Rdic = [NSMutableDictionary dictionaryWithDictionary:[jsonAr objectAtIndex:2]];
            NSMutableDictionary *Cdic = [NSMutableDictionary dictionaryWithDictionary:[jsonAr objectAtIndex:3]];
            NSMutableDictionary *Wdic = [NSMutableDictionary dictionaryWithDictionary:[jsonAr objectAtIndex:4]];
            
            //读取数据先加载进本地数据库再加载到appdelegate的userInfo
            [Lmodel addAllDataToLocalWithUdic:Udic
                                     withIdic:Idic
                                     withWdic:Wdic
                                     withRdic:Rdic
                                     withCdic:Cdic];
            
            //需要等待返回数据
            [self DoModel];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    //}
//    else{
//        //不需要等待返回数据
//        [self DoModel];
//    }
}

-(void)DoModel{
    //设置appdelegate的userinfo里面uid的值
    self.appdelegate.userInfo = [Lmodel GetUserInfoWithUid:_userid.text];
    
    NSString *str = _userid.text;
    //设置userdefault
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:str forKey:@"id"];
    
    self.refreshViewBlock();
    
    self.checkLastLoginTime();
    
    ViewController *vc = [[ViewController alloc]init];
    
    NaviController *navi = [[NaviController alloc]initWithRootViewController:vc];
    
    [ViewControllerHelper changeRootViewControllerWithController:navi
                                                     withOptions:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionTransitionCrossDissolve
                                                withDurationTime:1.0 withComplietion:nil];
    
}

-(NSString *)getTodayDate{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *str = [formatter stringFromDate:date];
    
    return str;
}




@end

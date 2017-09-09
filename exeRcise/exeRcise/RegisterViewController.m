//
//  RegisterViewController.m
//  exeRcise
//
//  Created by hemeng on 17/4/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "RegisterViewController.h"
#import <UIKit+AFNetworking.h>
#import "RegisterModel.h"

@interface RegisterViewController ()<genderViewDelegate,UITextFieldDelegate>{
    RegisterModel *Rmodel;
}
@end

@implementation RegisterViewController

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建数据模型
    Rmodel = [[RegisterModel alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self icon];
    
    [self createTextField];
    
    [self createBtn];
    
    [self createLabel];
    
    // Do any additional setup after loading the view.
}
#pragma mark ui
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

-(genderView *)genderview{
    if(!_genderview){
        _genderview = [[genderView alloc]initWithFrame:self.view.bounds];
        _genderview.delegate = self;
        
        [self.view addSubview:_genderview];
    
    }
    return _genderview;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon        = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        _icon.image  = [UIImage imageNamed:@"icon"];
        _icon.center = CGPointMake(self.view.bounds.size.width/2, 120);
        
        [self.view addSubview:_icon];
    }
    return _icon;
}
-(void)createTextField{
    _name                 = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 185, 35)];
    _name.backgroundColor = [UIColor clearColor];
    _name.borderStyle     = UITextBorderStyleNone;
    _name.center          = CGPointMake(self.view.bounds.size.width/2 + 25, 390);
    _name.placeholder     = @"请输入用户名";
    
    [self.view addSubview:_name];
    
    UIView *underLine1 = [[UIView alloc]initWithFrame:CGRectMake(115, 400, 180, 1)];
    underLine1.tag = 3;
    underLine1.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:underLine1];
    
    _userid                 = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 185, 35)];
    _userid.backgroundColor = [UIColor clearColor];
    _userid.borderStyle     =  UITextBorderStyleNone;
    _userid.center          = CGPointMake(self.view.bounds.size.width/2 + 25, 250);
    _userid.placeholder     = @"请输入11位手机号";
    _userid.keyboardType    = UIKeyboardTypeNumberPad;
    _userid.delegate        = self;
    
    [self.view addSubview:_userid];
    
    UIView *underLine2 = [[UIView alloc]initWithFrame:CGRectMake(115, 260, 180, 1)];
    underLine2.tag = 2;
    underLine2.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:underLine2];
    
    _password                 = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 185, 35)];
    _password.backgroundColor = [UIColor clearColor];
    _password.borderStyle     =  UITextBorderStyleNone;
    _password.center          = CGPointMake(self.view.bounds.size.width/2 + 25, 320);
    _password.secureTextEntry = YES;
    _password.placeholder     = @"请输入密码";
    
    [self.view addSubview:_password];
    
    UIView *underLine3 = [[UIView alloc]initWithFrame:CGRectMake(115, 330, 180, 1)];
    underLine3.tag = 1;
    underLine3.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:underLine3];
}
-(void)createLabel{
    UILabel *password;
    UILabel *userid;
    UILabel *n;
    
    password               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 35)];
    password.center        = CGPointMake(70, 320);
    password.text          = @"密码:";
    password.textColor     = [UIColor grayColor];
    password.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:password];
    
    userid               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 35)];
    userid.center        = CGPointMake(70, 250);
    userid.text          = @"手机号:";
    userid.textColor     = [UIColor grayColor];
    userid.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:userid];
    
    n               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 35)];
    n.center        = CGPointMake(70, 390);
    n.text          = @"用户名:";
    n.textColor     = [UIColor grayColor];
    n.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:n];
    
}
-(void)createBtn{
    _backBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 60)];
    _backBtn.center             = CGPointMake(self.view.bounds.size.width/2, 580);
    _backBtn.layer.cornerRadius = 30;
    _backBtn.layer.borderWidth  = 2.f;
    _backBtn.layer.borderColor  = [UIColor grayColor].CGColor;
    
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_backBtn];
    
    _nextBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 60)];
    _nextBtn.center             = CGPointMake(self.view.bounds.size.width/2, 490);
    _nextBtn.layer.cornerRadius = 30;
    _nextBtn.layer.borderWidth  = 2.f;
    _nextBtn.layer.borderColor  = [UIColor grayColor].CGColor;
    
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
}

#pragma mark action
-(void)nextAction:(UIButton *)btn{
    
    if(_userid.text.length != 11 || [_password.text isEqualToString:@""]){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确信息" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
        [self genderview];
    
}
-(void)backAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark genderviewDelegate
-(void)DidClickConfirmBtn:(genderView *)view{
    [self.alert setMessage:@"正在注册中" isCenter:NO];
    [self alert];

    //点击确定按钮向服务器提交数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSDictionary *dic = @{@"id":_userid.text,
                          @"password":_password.text,
                          @"name":_name.text,
                          @"height":[NSNumber numberWithInt:_genderview.h],
                          @"weight":[NSNumber numberWithInt:_genderview.w],
                          @"lastLoginTime":[self getTodayDate],
                          @"sex":_genderview.sex,
                          @"aimC":[NSNumber numberWithFloat:5000],
                          @"aimD":[NSNumber numberWithFloat:15],
                          @"aimT":[NSNumber numberWithFloat:120]
                          };
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 10.f;
    
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",
                                                          @"text/html",
                                                          @"text/plain",
                                                          @"image/jpeg",
                                                          @"image/png",
                                                          @"application/octet-stream",
                                                          @"text/json",
                                                          nil];
    
    [manager POST:@"http://139.199.158.105/register.php" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *r = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",r);
        
        if([r isEqualToString:@"HasSameId"]){
            
            [self.alert setMessage:@"该账号已经存在!" isCenter:YES];
            [self.alert ActivityIndicatorViewHidden];
            [self performSelector:@selector(releaseAlertAndPop) withObject:nil afterDelay:2.f];
            
        }
        else if([r isEqualToString:@"success"]){//如果服务器返回成功
            [self releaseAlert];
            
            NSLog(@"注册成功");
            //储存登陆用户id 在第一次加载程序时候检查id是否为空 若为空则进入登陆界面
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:_userid.text forKey:@"id"];
            
            //设置模型里面uid的值
            self.appDelegate.userInfo = [Rmodel setUserInfoWithUserInfoDic:dic];
            
            [Rmodel addDataToLocalDataBaseWithUserDic:dic];//成功注册后的操作 添加数据进入本地数据库
            
            //发送通知 通知login页面
            NSNotification *noti = [NSNotification notificationWithName:@"registerToLogin" object:nil];
            [[NSNotificationCenter defaultCenter]postNotification:noti];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else if([r isEqualToString:@"QueryError"]){
            NSLog(@"服务器错误");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(error.code == -1001 || error.code == -1009){
            
            [self.alert setMessage:@"网络连接失败" isCenter:YES];
            [self.alert ActivityIndicatorViewHidden];
            [self performSelector:@selector(releaseAlert) withObject:nil afterDelay:2.f];
        }
    }];
}

-(void)DidClickBackBtn:(genderView *)view{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark textfileDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //限制长度在11位数字以内
    if(textField == _userid){
        
        if(range.location <= 10)
            return  YES;
        else
            return NO;
    }
    return YES;
}

#pragma releaseAction
-(void)releaseAlertAndPop{
    [self.alert removeFromSuperview];
    
    self.alert = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)releaseAlert{
    [self.alert removeFromSuperview];
    
    self.alert = nil;
}

-(NSString *)getTodayDate{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *str = [formatter stringFromDate:date];
    return str;
}


@end

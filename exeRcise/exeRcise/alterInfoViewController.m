//
//  alterInfoViewController.m
//  exeRcise
//
//  Created by hemeng on 17/6/23.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "alterInfoViewController.h"
#import "alterModel.h"

@interface alterInfoViewController ()<UITextFieldDelegate>{
    NSString *title;
    NSString *barTitleName;
    
    UILabel *Plabel;
    UILabel *Plabel2;
    UITextField *Ptextfield;
    UITextField *Ptextfield2;
    UIButton *Pbtn;
    
    UILabel *Dlabel1;
    UILabel *Dlabel2;
    UILabel *Dlabel3;
    UITextField *Dtextfield1;
    UITextField *Dtextfield2;
    UITextField *Dtextfield3;
    UIButton *Dbtn;
    
    UILabel *Ulabel;
    UITextField *Utextfield;
    UIButton *Ubtn;
    
    UILabel *Hlabel1;
    UILabel *Hlabel2;
    UITextField *Htextfield1;
    UITextField *Htextfield2;
    UIButton *Hbtn;
}

@end

@implementation alterInfoViewController
-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NotificationAction:) name:@"openAlterInfoVC" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self background];
    
    self.navigationItem.title = title;
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = backBtn;
    
    if([title isEqualToString:@"密码"]){
        [self createPasswordView];
    }
    else if([title isEqualToString:@"身高体重"]){
        [self createHeightAndWeightView];
    }
    else if([title isEqualToString:@"用户名"]){
        [self createUserNameView];
    }
    else if([title isEqualToString:@"每日目标"]){
        [self createDaliyAimView];
    }
    
    // Do any additional setup after loading the view.
}
-(UIImageView *)background{
    if(!_background){
        _background = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _background.image = [UIImage imageNamed:@"background2"];
        
        [self.view addSubview:_background];
    }
    return _background;
}

-(void)NotificationAction:(NSNotification *)noti{
    //title = dic[@"value"];错误写法
    title = noti.userInfo[@"value"];
}

-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createPasswordView{
    if(!Plabel){
        Plabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 60, 50)];
        Plabel.text = @"原密码";
        Plabel.backgroundColor = [UIColor whiteColor];
        Plabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:Plabel];
        
        Plabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 60, 50)];
        Plabel2.text = @"新密码";
        Plabel2.backgroundColor = [UIColor whiteColor];
        Plabel2.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:Plabel2];
        
        Ptextfield = [[UITextField alloc]initWithFrame:CGRectMake(60, 75, 315, 50)];
        Ptextfield.backgroundColor = [UIColor whiteColor];
        Ptextfield.placeholder = @"请输入原密码";
        Ptextfield.secureTextEntry = YES;
        Ptextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:Ptextfield];
        
        Ptextfield2 = [[UITextField alloc]initWithFrame:CGRectMake(60, 140, 315, 50)];
        Ptextfield2.backgroundColor = [UIColor whiteColor];
        Ptextfield2.placeholder = @"仅支持10位字符以内";
        Ptextfield2.delegate = self;
        Ptextfield2.secureTextEntry = YES;
        Ptextfield2.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:Ptextfield2];
        
        Pbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 210, 335, 40)];
        Pbtn.backgroundColor = [UIColor purpleColor];
        Pbtn.layer.cornerRadius = 5;
        [Pbtn setTitle:@"确定" forState:UIControlStateNormal];
        [Pbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Pbtn];
    }
}

-(void)createDaliyAimView{
    if(!Dlabel1){
        Dlabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 60, 50)];
        Dlabel1.text = @"卡路里";
        Dlabel1.backgroundColor = [UIColor whiteColor];
        Dlabel1.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:Dlabel1];
        
        Dlabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 60, 50)];
        Dlabel2.text = @"距离";
        Dlabel2.backgroundColor = [UIColor whiteColor];
        Dlabel2.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:Dlabel2];
        
        Dlabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 205, 60, 50)];
        Dlabel3.text = @"时间";
        Dlabel3.backgroundColor = [UIColor whiteColor];
        Dlabel3.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:Dlabel3];
        
        Dtextfield1 = [[UITextField alloc]initWithFrame:CGRectMake(60, 75, 315, 50)];
        Dtextfield1.placeholder = @"请输入1000-10000大卡";
        Dtextfield1.text = [NSString stringWithFormat:@"%d",(int)self.appDelegate.userInfo.aimC];
        Dtextfield1.keyboardType = UIKeyboardTypeNumberPad;
        Dtextfield1.clearButtonMode = UITextFieldViewModeWhileEditing;
        Dtextfield1.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:Dtextfield1];
        
        Dtextfield2 = [[UITextField alloc]initWithFrame:CGRectMake(60, 140, 315, 50)];
        Dtextfield2.placeholder = @"请输入5-50公里以内";
        Dtextfield2.text = [NSString stringWithFormat:@"%d",(int)self.appDelegate.userInfo.aimD];
        Dtextfield2.keyboardType = UIKeyboardTypeNumberPad;
        Dtextfield2.backgroundColor = [UIColor whiteColor];
        Dtextfield2.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:Dtextfield2];
        
        Dtextfield3 = [[UITextField alloc]initWithFrame:CGRectMake(60, 205, 315, 50)];
        Dtextfield3.placeholder = @"请输入30-600分钟以内";
        Dtextfield3.text = [NSString stringWithFormat:@"%d",(int)self.appDelegate.userInfo.aimT];
        Dtextfield3.keyboardType = UIKeyboardTypeNumberPad;
        Dtextfield3.backgroundColor = [UIColor whiteColor];
        Dtextfield3.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:Dtextfield3];
        
        Dbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 275, 335, 40)];
        Dbtn.layer.cornerRadius = 5;
        [Dbtn setTitle:@"确定" forState:UIControlStateNormal];
        Dbtn.backgroundColor = [UIColor purpleColor];
        [Dbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Dbtn];
        
    }
}

-(void)createUserNameView{
    if(!Ulabel){
        Ulabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 70, 50)];
        Ulabel.textAlignment = NSTextAlignmentCenter;
        Ulabel.text = @"用户名";
        Ulabel.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:Ulabel];
        
        Utextfield = [[UITextField alloc]initWithFrame:CGRectMake(70, 75, 305, 50)];
        Utextfield.text = self.appDelegate.userInfo.name;
        Utextfield.placeholder = @"请输入7字符以内的数字、英文和汉字";
        Utextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        Utextfield.backgroundColor = [UIColor whiteColor];
        Utextfield.delegate = self;
        [self.view addSubview:Utextfield];
        
        Ubtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 145, 335, 40)];
        Ubtn.layer.cornerRadius = 5;
        Ubtn.backgroundColor = [UIColor purpleColor];
        [Ubtn setTitle:@"确定" forState:UIControlStateNormal];
        [Ubtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Ubtn];
        
    }
}

-(void)createHeightAndWeightView{
    if(!Hlabel1){
        Hlabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 60, 50)];
        Hlabel1.text = @"身高";
        Hlabel1.backgroundColor = [UIColor whiteColor];
        Hlabel1.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:Hlabel1];
        
        Hlabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 60, 50)];
        Hlabel2.text = @"体重";
        Hlabel2.backgroundColor = [UIColor whiteColor];
        Hlabel2.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:Hlabel2];
        
        Htextfield1 = [[UITextField alloc]initWithFrame:CGRectMake(60, 75, 315, 50)];
        Htextfield1.backgroundColor = [UIColor whiteColor];
        Htextfield1.placeholder = @"请输入140-210cm之间";
        Htextfield1.text = [NSString stringWithFormat:@"%d",self.appDelegate.userInfo.height];
        Htextfield1.keyboardType = UIKeyboardTypeNumberPad;
        Htextfield1.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:Htextfield1];
        
        Htextfield2 = [[UITextField alloc]initWithFrame:CGRectMake(60, 140, 315, 50)];
        Htextfield2.backgroundColor = [UIColor whiteColor];
        Htextfield2.placeholder = @"请输入35-200kg之间";
        Htextfield2.keyboardType = UIKeyboardTypeNumberPad;
        Htextfield2.delegate = self;
        Htextfield2.text = [NSString stringWithFormat:@"%d",self.appDelegate.userInfo.weight];
        Htextfield2.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:Htextfield2];
        
        Hbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 210, 335, 40)];
        Hbtn.backgroundColor = [UIColor purpleColor];
        Hbtn.layer.cornerRadius = 5;
        [Hbtn setTitle:@"确定" forState:UIControlStateNormal];
        [Hbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Hbtn];
    }
    
}
-(void)btnAction:(UIButton *)btn{
    BOOL judge = YES;//判断操作有木有成功
    
    NSDictionary *dic;
    
    alterModel *model = [[alterModel alloc]init];
    
    if(btn == Pbtn){
        if([self.appDelegate.userInfo.password isEqualToString:Ptextfield.text]){
            dic = @{@"value":@"P",
                    @"id":self.appDelegate.userInfo.uid,
                    @"password":Ptextfield2.text,
                    @"username":self.appDelegate.userInfo.name,
                    @"lastLoginTime":self.appDelegate.userInfo.lastLoginTime};
        }
        else{//原密码不对
            NSLog(@"原密码不正确");
            judge = NO;
        }
    }
    else if(btn == Dbtn){
        
        if([Dtextfield1.text intValue] > 10000 || [Dtextfield1.text intValue] < 1000
           ||
           [Dtextfield2.text intValue] > 50 ||[Dtextfield2.text intValue] < 5
           ||
           [Dtextfield3.text intValue] > 600 ||[Dtextfield1.text intValue] < 30){
            NSLog(@"错误数据");
            judge = NO;
        }
        else{//正确
            dic = @{@"value":@"D",
                    @"id":self.appDelegate.userInfo.uid,
                    @"sex":self.appDelegate.userInfo.sex,
                    @"height":[NSNumber numberWithInt:self.appDelegate.userInfo.height],
                    @"weight":[NSNumber numberWithInt:self.appDelegate.userInfo.weight],
                    @"aimC":Dtextfield1.text,
                    @"aimD":Dtextfield2.text,
                    @"aimT":Dtextfield3.text};
        }
    }
    else if(btn == Ubtn){
        if([Utextfield.text isEqualToString:@""]){
            NSLog(@"请输入用户名");
            judge = NO;
        }
        else{//正确
            dic = @{@"value":@"U",
                    @"id":self.appDelegate.userInfo.uid,
                    @"password":self.appDelegate.userInfo.password,
                    @"username":Utextfield.text,
                    @"lastLoginTime":self.appDelegate.userInfo.lastLoginTime};
        }
    }
    else if(btn == Hbtn){
        
        if([Htextfield1.text intValue] > 210 || [Htextfield1.text intValue] < 140
           ||
           [Htextfield2.text intValue] > 200 || [Htextfield2.text intValue] < 35){
            NSLog(@"数据错误");
            judge = NO;
        }
        else{
            dic = @{@"value":@"H",
                    @"id":self.appDelegate.userInfo.uid,
                    @"sex":self.appDelegate.userInfo.sex,
                    @"height":[NSNumber numberWithInt:[Htextfield1.text intValue]],
                    @"weight":[NSNumber numberWithInt:[Htextfield2.text intValue]],
                    @"aimC":[NSNumber numberWithInt:self.appDelegate.userInfo.aimC],
                    @"aimD":[NSNumber numberWithInt:self.appDelegate.userInfo.aimD],
                    @"aimT":[NSNumber numberWithInt:self.appDelegate.userInfo.aimT]};
            //正确
        }
    }
    if(judge == YES){
        
        [model updateNetWordWithDic:dic];
        [model updateLocalDataWithDic:dic];
        [model updateAppdelegateUserInfoWithDic:dic];
        
        NSNotification *noti = [NSNotification notificationWithName:@"RefreshAfterAlterInfo" object:nil];
        
        [[NSNotificationCenter defaultCenter]postNotification:noti];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark textfielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField == Ptextfield2){
        if(range.location > 9)
            return NO;
    }
    else if(textField == Utextfield){
        if(range.location > 6)
            return NO;
    }
    return YES;
}

@end

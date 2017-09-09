//
//  LoginViewController.h
//  exeRcise
//
//  Created by hemeng on 17/4/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customAlert.h"

@interface LoginViewController : UIViewController

@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UITextField *userid;

@property(nonatomic,strong)UITextField *password;

@property(nonatomic,strong)UILabel *L_userid;

@property(nonatomic,strong)UILabel *L_password;

@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)UIButton *registerBtn;

@property(nonatomic,strong)customAlert *alert;

@property(nonatomic,strong)void (^refreshViewBlock)(void);

@property(nonatomic,strong)void (^checkLastLoginTime)(void);


@end

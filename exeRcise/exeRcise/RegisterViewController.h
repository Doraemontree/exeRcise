//
//  RegisterViewController.h
//  exeRcise
//
//  Created by hemeng on 17/4/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "genderView.h"
#import "customAlert.h"

@interface RegisterViewController : UIViewController


@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UITextField *userid;

@property(nonatomic,strong)UITextField *password;

@property(nonatomic,strong)UITextField *name;

@property(nonatomic,strong)UIButton *nextBtn;

@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)AppDelegate *appDelegate;

@property(nonatomic,strong)genderView *genderview;

@property(nonatomic,strong)customAlert *alert;


@end

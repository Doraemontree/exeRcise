//
//  UIViewController+ControllerExtension.h
//  exeRcise
//
//  Created by hemeng on 2017/9/11.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <LGAlertView/LGAlertView.h>

@interface UIViewController (ControllerExtension)

-(void)toast:(NSString *)text :(NSTimeInterval)autoHideTime;

-(void)showMessage:(NSString *)text :(NSTimeInterval)autoHideTime;

-(void)showProgress:(UIView *)view;

-(void)hideProgress:(UIView *)view;

-(void)showErrorAlertMessage:(NSString *)title :(NSString *)message;

-(void)showMessageAlert:(NSString *)title :(NSString *)message;

-(void)actionHandle;

-(void)cancelHandle;

@end

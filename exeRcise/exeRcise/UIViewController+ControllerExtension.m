//
//  UIViewController+ControllerExtension.m
//  exeRcise
//
//  Created by hemeng on 2017/9/11.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "UIViewController+ControllerExtension.h"

@implementation UIViewController (ControllerExtension)

-(void)toast:(NSString *)text :(NSTimeInterval)autoHideTime{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    [hud hideAnimated:YES afterDelay:autoHideTime];
}

-(void)showMessage:(NSString *)text :(NSTimeInterval)autoHideTime{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    [hud hideAnimated:YES afterDelay:autoHideTime];
}

-(void)showProgress:(UIView *)view{
    UIView *_view = self.view;
    if(view != nil){
        _view = view;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_view animated:YES];
    [hud setRemoveFromSuperViewOnHide:YES];
}

-(void)hideProgress:(UIView *)view{
    UIView *_view = self.view;
    if(view != nil){
        _view = view;
    }
    [MBProgressHUD hideHUDForView:_view animated:YES];
}

-(void)showErrorAlertMessage:(NSString *)title :(NSString *)message{
    LGAlertView *alert = [[LGAlertView alloc]initWithViewAndTitle:title message:message style:LGAlertViewStyleAlert view:nil buttonTitles:@[@"确定"] cancelButtonTitle:nil destructiveButtonTitle:nil actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
        
        [alertView dismissAnimated:YES completionHandler:nil];
        
    } cancelHandler:nil destructiveHandler:nil];
    
    [alert showAnimated:YES completionHandler:nil];
}

-(void)showMessageAlert:(NSString *)title :(NSString *)message{
    LGAlertView *alert = [[LGAlertView alloc]initWithViewAndTitle:title message:message style:LGAlertViewStyleAlert view:nil buttonTitles:@[@"确定"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
        
        [alertView dismissAnimated:YES completionHandler:nil];
        [self actionHandle];
        
    } cancelHandler:^(LGAlertView *alertView) {
        
        [alertView dismissAnimated:YES completionHandler:nil];
        [self cancelHandle];
        
    } destructiveHandler:nil];
    
    alert.buttonsTitleColor = [UIColor blackColor];
    alert.cancelButtonTitleColor = [UIColor redColor];
    [alert showAnimated:YES completionHandler:nil];
}

-(void)actionHandle{
    
}

-(void)cancelHandle{
    
}


@end

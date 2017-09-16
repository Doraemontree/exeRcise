//
//  ViewControllerHelper.m
//  exeRcise
//
//  Created by hemeng on 2017/9/14.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ViewControllerHelper.h"

@implementation ViewControllerHelper

+(void)changeRootViewControllerWithController:(UIViewController *)viewController
                                  withOptions:(UIViewAnimationOptions)option
                             withDurationTime:(NSTimeInterval)time
                              withComplietion:(completion)block{
    
    //获取window
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    UIViewController *rootVC = window.rootViewController;
 
    /*如果不移除，可能会有view重叠*/
    [rootVC dismissViewControllerAnimated:NO completion:nil];
    
    [UIView transitionWithView:window duration:time options:option animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        /*如果不重设animationEnabled， 动画可能会有点不正确*/
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = viewController;
        [UIView setAnimationsEnabled:oldState];
        
    } completion:block];
}

@end

//
//  ViewControllerHelper.h
//  exeRcise
//
//  Created by hemeng on 2017/9/14.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewControllerHelper : NSObject

typedef void (^completion)(BOOL);

+(void)changeRootViewControllerWithController:(UIViewController *)viewController
                                  withOptions:(UIViewAnimationOptions)option
                             withDurationTime:(NSTimeInterval)time
                              withComplietion:(completion)block;

@end

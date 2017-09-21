//
//  UIScrollView+Refresh.h
//  exeRcise
//
//  Created by hemeng on 2017/9/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomRefreshControl;

@interface UIScrollView (Refresh)

@property(nonatomic, weak, readonly)CustomRefreshControl *control;

-(void)addRefreshHeaderWithHandle:(void (^)())handle;

@end

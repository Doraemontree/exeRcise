//
//  UIScrollView+Refresh.m
//  exeRcise
//
//  Created by hemeng on 2017/9/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "CustomRefreshControl.h"
#import <objc/runtime.h>

@implementation UIScrollView (Refresh)

-(void)addRefreshHeaderWithHandle:(void (^)())handle {
    CustomRefreshControl *control = [[CustomRefreshControl alloc]init];
    control.handle = handle;
    self.control = control;
    [self insertSubview:control atIndex:0];
}

-(void)setControl:(CustomRefreshControl *)control {
    objc_setAssociatedObject(self, @selector(control), control, OBJC_ASSOCIATION_ASSIGN);
}

-(CustomRefreshControl *)control {
    return objc_getAssociatedObject(self, @selector(control));
}

#pragma mark - Swizzle
+(void)load {
    Method originalMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method swizzleMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"su_dealloc"));
    method_exchangeImplementations(originalMethod, swizzleMethod);
}

-(void)su_dealloc{
    self.control = nil;
    [self su_dealloc];
}

@end

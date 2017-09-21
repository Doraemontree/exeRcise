//
//  UIView+RefreshControl.h
//  exeRcise
//
//  Created by hemeng on 2017/9/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RefreshControl)

/*
 设置或返回View的 x y h w
 */
@property (nonatomic, assign) float h;
@property (nonatomic, assign) float w;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end

//
//  CustomRefreshControl.h
//  exeRcise
//
//  Created by hemeng on 2017/9/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+Refresh.h"

@interface CustomRefreshControl : UIView

@property (nonatomic, copy) void(^handle)();

#pragma mark - 停止动画
- (void)endRefresh;

@end

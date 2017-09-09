//
//  ToolView.h
//  exeRcise
//
//  Created by hemeng on 17/5/4.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToolView;
@protocol ToolViewDelegate <NSObject>

-(void)calorieCalculateToolDidClick:(ToolView *)view;
-(void)BMICalculateToolDidClick:(ToolView *)view;

@end

@interface ToolView : UIView

@property(nonatomic,strong)UIButton *calorieCalculateTool;

@property(nonatomic,strong)UIButton *BMICalculateTool;

@property(nonatomic,weak)id<ToolViewDelegate>delegate;

@end

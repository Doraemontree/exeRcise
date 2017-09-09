//
//  StopButton.h
//  exeRcise
//
//  Created by hemeng on 17/5/8.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StopButtonDelegate <NSObject>

-(void)DidFinishedClickStopButton;

@end

@interface StopButton : UIView

@property(nonatomic,strong)UIButton *stopBtn;

@property(nonatomic,strong)CAShapeLayer *shapeLayer;//执行动画的layer

@property(nonatomic,weak)id<StopButtonDelegate>delegate;


@end

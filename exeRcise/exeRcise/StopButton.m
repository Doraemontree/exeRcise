//
//  StopButton.m
//  exeRcise
//
//  Created by hemeng on 17/5/8.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "StopButton.h"
#import "POP.h"

@implementation StopButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = frame.size.width/2;

        self.backgroundColor = [UIColor clearColor];

        [self CreateButton:self.bounds];
    }
    return self;
}

-(void)CreateButton:(CGRect)frame{
    
    self.stopBtn                    = [[UIButton alloc]initWithFrame:frame];
    self.stopBtn.layer.cornerRadius = frame.size.width/2;
    self.stopBtn.layer.borderWidth  = 1.f;
    self.stopBtn.layer.borderColor  = [UIColor blackColor].CGColor;
    
    [self.stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [self.stopBtn addTarget:self action:@selector(ButtonEventTouchDown) forControlEvents:UIControlEventTouchDown];
    [self.stopBtn addTarget:self action:@selector(ButtonEventTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.stopBtn];
  
    UIBezierPath *beizer = [UIBezierPath bezierPathWithOvalInRect:frame];
    
    self.shapeLayer             = [CAShapeLayer layer];
    self.shapeLayer.path        = beizer.CGPath;
    self.shapeLayer.frame       = frame;
    self.shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeStart = 0.f;
    self.shapeLayer.strokeEnd   = 0.f;
    self.shapeLayer.strokeColor = [UIColor purpleColor].CGColor;
    self.shapeLayer.lineWidth   = 2.f;
    self.shapeLayer.transform   = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);

    [self.stopBtn.layer addSublayer:self.shapeLayer];
}

-(void)ButtonEventTouchDown{//点住按钮不放的动画
    
    [self.stopBtn.layer removeAllAnimations];

    POPBasicAnimation *pop = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    pop.toValue = @(1.f);
    pop.duration = 1.5f;
    pop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.shapeLayer pop_addAnimation:pop forKey:nil];
}
-(void)ButtonEventTouchUpInside{//点击按钮松手后的动画
    
    if(self.shapeLayer.strokeEnd == 1){//完成动画
        [self.delegate DidFinishedClickStopButton];
        
    }
    else{

        [self.shapeLayer pop_removeAllAnimations];
        
        [UIView animateWithDuration:0.1 animations:^{
            self.shapeLayer.strokeEnd = 0.f;
            
        } completion:nil];
        
    }
}
@end

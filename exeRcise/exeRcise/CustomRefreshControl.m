//
//  CustomRefreshControl.m
//  exeRcise
//
//  Created by hemeng on 2017/9/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CustomRefreshControl.h"
#import "UIView+RefreshControl.h"

const CGFloat HeaderHeight = 60.0;
const CGFloat RefreshPullLen = 80.0;

@interface CustomRefreshControl ()<UIScrollViewDelegate>

@property(nonatomic, weak)UIScrollView *scrollView;

@property(nonatomic, strong)CAShapeLayer *linelayer;

@property(nonatomic, assign)CGFloat progress;

@property(nonatomic, assign)BOOL animating;

@property(nonatomic, strong)UILabel *text;

@property(nonatomic, strong)CAShapeLayer *animationLayer;

@property(nonatomic, assign)BOOL isReturn;

@property(nonatomic, assign)BOOL shouldLoosenRefresh;

@end

@implementation CustomRefreshControl

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, HeaderHeight, HeaderHeight)];
    if (self) {
        
        [self initLayer];
        
        [self initLabel];

    }
    return self;
}

-(void)initLayer{
    
    _linelayer = [CAShapeLayer layer];
    _linelayer.frame = self.bounds;
    _linelayer.lineWidth = 0.7f;
    _linelayer.lineCap = kCALineCapRound;
    _linelayer.lineJoin = kCALineJoinRound;
    _linelayer.strokeColor = [UIColor blackColor].CGColor;
    _linelayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(HeaderHeight/2 - 20, HeaderHeight/2)];
    [path addArcWithCenter:CGPointMake(HeaderHeight/2, HeaderHeight/2 + 20)
                    radius:20 * sqrt(2)
                startAngle:[self Arc:225]
                  endAngle:[self Arc:315]
                 clockwise:1];
    [path addArcWithCenter:CGPointMake(HeaderHeight/2, HeaderHeight/2 - 20)
                    radius:20 * sqrt(2)
                startAngle:[self Arc:45]
                  endAngle:[self Arc:135]
                 clockwise:1];
    [path moveToPoint:CGPointMake(HeaderHeight/2 + 7.5, HeaderHeight/2)];
    [path addArcWithCenter:CGPointMake(HeaderHeight/2, HeaderHeight/2)
                    radius:7.5
                startAngle:[self Arc:0]
                  endAngle:[self Arc:360]
                 clockwise:1];

    _linelayer.path = path.CGPath;
    _linelayer.strokeStart = 0.f;
    _linelayer.strokeEnd = 0.f;
    
    [self.layer addSublayer:_linelayer];
    
    _animationLayer = [CAShapeLayer layer];
    _animationLayer.frame = self.bounds;
    _animationLayer.lineWidth = 0.7f;
    _animationLayer.strokeColor = [UIColor blackColor].CGColor;
    _animationLayer.fillColor = [UIColor blackColor].CGColor;
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(HeaderHeight/2 + 3.0, HeaderHeight/2)];
    [path2 addArcWithCenter:CGPointMake(HeaderHeight/2, HeaderHeight/2)
                     radius:3.0
                 startAngle:[self Arc:0]
                   endAngle:[self Arc:360]
                  clockwise:1];
    _animationLayer.path = path2.CGPath;
    _animationLayer.strokeStart = 0.f;
    _animationLayer.strokeEnd = 0.f;
    [self.layer addSublayer:_animationLayer];
    
}

-(void)initLabel {
    _text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    _text.text = @"下拉刷新";
    _text.textAlignment = NSTextAlignmentCenter;
    _text.textColor = [UIColor blackColor];
    _text.font = [UIFont systemFontOfSize:10];
    
    [self addSubview:_text];
}

-(CGFloat)Arc:(CGFloat)angle{
    return angle * (M_PI / 180);
}

#pragma mark - Override
-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview: newSuperview];
    if(newSuperview) {
        self.scrollView = (UIScrollView *)newSuperview;
        self.scrollView.delegate = self;
        self.center = CGPointMake(self.scrollView.centerX, self.centerY);
        self.text.center = CGPointMake(self.scrollView.centerX, self.centerY + 15);
        //keypath一定要写正确
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    else {
        [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    }
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if ([keyPath isEqualToString:@"contentOffset"]) {
        self.progress = -self.scrollView.contentOffset.y;
        
        if(self.progress == 0) {
            _isReturn = NO;
            _shouldLoosenRefresh = NO;
        }
    }
}


-(void)setProgress:(CGFloat)progress {

    _progress = progress;
    if (!self.animating && !_shouldLoosenRefresh) {
        if(!_isReturn){//不是返回途中在画线

            if (progress >= RefreshPullLen) {
                self.text.text = @"松开刷新";
                self.y = -(RefreshPullLen - (RefreshPullLen - HeaderHeight) / 2);
                _shouldLoosenRefresh = YES;
            }
            else {
                self.text.text = @"下拉刷新";
                if (progress <= self.h) {
                    self.y = -progress;
                }
                else {
                    self.y = -(self.h + (progress - self.h) / 2);
                }
            }
            if(!_shouldLoosenRefresh)
                [self setLineLayerStrokeWithProgress:progress];;
        }
    }
    
    if (progress >= RefreshPullLen && !self.animating && !_isReturn) {
        
        if(progress > 100 && self.scrollView.dragging){

            [self startAniWithDragging];
            
            if(self.handle){
                self.handle();
            }
        }
    }
    
    if(!self.scrollView.dragging && _shouldLoosenRefresh && !self.animating && !_isReturn){
        [self stratAniWithNoDragging];
        
        if(self.handle){
            self.handle();
        }
    }
}

-(void)setLineLayerStrokeWithProgress:(CGFloat)progress {

    float endProgress1 = 0.0;
    float alpha = 0.0;
    
    if(progress < 30){
        endProgress1 = 0.0;
        alpha = 0.0;
    }
    else if (progress >= 30 && progress <= 70) {
        endProgress1 = (progress - 30) / 40;
    }
    else if (progress > 70 && progress <= 80) {
        endProgress1 = 1.0;
        alpha = (progress - 70) / 10;
        
    }
    else if(progress > 80) {
        endProgress1 = 1.f;
        alpha = 1.f;
    }
    
    self.linelayer.strokeEnd = endProgress1;
    self.animationLayer.opacity = alpha;
}

-(void)startAniWithDragging{
    self.animating = YES;
    self.text.text = @"正在刷新";
    
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animation];
    keyframe.keyPath = @"transform";
    keyframe.duration = 1.0;
    keyframe.repeatCount = HUGE;
    keyframe.fillMode = kCAFillModeForwards;
    keyframe.removedOnCompletion = NO;
    
    NSValue *from = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)];
    NSValue *one = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(2, 0, 0)];
    NSValue *two = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-2, 0, 0)];
    
    keyframe.values = @[from, one, from, two, from];
    [self.animationLayer addAnimation:keyframe forKey:nil];

    [self performSelector:@selector(endRefresh)
               withObject:nil
               afterDelay:3.0
                  inModes:@[UITrackingRunLoopMode, NSRunLoopCommonModes]];
    
}

-(void)stratAniWithNoDragging{

    self.animating = YES;
    self.text.text = @"正在刷新";
    
    [UIView animateWithDuration:0.5 animations:^{
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = RefreshPullLen;
        self.scrollView.contentInset = inset;
    }];

    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animation];
    keyframe.keyPath = @"transform";
    keyframe.duration = 1.0;
    keyframe.repeatCount = HUGE;
    keyframe.fillMode = kCAFillModeForwards;
    keyframe.removedOnCompletion = NO;
    
    NSValue *from = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)];
    NSValue *one = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(2, 0, 0)];
    NSValue *two = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-2, 0, 0)];
    
    keyframe.values = @[from, one, from, two, from];
    [self.animationLayer addAnimation:keyframe forKey:nil];

    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:3.0];
}

#pragma mark - Stop
-(void)endRefresh {
    [self removeAni];
}

-(void)removeAni{
    _isReturn = YES;//scrollView返回
    
    [UIView animateWithDuration:0.5 animations:^{
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = 0;
        self.scrollView.contentInset = inset;
    }];
    
    self.animating = NO;
    self.text.text = @"刷新成功";
    self.linelayer.strokeEnd = 0.f;
    self.animationLayer.opacity = 0.f;
    
    [self.animationLayer removeAllAnimations];
}

@end


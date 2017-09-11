//
//  UIButtonFunc.m
//  exeRcise
//
//  Created by hemeng on 2017/9/11.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "UIButtonFunc.h"

@implementation UIButtonFunc

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        _space = 2;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self customLayoutWithSender:self withSpace:_space];
    
}

-(void)customLayoutWithSender:(UIButtonFunc *)sender withSpace:(CGFloat)space{
    UIImageView *imageView = sender.imageView;
    UILabel *titleLabel = sender.titleLabel;
    
    CGSize imageSize = imageView.frame.size;
    CGSize titleSize = titleLabel.frame.size;
    CGFloat totalHeight = imageSize.height + titleSize.height + space;
    //图片在上 文字在下
    //从左向右 本地化用的到 大部分都是这个
    if([[UIApplication sharedApplication] userInterfaceLayoutDirection] == UIUserInterfaceLayoutDirectionLeftToRight){
        sender.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);
        sender.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(totalHeight - titleSize.height), 0.0);
    }
    else{//从右向左 本地化用的到 比如阿拉伯文
        sender.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), -titleSize.width, 0.0, 0.0);
        sender.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -(totalHeight-titleSize.height), -imageSize.width);
    }
    
    sender.imageView.contentMode = UIViewContentModeCenter;
    
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
}

@end

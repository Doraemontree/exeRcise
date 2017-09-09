//
//  customAlert.m
//  exeRcise
//
//  Created by hemeng on 17/6/17.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "customAlert.h"

@implementation customAlert

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
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self createLabel];
        
        [self createActivityIndicator];
        
    }
    return self;
}

-(void)createLabel{
    message               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 35)];
    message.center        = CGPointMake(self.bounds.size.width/2, 130);
    message.textColor     = [UIColor whiteColor];
    message.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:message];

}

-(void)createActivityIndicator{
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    indicator.center = CGPointMake(125, 70);
    
    [self addSubview:indicator];
    
    [indicator startAnimating];

}

-(void)setMessage:(NSString *)str isCenter:(BOOL)flag{
    if(flag == YES)
        message.center = CGPointMake(125, 85);
    
    message.text = str;
}

-(void)ActivityIndicatorViewHidden{
    indicator.hidden = YES;
}


@end

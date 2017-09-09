//
//  MainView.m
//  exeRcise
//
//  Created by hemeng on 17/5/2.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "MainView.h"

@implementation MainView

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
        [self background];
        
        [self middle];
    }
    return self;
}

-(UIImageView *)background{
    if(!_background){
        _background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
  
        _background.image = [UIImage imageNamed:@"background2"];
        
        [self addSubview:_background];
    }
    return _background;
}

-(middleTableView *)middle{
    if(!_middle){
        _middle = [[middleTableView alloc]initWithFrame:CGRectMake(30, 25, self.bounds.size.width - 60, self.bounds.size.height - 100)];
        
        _middle.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_middle];
    }
    return _middle;
}

@end

//
//  CommoditySizeColorVIew.m
//  exeRcise
//
//  Created by hemeng on 17/7/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CommoditySizeColorVIew.h"

@implementation CommoditySizeColorVIew
- (instancetype)initWithFrame:(CGRect)frame withColorOrSize:(NSString *)cOs
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createViewWithCos:cOs];
        
        _sizeBtnTag = 0;
        _colorBtnTag = 0;
        
    }
    return self;
}
-(void)createViewWithCos:(NSString *)cOs{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 7, 60, 40)];
    label.textAlignment = NSTextAlignmentLeft;
    
    if([cOs isEqualToString:@"size"])
        label.text = @"尺码";
    else if([cOs isEqualToString:@"color"])
        label.text = @"颜色";
    
    [self addSubview:label];
    
}
-(void)refreshSizeColorBtnWithSizeAr:(NSArray *)array withcOs:(NSString *)cOs{
    
    for(int i = 0; i < array.count; i++){
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(25 + (i * 100), (i < 3 ? 42 : 82), 78.5, 35)];
        btn.layer.borderWidth = 2.f;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        
        if([cOs isEqualToString:@"size"]){
            btn.tag = i + 1;
            [btn setTitle:[[array objectAtIndex:i] objectForKey:@"size"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(SizeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if([cOs isEqualToString:@"color"]){
            btn.tag = 100 - i;
            [btn setTitle:[[array objectAtIndex:i] objectForKey:@"color"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(ColorBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
        
        [self addSubview:btn];
    }
}

-(void)SizeBtnAction:(UIButton *)btn{
    for(int i = 1; i < 3; i++){
        UIButton *btn1 = [self viewWithTag:i];
        btn1.selected = NO;
        btn1.layer.borderColor = [UIColor blackColor].CGColor;
    }
    _sizeBtnTag = (int)btn.tag;
    btn.selected = YES;
    btn.layer.borderColor = [UIColor purpleColor].CGColor;
}

-(void)ColorBtnAction:(UIButton *)btn{
    for(int i = 0; i < 3; i++){
        UIButton *btn1 = [self viewWithTag:100 - i];
        btn1.selected = NO;
        btn1.layer.borderColor = [UIColor blackColor].CGColor;
    }
    _colorBtnTag = (int)btn.tag;
    btn.selected = YES;
    btn.layer.borderColor = [UIColor purpleColor].CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

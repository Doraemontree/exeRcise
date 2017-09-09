//
//  CartCommodityView.m
//  exeRcise
//
//  Created by hemeng on 17/7/10.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CartCommodityView.h"

@implementation CartCommodityView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor blackColor] set];
    
    CGContextMoveToPoint(context, 15, 8);
    
    CGContextAddLineToPoint(context, 360, 8);
    
    CGContextSetLineWidth(context, 0.3);
    
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 15, 155);
    
    CGContextAddLineToPoint(context, 360, 155);
    
    CGContextStrokePath(context);
    
    [[UIColor grayColor] set];
    
    CGContextMoveToPoint(context, 112, 119);
    
    CGContextAddLineToPoint(context, 190, 119);
    
    CGContextAddLineToPoint(context, 190, 143);
    
    CGContextAddLineToPoint(context, 112, 143);
    
    CGContextAddLineToPoint(context, 112, 119);
    
    CGContextMoveToPoint(context, 137, 119);
    
    CGContextAddLineToPoint(context, 137, 143);
    
    CGContextMoveToPoint(context, 166, 119);
    
    CGContextAddLineToPoint(context, 166, 143);
    
    CGContextStrokePath(context);
    
}

- (instancetype)initWithFrame:(CGRect)frame
                    withImage:(UIImage *)image
                     withName:(NSString *)name
                    withPrice:(NSString *)price
                    withColor:(NSString *)color
                     withSize:(NSString *)size
                 withQuantity:(NSString *)quantity
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self CommodityImage];
        [_CommodityImage setImage:image];
        
        [self CommodityName];
        _CommodityName.text = name;
        
        [self CommoditySize];
        _CommoditySize.text = size;
        
        [self CommodityColor];
        _CommodityColor.text = color;
        
        [self price];
        _price.text = [@"¥" stringByAppendingString:price];
        
        [self deleteBtn];
        [self addBtn];
        [self subtractBtn];
        
        [self quantity];
        _quantity.text = [NSString stringWithFormat:@"%@",quantity];
    }
    return self;
}

-(UIImageView *)CommodityImage{
    if(!_CommodityImage){
        _CommodityImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 95, 120)];
        
        [self addSubview:_CommodityImage];
    }
    return _CommodityImage;
}

-(UILabel *)CommodityName{
    if(!_CommodityName){
        _CommodityName = [[UILabel alloc]initWithFrame:CGRectMake(111, 20, 190, 50)];
        _CommodityName.textAlignment = NSTextAlignmentLeft;
        _CommodityName.numberOfLines = 2;
        _CommodityName.font = [UIFont systemFontOfSize:20];
        
        [self addSubview:_CommodityName];
    }
    return _CommodityName;
}

-(UILabel *)CommoditySize{
    if(!_CommoditySize){
        _CommoditySize = [[UILabel alloc]initWithFrame:CGRectMake(111, 62, 70, 35)];
        _CommoditySize.textAlignment = NSTextAlignmentLeft;
        _CommoditySize.font = [UIFont systemFontOfSize:17];
        _CommoditySize.textColor = [UIColor grayColor];
        
        [self addSubview:_CommoditySize];
    }
    return _CommoditySize;
}
-(UILabel *)CommodityColor{
    if(!_CommodityColor){
        _CommodityColor = [[UILabel alloc]initWithFrame:CGRectMake(111, 83, 70, 35)];
        _CommodityColor.textAlignment = NSTextAlignmentLeft;
        _CommodityColor.font = [UIFont systemFontOfSize:17];
        _CommodityColor.textColor = [UIColor grayColor];
        
        [self addSubview:_CommodityColor];
    }
    return _CommodityColor;
}
-(UILabel *)price{
    if(!_price){
        _price = [[UILabel alloc]initWithFrame:CGRectMake(287, 104, 80, 35)];
        _price.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_price];
    }
    return _price;
}

-(UIButton *)deleteBtn{
    if(!_deleteBtn){
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(337, 17, 30, 30)];
        [_deleteBtn setTitle:@"✕" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_deleteBtn];
    }
    return _deleteBtn;
}

-(UIButton *)subtractBtn{
    if(!_subtractBtn){
        _subtractBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 115, 30, 30)];
        [_subtractBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_subtractBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [_subtractBtn setTitle:@"-" forState:UIControlStateNormal];
        [_subtractBtn addTarget:self action:@selector(subtractAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_subtractBtn];
    }
    return _subtractBtn;
}

-(UIButton *)addBtn{
    if(!_addBtn){
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(162, 115, 30, 30)];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_addBtn];
    }
    return _addBtn;
}

-(UILabel *)quantity{
    if(!_quantity){
        _quantity = [[UILabel alloc]initWithFrame:CGRectMake(132, 115, 40, 30)];
        _quantity.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_quantity];
    }
    return _quantity;
}

-(void)addBtnAction{
    [self.delegate didClickAddBtn:self];
}
-(void)subtractAction{
    [self.delegate didClickSubtractBtn:self];
}
-(void)deleteBtnAction{
    [self.delegate didClickDeleteBtn:self];
}
@end

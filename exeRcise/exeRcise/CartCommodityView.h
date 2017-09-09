//
//  CartCommodityView.h
//  exeRcise
//
//  Created by hemeng on 17/7/10.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CartCommodityView;

@protocol CartCommodityViewDelegate <NSObject>

-(void)didClickAddBtn:(CartCommodityView *)view;

-(void)didClickSubtractBtn:(CartCommodityView *)view;

-(void)didClickDeleteBtn:(CartCommodityView *)view;

@end

@interface CartCommodityView : UIView

@property(nonatomic,strong)UIImageView *CommodityImage;

@property(nonatomic,strong)UILabel *CommodityName;

@property(nonatomic,strong)UILabel *CommoditySize;

@property(nonatomic,strong)UILabel *CommodityColor;

@property(nonatomic,strong)UIButton *deleteBtn;

@property(nonatomic,strong)UIButton *addBtn;

@property(nonatomic,strong)UIButton *subtractBtn;

@property(nonatomic,strong)UILabel *price;

@property(nonatomic,strong)UILabel *quantity;

-(instancetype)initWithFrame:(CGRect)frame
                   withImage:(UIImage *)image
                    withName:(NSString *)name
                   withPrice:(NSString *)price
                   withColor:(NSString *)color
                    withSize:(NSString *)size
                withQuantity:(NSString *)quantity;

@property(nonatomic,strong)id <CartCommodityViewDelegate>delegate;

@end

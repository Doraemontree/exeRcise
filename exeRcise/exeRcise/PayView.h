//
//  PayView.h
//  exeRcise
//
//  Created by hemeng on 17/7/12.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayView;

@protocol PayViewDelegate <NSObject>

-(void)didClickConfirmBtn:(PayView *)payView;

-(void)didClickPayViewDeleteBtn:(PayView *)payView;

@end

@interface PayView : UIView

@property(nonatomic,strong)UIButton *confrimBtn;

@property(nonatomic,strong)UILabel *label1;

@property(nonatomic,strong)UILabel *money;

@property(nonatomic,strong)UILabel *label2;

@property(nonatomic,strong)UIButton *deleteBtn;

- (instancetype)initWithFrame:(CGRect)frame withMoney:(NSString *)money;

@property(nonatomic,strong)id<PayViewDelegate>delegate;

@end

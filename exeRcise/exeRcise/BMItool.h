//
//  BMItool.h
//  exeRcise
//
//  Created by hemeng on 17/5/13.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMItool;

@protocol BMItooldelegate <NSObject>

-(void)DidClickBMIBackBtn:(BMItool *)view;

@end

@interface BMItool : UIView

@property(nonatomic,strong)UILabel *weight;

@property(nonatomic,strong)UILabel *height;

@property(nonatomic,strong)UILabel *result;

@property(nonatomic,strong)UITextField *weightTextfield;

@property(nonatomic,strong)UITextField *heightTextfield;

@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)UIButton *okBtn;

@property(nonatomic,strong)UILabel *resultReveal;

@property(nonatomic,weak)id<BMItooldelegate>delegate;

@end

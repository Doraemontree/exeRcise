//
//  genderView.h
//  exeRcise
//
//  Created by hemeng on 17/6/12.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class genderView;

@protocol genderViewDelegate <NSObject>

-(void)DidClickConfirmBtn:(genderView *)view;
-(void)DidClickBackBtn:(genderView *)view;

@end

@interface genderView : UIView{
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    
    UILabel *cm;
    UILabel *kg;
    UILabel *height;
    UILabel *weight;
    UILabel *minmaxH;
    UILabel *minmaxW;
}

@property(nonatomic,strong)UIButton *btnOne;
@property(nonatomic,strong)UIButton *btnTwo;

@property(nonatomic,strong)UISlider *sliderOne;
@property(nonatomic,strong)UISlider *sliderTwo;

@property(nonatomic,strong)UIButton *confirm;
@property(nonatomic,strong)UIButton *back;

@property int h;
@property int w;
@property(nonatomic,strong)NSString *sex;


@property(nonatomic,weak)id<genderViewDelegate>delegate;

@end

//
//  calorieTool.h
//  exeRcise
//
//  Created by hemeng on 17/5/11.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class calorieTool;
@protocol calorieToolDelegate <NSObject>

-(void)DidClickBackButton:(calorieTool *)view;

@end


@interface calorieTool : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UILabel *weight;

@property(nonatomic,strong)UILabel *time;

@property(nonatomic,strong)UILabel *resultReveal;

@property(nonatomic)int close;

@property(nonatomic,strong)UITextField *weightTextfield;

@property(nonatomic,strong)UITextField *timeTextfield;

@property(nonatomic,strong)UILabel *type;

@property(nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,strong)NSArray *province;//存放要选择的数据 pickview里面的数据

@property(nonatomic,strong)NSString *Str;//存放选定以后的数据

@property(nonatomic,strong)UIButton *confirm;

@property(nonatomic,strong)UIButton *button;

@property(nonatomic,strong)UILabel *result;

@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)UIButton *okBtn;

@property(nonatomic,weak)id<calorieToolDelegate>delegate;

@end

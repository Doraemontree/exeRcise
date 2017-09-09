//
//  RecordView.h
//  exeRcise
//
//  Created by hemeng on 17/5/3.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;


@interface RecordView : UIView

@property(nonatomic,strong)UILabel *title;

@property(nonatomic,strong)UILabel *todayDate;

@property(nonatomic,strong)UILabel *L_distance;

@property(nonatomic,strong)AppDelegate *appDelegate;

@property(nonatomic,strong)UIButton *front;

@property(nonatomic,strong)UIButton *back;

@property(nonatomic,strong)UIButton *detail;

@property(nonatomic,strong)UILabel *exerciseType;

-(void)refreshRecordView;

@end

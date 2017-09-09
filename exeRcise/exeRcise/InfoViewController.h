//
//  InfoViewController.h
//  exeRcise
//
//  Created by hemeng on 17/6/23.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface InfoViewController : UIViewController

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)UIImageView *background;

@property(nonatomic,strong)UIButton *UserImageBtn;

@property(nonatomic,strong)UIButton *UserName;

@property(nonatomic,strong)UIButton *password;

@property(nonatomic,strong)UIButton *HeightAndWeight;

@property(nonatomic,strong)UIButton *daliyAim;

@property(nonatomic,strong)AppDelegate *appDelegate;

@property(nonatomic,strong)void (^refreshUserImage)(void);

//

@property(nonatomic,strong)UIView *line1;

@property(nonatomic,strong)UIView *line2;

@property(nonatomic,strong)UIView *line3;

@property(nonatomic,strong)UIView *line4;

@end

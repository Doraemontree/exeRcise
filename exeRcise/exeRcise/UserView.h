//
//  UserView.h
//  exeRcise
//
//  Created by hemeng on 17/5/2.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;
@class UserView;

@protocol UserViewDelegate <NSObject>

-(void)DidClickExitButton:(UserView *)view;

@end


@interface UserView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIImageView *UserImage;

@property(nonatomic,strong)UILabel *UserName;

@property(nonatomic,strong)UIImageView *background;

@property(nonatomic,strong)AppDelegate *appDelegate;

@property(nonatomic,weak)id<UserViewDelegate>delegate;

@property(nonatomic,strong)NSArray *titleOne;

@property(nonatomic,strong)NSArray *titleTwo;

@property(nonatomic,strong)UIButton *exitBtn;


-(void)refreshUserView;

-(void)setImage;

@end

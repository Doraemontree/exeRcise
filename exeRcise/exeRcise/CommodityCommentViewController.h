//
//  CommodityCommentViewController.h
//  exeRcise
//
//  Created by hemeng on 17/7/12.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CommodityCommentViewController : UIViewController

@property(nonatomic,strong)UITableView *CommodityComment;

@property(nonatomic,strong)UIButton *commentBtn;

@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;

@property(nonatomic,strong)AppDelegate *appDelegate;

- (instancetype)initWithCommodiyInfo:(NSDictionary *)info;

@end

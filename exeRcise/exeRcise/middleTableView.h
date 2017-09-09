//
//  middleTableView.h
//  exeRcise
//
//  Created by hemeng on 17/5/2.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface middleTableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *exerciseWay;

@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;



@end

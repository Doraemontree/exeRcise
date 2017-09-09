//
//  DetailRecordViewController.h
//  exeRcise
//
//  Created by hemeng on 17/5/5.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailRecordViewController : UIViewController

@property(nonatomic,strong)UIImageView *background;

@property(nonatomic,strong)UITableView *recordTableView;

@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;

@property(nonatomic,strong)NSArray *recordAr;//保存从数据库读取出来的数据

@end

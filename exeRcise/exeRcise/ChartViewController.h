//
//  ChartViewController.h
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ChartView.h"

@interface ChartViewController : UIViewController

@property(nonatomic,strong)AppDelegate *appDelegate;

@property(nonatomic,strong)ChartView *chartView;

@property(nonatomic,strong)UILabel *average;

@property(nonatomic,strong)UILabel *total;
@end

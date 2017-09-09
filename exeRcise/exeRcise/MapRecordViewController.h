//
//  MapRecordViewController.h
//  exeRcise
//
//  Created by hemeng on 17/6/27.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapRecordView.h"

@interface MapRecordViewController : UIViewController

@property(nonatomic,strong)MapRecordView *mapRecordView;

- (instancetype)initWithMapRecordNum:(int)num;

@end

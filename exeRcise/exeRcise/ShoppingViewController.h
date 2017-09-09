//
//  ShoppingViewController.h
//  exeRcise
//
//  Created by hemeng on 17/7/6.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityCell.h"

@interface ShoppingViewController : UIViewController

@property(nonatomic,strong)UICollectionView *collectionView;

- (instancetype)initWithItemStr:(NSString *)str;
@end

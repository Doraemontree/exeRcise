//
//  PurchaseViewController.h
//  exeRcise
//
//  Created by hemeng on 17/7/8.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityInfoView.h"
#import "CommoditySizeColorVIew.h"
#import "AppDelegate.h"

@interface PurchaseViewController : UIViewController

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)void (^didClickBckBtn)(void);

@property(nonatomic,strong)void (^imageCover)(UIImage *image);

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)CommodityInfoView *infoView;

@property(nonatomic,strong)CommoditySizeColorVIew *sizeView;

@property(nonatomic,strong)CommoditySizeColorVIew *colorView;

@property(nonatomic,strong)UIView *animationView;//动画用到的view

@property(nonatomic,strong)AppDelegate *appDelegate;

//
@property(nonatomic,strong)UIView *myview;//7天包退，，，，，
@property(nonatomic,strong)UIView *myview1;
@property(nonatomic,strong)UIView *myview2;//积分
@property(nonatomic,strong)UIView *myview3;//品牌view
@property(nonatomic,strong)UIView *myview4;//名字view
@property(nonatomic,strong)UIView *myview5;//划线
@property(nonatomic,strong)UIView *myview6;//划线
@property(nonatomic,strong)UIView *myview7;//店铺



@end

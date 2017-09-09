//
//  MultfunctionView.h
//  exeRcise
//
//  Created by hemeng on 17/5/4.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordView.h"
#import "ToolView.h"
#import "calorieTool.h"
#import "BMItool.h"

@interface MultfunctionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,ToolViewDelegate,calorieToolDelegate,BMItooldelegate>{
    float startContentOffset;
    float endContentOffset;
}

@property(nonatomic,strong)UIImageView *background;

@property(nonatomic,strong)UICollectionView *article;

@property(nonatomic,strong)RecordView *recordView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)ToolView *toolView;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)NSIndexPath *nextIndex;

@property(nonatomic,strong)NSIndexPath *currentIndex;

@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,strong)calorieTool *calorietool;

@property(nonatomic,strong)BMItool *bmitool;

@property(nonatomic,strong)UIImageView *blurView;//模糊view

@property(nonatomic,strong)UIButton *shoppingMall;

-(void)refreshMultfunctionView;

@end

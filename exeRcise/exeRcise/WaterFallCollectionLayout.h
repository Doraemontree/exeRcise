//
//  WaterFallCollectionLayout.h
//  exeRcise
//
//  Created by hemeng on 17/7/7.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFallCollectionLayout;

@protocol WaterFallDelegate <NSObject>
/*
 外部必须通过实现代理给定cell的高度.另外,如果外部通过实现代理给定列数、列间距、行间距、边缘距就用给定的，否则使用默认的列数、列间距、行间距、边缘距.
 */

@required

-(CGFloat)waterFlowLayout:(WaterFallCollectionLayout *)waterFallLayout heightForRowAtIndexPath:(NSInteger)index itemWidth:(CGFloat)width;

@optional
//决定cell的列数
-(NSInteger)columnCountInWaterFallLayout:(WaterFallCollectionLayout *)waterFallLayout;

//决定cell的列的距离
-(CGFloat)columnMarginInWaterFallLayout:(WaterFallCollectionLayout *)waterFallLayout;

//决定cell的行的距离
-(CGFloat)rowMarginInWaterFallLayout:(WaterFallCollectionLayout *)waterFallLayout;

//决定cell的边缘距
-(UIEdgeInsets)edgesInsetsWaterFallLayout:(WaterFallCollectionLayout *)waterFallLayout;

@end

@interface WaterFallCollectionLayout : UICollectionViewLayout

@property(nonatomic,assign)int cellCount;

@property(nonatomic,strong)NSMutableArray *colHeight;///** 存放所有列的当前高度*/
/** 布局属性数组*/
@property (nonatomic,strong) NSMutableArray *attrsArray;

@property(nonatomic,assign)id<WaterFallDelegate>delegate;

- (NSInteger)columCount;
- (CGFloat)columMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)defaultEdgeInsets;

@end

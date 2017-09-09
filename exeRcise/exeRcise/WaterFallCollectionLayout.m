//
//  WaterFallCollectionLayout.m
//  exeRcise
//
//  Created by hemeng on 17/7/7.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "WaterFallCollectionLayout.h"

@implementation WaterFallCollectionLayout

/**  列数*/
static const CGFloat columCount = 2;
/**  每一列间距*/
static const CGFloat columMargin = 5;
/**  每一行间距*/
static const CGFloat rowMargin = 5;
/**  边缘间距*/
static const UIEdgeInsets defaultEdgeInsets = {5,5,5,5};

-(NSMutableArray *)attrsArray{
    if(!_attrsArray){
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

-(NSMutableArray *)colHeight{
    if(!_colHeight){
        _colHeight = [NSMutableArray array];
    }
    return _colHeight;
}

//做一些初始化的操作，这个方法必须先调用一下父类的实现
/**  初始化*/
-(void)prepareLayout{
    
    [super prepareLayout];
    
    //如果刷新布局就会重新调用prepareLayout这个方法,所以要先把高度数组清空
    [self.colHeight removeAllObjects];
    
    _cellCount = (int)[self.collectionView numberOfItemsInSection:0];
    
    [self.attrsArray removeAllObjects];
    
    //初始化每个列的高度 高度为0
    for(int i = 0 ;i < columCount; i++){
        [self.colHeight addObject:@(self.defaultEdgeInsets.top)];
    }
    
    for(int i = 0; i < _cellCount;i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        //获取indexPath 对应cell 的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArray addObject:attrs];
    }
    
}

//返回UICollectionView的可滚动范围
-(CGSize)collectionViewContentSize{
    CGFloat MaxHeight = [self.colHeight[0] doubleValue];
    
    for(int i = 1; i < columCount; i++){
        CGFloat value = [self.colHeight[i] doubleValue];
        
        if(MaxHeight < value)
            MaxHeight = value;
    }
    return CGSizeMake(0, MaxHeight + self.defaultEdgeInsets.bottom);
}

//返回的是一个装着UICollectionViewLayoutAttributes的数组
/**
 *  决定cell 的排布
*/
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
    
}
//返回indexPath位置的UICollectionViewLayoutAttributes
/**
 *  返回indexPath 位置cell对应的布局属性
 */
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //使用for循环,找出高度最短的那一列
    //最短高度的列
    //目标列数
    NSInteger destColumn = 0;
    //取出第一列的长度
    CGFloat minColumnHeight = [self.colHeight[0] doubleValue];
    
    for(int i = 1; i < columCount; i++){
        //从第二列开始取
        CGFloat columnHeight  =[self.colHeight[i] doubleValue];
        //比较第一列与第二列
        if (minColumnHeight > columnHeight) {
            //如果第二列长度小于第一列 则目标列数destColumn设置为1
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    //得出cell在每行的width
    CGFloat w = (self.collectionView.frame.size.width - self.defaultEdgeInsets.left - self.defaultEdgeInsets.right - (self.columCount - 1) * self.columMargin) / self.columCount;
    //使用代理在外部决定cell 的高度
    CGFloat h = [self.delegate waterFlowLayout:self heightForRowAtIndexPath:indexPath.item itemWidth:w];
    
    CGFloat x = self.defaultEdgeInsets.left + destColumn * (w + self.columMargin);
    CGFloat y = minColumnHeight;
    
    //如果不是第一行 y的值增加边距
    if(y != self.defaultEdgeInsets.top){
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    //保存长度
    self.colHeight[destColumn] = @(y+h);
    
    return attrs;
}
- (NSInteger)columCount{
    if([self.delegate respondsToSelector:@selector(columnCountInWaterFallLayout:)]){
        return [self.delegate columnCountInWaterFallLayout:self];
    }
    else{
        return columCount;
    }
}
- (CGFloat)columMargin{
    if([self.delegate respondsToSelector:@selector(columnMarginInWaterFallLayout:)]){
        return [self.delegate columnMarginInWaterFallLayout:self];
    }
    else{
        return columMargin;
    }
}
- (CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFallLayout:)]) {
        return  [self.delegate rowMarginInWaterFallLayout:self];
    }
    else{
        return rowMargin;
    }
}
- (UIEdgeInsets)defaultEdgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgesInsetsWaterFallLayout:)]) {
        return  [self.delegate edgesInsetsWaterFallLayout:self];
    }
    else{
        return defaultEdgeInsets;
    }
}

@end

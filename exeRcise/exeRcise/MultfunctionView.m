//
//  MultfunctionView.m
//  exeRcise
//
//  Created by hemeng on 17/5/4.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "MultfunctionView.h"

static NSString *identifier = @"Cell";
#define maxSection 100

@implementation MultfunctionView

/*
 view 没有viewdidload 就在init
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)creatTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:6.f target:self selector:@selector(beginAnimation) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self background];
        //滑动view
        [self scrollView];
        //文章view
        [self article];
        //记录view
        [self recordView];
        //工具view
        [self toolView];
        //创建计时器
        [self creatTimer];
        //商品view
        [self shoppingMall];
        
    }
    return self;
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView                              = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.backgroundColor              = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize                  = CGSizeMake(self.bounds.size.width, self.bounds.size.height + 200);
        
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

-(UIImageView *)background{
    if(!_background){
        _background       = [[UIImageView alloc]initWithFrame:self.bounds];
        _background.image = [UIImage imageNamed:@"background2"];
        
        [self addSubview:_background];
    }
    return _background;
}

-(UIButton *)shoppingMall{
    if(!_shoppingMall){
        _shoppingMall = [[UIButton alloc]initWithFrame:CGRectMake(20, 260, 335, 200)];
        _shoppingMall.backgroundColor = [UIColor redColor];
        _shoppingMall.layer.cornerRadius = 20;
        [_shoppingMall setImage:[UIImage imageNamed:@"buy"] forState:UIControlStateNormal];
        [_shoppingMall addTarget:self action:@selector(DidClickShoppingMallBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:_shoppingMall];
    }
    return _shoppingMall;
}

-(ToolView *)toolView{
    if(!_toolView){
        _toolView = [[ToolView alloc]initWithFrame:CGRectMake(20, 650, self.bounds.size.width - 40, 100)];
        _toolView.layer.cornerRadius  = 10;
        _toolView.layer.masksToBounds = YES;
        _toolView.delegate            = self;
        
        [self.scrollView addSubview:_toolView];
    }
    return _toolView;
}
-(RecordView *)recordView{
    if(!_recordView){
        _recordView  = [[RecordView alloc]initWithFrame:CGRectMake(20, 480, self.bounds.size.width - 40, 160)];
        _recordView.backgroundColor     = [UIColor whiteColor];
        _recordView.layer.cornerRadius  = 10;
        _recordView.layer.masksToBounds = YES;
        
        [self.scrollView addSubview:_recordView];
    }
    return _recordView;
}

-(UICollectionView *)article{
    if(!_article){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize                    = CGSizeMake(self.bounds.size.width - 40, 200);
        layout.minimumLineSpacing          = 0;
        
        _article = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 40, self.bounds.size.width - 40, 200) collectionViewLayout:layout];
        _article.layer.cornerRadius             = 10;
        _article.delegate                       = self;
        _article.dataSource                     = self;
        _article.pagingEnabled                  = YES;
        _article.showsHorizontalScrollIndicator = NO;
        
        [_article registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        [self.scrollView addSubview:_article];
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.numberOfPages          = 3;
        pageControl.currentPage            = 0;
        pageControl.frame                  = CGRectMake(290, 210, 20, 20);
        pageControl.pageIndicatorTintColor = [UIColor blackColor];
        [self.scrollView addSubview:pageControl];
        
        self.pageControl = pageControl;
        
    }
    return _article;
    
}

-(void)beginAnimation{

    int x =_article.contentOffset.x;
    int y = _article.contentOffset.y;

    NSIndexPath *currentIndexPath = [self.article indexPathForItemAtPoint:CGPointMake(x ,y)];
    
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0];
    
    [self.article scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item  + 1;
    
    NSInteger nextSection = currentIndexPathReset.section;
    
    if (nextItem == 3) {
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.article scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

}
-(void)refreshMultfunctionView{
    [self.recordView refreshRecordView];
}

#pragma mark collectionview delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return maxSection;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell)
        cell = [[UICollectionViewCell alloc]init];
    
    cell.backgroundColor = [UIColor colorWithRed:indexPath.row * 100/255.0 green:indexPath.row * 90/255.0 blue:indexPath.row * 80/255.0 alpha:1];
    cell.tag             = indexPath.row;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 40, 200)];
    if(indexPath.row == 0)
        imageView.image = [UIImage imageNamed:@"cellimage-1"];
    else if(indexPath.row == 1)
        imageView.image = [UIImage imageNamed:@"cellimage-2"];
    else if(indexPath.row == 2)
        imageView.image = [UIImage imageNamed:@"cellimage-3"];
    
    cell.backgroundView = imageView;
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInteger:indexPath.item],@"item", nil];
    
    NSNotification *notification = [NSNotification notificationWithName:@"passItemToMain" object:nil userInfo:dic];
    
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{//uicollectionview delegate继承于scrollview delegate
    
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width) % 3;

    self.pageControl.currentPage = page;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self creatTimer];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    
    self.timer = nil;
}

#pragma mark toolviewdelegate
-(void)calorieCalculateToolDidClick:(ToolView *)view{
   //模糊屏幕快照
    [self createBlurEffectiveView];
    
    _calorietool = [[calorieTool alloc]initWithFrame:CGRectMake(40, 150, self.bounds.size.width - 80, 330)];
    _calorietool.backgroundColor     = [UIColor whiteColor];
    _calorietool.layer.cornerRadius  = 25;
    _calorietool.layer.masksToBounds = YES;
    _calorietool.alpha               = 0.5;
    _calorietool.delegate            = self;
    
    [self addSubview:_calorietool];
    
    self.article.userInteractionEnabled  = NO;
    self.toolView.userInteractionEnabled = NO;
    
}
-(void)BMICalculateToolDidClick:(ToolView *)view{
    [self createBlurEffectiveView];
    
    _bmitool = [[BMItool alloc]initWithFrame:CGRectMake(40, 180, self.bounds.size.width - 80, 260)];
    _bmitool.backgroundColor     = [UIColor whiteColor];
    _bmitool.layer.cornerRadius  = 25;
    _bmitool.layer.masksToBounds = YES;
    _bmitool.alpha               = 0.5;
    _bmitool.delegate            = self;
    
    [self addSubview:_bmitool];
    
    self.article.userInteractionEnabled  = NO;
    self.toolView.userInteractionEnabled = NO;
    
}
-(UIImage *)snapShot{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return image;
}
-(void)createBlurEffectiveView{
    UIImage * image = [self snapShot];
    
    self.blurView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.blurView.image = image;
    [self addSubview:self.blurView];

    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //创建模糊view
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.bounds;
    
    [self.blurView addSubview:effectView];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

-(void)DidClickBackButton:(calorieTool *)view{
    
    [_blurView removeFromSuperview];
    [_calorietool removeFromSuperview];
    
    _calorietool = nil;
    _blurView    = nil;
    
    self.article.userInteractionEnabled  = YES;
    self.toolView.userInteractionEnabled = YES;
}

-(void)DidClickBMIBackBtn:(BMItool *)view{
    [_blurView removeFromSuperview];
    [_bmitool removeFromSuperview];
    
    _bmitool  = nil;
    _blurView = nil;
    
    self.article.userInteractionEnabled  = YES;
    self.toolView.userInteractionEnabled = YES;

}
-(void)DidClickShoppingMallBtn{
    NSNotification *noti = [NSNotification notificationWithName:@"openShopViewController" object:nil];
    
    [[NSNotificationCenter defaultCenter]postNotification:noti];
    
}
//-(UIImage *)fuzzy:(UIImage *)image{
//    /*..CoreImage中的模糊效果滤镜..*/
//    //CIImage,相当于UIImage,作用为获取图片资源
//    CIImage * ciImage = [[CIImage alloc]initWithImage:image ];
//    //CIFilter,高斯模糊滤镜
//    CIFilter * blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    //将图片输入到滤镜中
//    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
//    //用来查询滤镜可以设置的参数以及一些相关的信息
//    //设置模糊程度,默认为10,取值范围(0-100)
//    [blurFilter setValue:@(1) forKey:@"inputRadius"];
//    //将处理好的图片输出
//    CIImage * outCiImage = [blurFilter valueForKey:kCIOutputImageKey];
//    //CIContext
//    CIContext * context = [CIContext contextWithOptions:nil];
//    //获取CGImage句柄,也就是从数据流中取出图片
//    CGImageRef outCGImage = [context createCGImage:outCiImage fromRect:[outCiImage extent]];
//    //最终获取到图片
//    UIImage * blurImage = [UIImage imageWithCGImage:outCGImage];
//    //释放CGImage句柄
//    CGImageRelease(outCGImage);
//
//    return blurImage;
//}
@end

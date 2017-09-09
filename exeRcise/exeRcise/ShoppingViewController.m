//
//  ShoppingViewController.m
//  exeRcise
//
//  Created by hemeng on 17/7/6.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ShoppingViewController.h"
#import "WaterFallCollectionLayout.h"
#import "ShoppingModel.h"
#import "PurchaseViewController.h"


static NSString *identifier = @"Cell";

@interface ShoppingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFallDelegate>{
    NSArray *commodityInfo;//保存商品信息
    
    NSArray *imageAr;//保存商品图片
    
    NSMutableArray *ImageHeight;//保存image随机height
    
    //商品名字
    NSString *itemStr;
}

@end

@implementation ShoppingViewController

- (instancetype)initWithItemStr:(NSString *)str
{
    self = [super init];
    if (self) {
        
        itemStr = str;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(createCollectionView) name:@"finishLoadItemInfo" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"商品";
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = back;
    
    ShoppingModel *model = [[ShoppingModel alloc]init];
    
    [model getItemNumWithItemStr:itemStr];
    
    model.returnArray = ^(NSArray *array){
        commodityInfo = [NSArray arrayWithArray:array];
        
    };
    ImageHeight = [NSMutableArray array];
    // Do any additional setup after loading the view.
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getImage{
    ShoppingModel *model = [[ShoppingModel alloc]init];
    
    [model getCoverImageWithCategory:itemStr withNumber:(int)commodityInfo.count];
    
    imageAr = [NSArray array];
    
    model.returnImageAr = ^(NSMutableArray *ar){
        imageAr = ar;
        
        [self collectionView];
    };
}
//
-(void)createCollectionView{
    [self getImage];
}

#pragma mark collectionDelegate
-(UICollectionView *)collectionView{
    if(!_collectionView){
        WaterFallCollectionLayout *layout = [[WaterFallCollectionLayout alloc]init];
        layout.delegate = self;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, 375, 617) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:238.0/255.0 blue:242.0/255.0 alpha:1];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        [_collectionView registerNib:[UINib nibWithNibName:@"ShoppingCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifier];
        
        [self.view addSubview:_collectionView];
        
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return commodityInfo.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommodityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UILabel *name = (UILabel *)[cell viewWithTag:2];

    name.text = [[commodityInfo objectAtIndex:indexPath.row] objectForKey:@"name"];
    UILabel *price = (UILabel *)[cell viewWithTag:3];
    price.text = [@"¥" stringByAppendingString:[[commodityInfo objectAtIndex:indexPath.row] objectForKey:@"price"]];
    UILabel *discount = (UILabel *)[cell viewWithTag:4];
    discount.text = [[[commodityInfo objectAtIndex:indexPath.row] objectForKey:@"discount"]stringByAppendingString:@"折"];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    imageView.image = [imageAr objectAtIndex:indexPath.row];
    imageView.frame = CGRectMake(0, 0, 180, 193 + [ImageHeight[indexPath.row] doubleValue]);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PurchaseViewController *vc = [[PurchaseViewController alloc]init];
    
    vc.imageCover([imageAr objectAtIndex:indexPath.row]);
    
    //把所点击的item的信心传过去
    NSNotification *noti = [NSNotification notificationWithName:@"passCommodityInfo" object:nil userInfo:[commodityInfo objectAtIndex:indexPath.row]];
    
    [[NSNotificationCenter defaultCenter]postNotification:noti];
    
    vc.didClickBckBtn = ^{
        self.collectionView.frame = self.view.bounds;
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark waterfallDelegate
-(CGFloat)waterFlowLayout:(WaterFallCollectionLayout *)waterFallLayout heightForRowAtIndexPath:(NSInteger)index itemWidth:(CGFloat)width{
    
    CGFloat h = arc4random() % 40;
    
    [ImageHeight addObject:@(h)];
    
    return 290 + h;
    
}
//决定cell的列数
-(NSInteger)columnCountInWaterFallLayout:(WaterFallCollectionLayout *)waterFallLayout{
    return 2;
}

//决定cell的列的距离
-(CGFloat)columnMarginInWaterFallLayout:(WaterFallCollectionLayout *)waterFallLayout{
    return 5.0;
}

//决定cell的行的距离
-(CGFloat)rowMarginInWaterFallLayout:(WaterFallCollectionLayout *)waterFallLayout{
    return 5.0;
}


@end

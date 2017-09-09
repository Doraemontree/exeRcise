//
//  ShopViewController.m
//  exeRcise
//
//  Created by hemeng on 17/7/4.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ShopViewController.h"
#import "CategoryViewController.h"
#import "shopModel.h"
#import "advertViewController.h"

static NSString *identifier = @"Cell";

@interface ShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    NSMutableArray *ImageAr;
}

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ImageAr = [NSMutableArray array];
    
    shopModel *model = [[shopModel alloc]init];
    
    [model getAdvertisementCoverImage];
    
    model.returnImagerAr = ^(NSArray *ar){
        ImageAr = [NSMutableArray arrayWithArray:ar];
        
        _advertisement.scrollEnabled = YES;
        
        [_advertisement reloadData];
    };
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationItem.title = @"运动商城";
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = back;
    //广告collectionView
    [self advertisement];
    //自定义label
    [self customlabel];
    //商品btn
    [self createCommodityButton];
    
    [self bottomImage];
    // Do any additional setup after loading the view.
}
//自定义横条
-(CustomLabel *)customlabel{
    if(!_customlabel){
        _customlabel = [[CustomLabel alloc]initWithFrame:CGRectMake(0, 250, 375, 50)];
        
        [self.view addSubview:_customlabel];
    }
    return _customlabel;
}
//商品按钮
-(void)createCommodityButton{
    _commodity1 = [[UIButton alloc]initWithFrame:CGRectMake(30, 301, 80, 50)];
    [_commodity1 setImage:[UIImage imageNamed:@"commodity_bicycle"] forState:UIControlStateNormal];
    _commodity1.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:_commodity1];
    
    _commodity2 = [[UIButton alloc]initWithFrame:CGRectMake(165, 296, 40, 55)];
    [_commodity2 setImage:[UIImage imageNamed:@"commodity_clothes"] forState:UIControlStateNormal];
    _commodity2.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:_commodity2];
    
    _commodity3 = [[UIButton alloc]initWithFrame:CGRectMake(262, 304.5, 70, 45)];
    [_commodity3 setImage:[UIImage imageNamed:@"commodity_shoes"] forState:UIControlStateNormal];
    _commodity3.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:_commodity3];
    
    _commodity4 = [[UIButton alloc]initWithFrame:CGRectMake(45, 390, 50, 50)];
    [_commodity4 setImage:[UIImage imageNamed:@"commodity_ball"] forState:UIControlStateNormal];
    _commodity4.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:_commodity4];
    
    _commodity5 = [[UIButton alloc]initWithFrame:CGRectMake(160, 395, 55, 45)];
    [_commodity5 setImage:[UIImage imageNamed:@"commodity_dumbbell"] forState:UIControlStateNormal];
    _commodity5.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:_commodity5];
    
    _commodity6 = [[UIButton alloc]initWithFrame:CGRectMake(279, 390, 52, 52)];
    [_commodity6 setImage:[UIImage imageNamed:@"commodity_accessorise"] forState:UIControlStateNormal];
    _commodity6.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:_commodity6];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(43, 343, 315, 30)];
    label.text = @"自行车                     运动服                  运动鞋";
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(53, 435, 315, 30)];
    label2.text = @"球类                     健身器材               运动配件";
    label2.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label2];
    
    [_commodity1 addTarget:self action:@selector(NaviPushAction:) forControlEvents:UIControlEventTouchUpInside];
    [_commodity2 addTarget:self action:@selector(NaviPushAction:) forControlEvents:UIControlEventTouchUpInside];
    [_commodity3 addTarget:self action:@selector(NaviPushAction:) forControlEvents:UIControlEventTouchUpInside];
    [_commodity4 addTarget:self action:@selector(NaviPushAction:) forControlEvents:UIControlEventTouchUpInside];
    [_commodity5 addTarget:self action:@selector(NaviPushAction:) forControlEvents:UIControlEventTouchUpInside];
    [_commodity6 addTarget:self action:@selector(NaviPushAction:) forControlEvents:UIControlEventTouchUpInside];
}
//传递按的是哪个按钮
-(void)NaviPushAction:(UIButton *)btn{
    
    CategoryViewController *category = [[CategoryViewController alloc]init];
    
    NSDictionary *dic;
    if(btn == _commodity1)
        dic = @{@"value":[NSNumber numberWithInt:1]};
    else if(btn == _commodity2)
        dic = @{@"value":[NSNumber numberWithInt:2]};
    else if(btn == _commodity3)
        dic = @{@"value":[NSNumber numberWithInt:3]};
    else if(btn == _commodity4)
        dic = @{@"value":[NSNumber numberWithInt:4]};
    else if(btn == _commodity5)
        dic = @{@"value":[NSNumber numberWithInt:5]};
    else if(btn == _commodity6)
        dic = @{@"value":[NSNumber numberWithInt:6]};
    
    NSNotification *noti = [NSNotification notificationWithName:@"categoryNumber" object:nil userInfo:dic];
    
    [[NSNotificationCenter defaultCenter]postNotification:noti];
    
    [self.navigationController pushViewController:category animated:YES];
}

-(void)backAction{
    self.navigationController.navigationBar.hidden = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}
//底部image
-(void)bottomImage{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 470, self.view.bounds.size.width, 197)];
    imageView.image=[UIImage imageNamed:@"ad4"];
    [self.view addSubview:imageView];
}
//广告
-(UICollectionView *)advertisement{
    if(!_advertisement){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(375, 245);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        
        _advertisement = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, 245) collectionViewLayout:layout];
        _advertisement.dataSource = self;
        _advertisement.delegate = self;
        _advertisement.pagingEnabled = YES;
        _advertisement.scrollEnabled = NO;
        _advertisement.backgroundColor = [UIColor grayColor];
        
        [_advertisement registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        [self.view addSubview:_advertisement];
    }
    return _advertisement;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ImageAr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell)
        cell = [[UICollectionViewCell alloc]init];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 245)];
    
    imageView.image = [ImageAr objectAtIndex:indexPath.row];
    
    [cell addSubview:imageView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    advertViewController *vc = [[advertViewController alloc]initWithAdvertNum:(int)indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end

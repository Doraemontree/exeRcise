//
//  PurchaseViewController.m
//  exeRcise
//
//  Created by hemeng on 17/7/8.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "PurchaseViewController.h"
#import "CommodityCommentViewController.h"
#import "PurchaseModel.h"
#import "CartViewController.h"
#import "CartModel.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

static NSString *identifier = @"Cell";

@interface PurchaseViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    
    NSDictionary *CommodityInfoDic;
    
    NSMutableArray *CommodityImage;

    //保存sizeAr与colorAr
    NSArray *colorAr;
    NSArray *sizeAr;
    
    __block UIImage *CoverImage;
    //bar
    UIView *barView;
    UIButton *barBackBtn;
    
    //shoppingCart
    UIButton *shoppingCart;
    UIButton *JoinShoppingCart;
    
    //cart数目显示
    UILabel *numlabel;
    UIView *numView;
    
    CartModel *cart;
    
    UIButton *CommentBtn;
}
@end

@implementation PurchaseViewController
-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveCommodityInfo:) name:@"passCommodityInfo" object:nil];
        
        self.imageCover = ^(UIImage *image){
            CoverImage = image;
        };
    }
    return self;
}

-(void)receiveCommodityInfo:(NSNotification *)noti{
    CommodityInfoDic = noti.userInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CommodityImage = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    cart = [CartModel shareCartModel];
    
    [self scrollView];
    
    [self createBar];
    
    [self createShoppingCartView];
    
    [self collectionView];
    
    [self infoView];
    
    [self sizeView];
    
    [self colorView];
    
    [self colorView];
    
    [self animationView];
    
    [self myview];
    
    [self myview2];
    
    [self myview3];
    
    [self myview5];
    
    [self myview6];
    
    [self myview7];
    
    [self createCommentView];
    
    PurchaseModel *model = [[PurchaseModel alloc]init];
    //获取详细介绍图片
    [model getItemDetailImageWithCategory:[CommodityInfoDic objectForKey:@"category"]
                           withItemNumber:[[CommodityInfoDic objectForKey:@"num"] intValue]];
    //获取所有size和color
    [model getCommoditySizeWithNum:[[CommodityInfoDic objectForKey:@"num"] intValue]];
    [model getCommodityColorWithNum:[[CommodityInfoDic objectForKey:@"num"] intValue]];
    
    model.returnImageArray = ^(NSMutableArray *array){
        [CommodityImage addObjectsFromArray:array];
        
        _collectionView.scrollEnabled = YES;
        [_collectionView reloadData];
    };
    
    model.returnSizeArray = ^(NSArray *ar){
        [_sizeView refreshSizeColorBtnWithSizeAr:ar withcOs:@"size"];
        
        sizeAr = [NSArray arrayWithArray:ar];
        
        if(ar.count > 3)
            _sizeView.frame = CGRectMake(0, 583, 375, 145);
    };
    model.returnColorArray = ^(NSArray *ar){
        [_colorView refreshSizeColorBtnWithSizeAr:ar withcOs:@"color"];
        
        colorAr = [NSArray arrayWithArray:ar];
        
        if(ar.count > 3)
            _colorView.frame = CGRectMake(0, 694, 375, 145);
    };
    //如果没有购物车没有任何商品 从服务器上检测 有就下载
    if(cart.CartCommodity.count == 0){
        //获取购物篮所有物品
        [model loadCartCommodityInfoInsertIntoCartModelWithId:self.appDelegate.userInfo.uid];
        
        model.successLoadInfo = ^{
            [self showNumLabelView];
        };
    }
}

#pragma mark ui
-(void)createCommentView{
    
    CommentBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 30)];
    CommentBtn.backgroundColor = [UIColor whiteColor];
    CommentBtn.layer.cornerRadius = 15;
    CommentBtn.layer.borderWidth = 0.7;
    CommentBtn.center = CGPointMake(187.5, 1080);
    CommentBtn.layer.borderColor = [UIColor purpleColor].CGColor;
    [CommentBtn setTitle:@"查看全部评论" forState:UIControlStateNormal];
    [CommentBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [CommentBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:CommentBtn];
    
}

-(CommoditySizeColorVIew *)colorView{
    if(!_colorView){
        _colorView = [[CommoditySizeColorVIew alloc]initWithFrame:CGRectMake(0, 694, 375, 105) withColorOrSize:@"color"];
        _colorView.backgroundColor = [UIColor whiteColor];
        
        [_scrollView addSubview:_colorView];
    }
    return _colorView;
}

-(CommoditySizeColorVIew *)sizeView{
    if(!_sizeView){
        _sizeView = [[CommoditySizeColorVIew alloc]initWithFrame:CGRectMake(0, 583, 375, 105) withColorOrSize:@"size"];
        _sizeView.backgroundColor = [UIColor whiteColor];
        
        [_scrollView addSubview:_sizeView];
    }
    return _sizeView;
}

-(CommodityInfoView *)infoView{
    if(!_infoView){
        _infoView = [[CommodityInfoView alloc]initWithFrame:CGRectMake(0, 390, 375, 180)
                                                 withCprice:[CommodityInfoDic objectForKey:@"price"]
                                              withCdiscount:[CommodityInfoDic objectForKey:@"discount"]
                                                  withCname:[CommodityInfoDic objectForKey:@"name"]
                                             withCintroduce:[CommodityInfoDic objectForKey:@"introduce"]];
        _infoView.backgroundColor = [UIColor whiteColor];
        
        [_scrollView addSubview:_infoView];
    }
    return _infoView;
}

-(void)createShoppingCartView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 617, 375, 50)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 0.5f;
    [self.view addSubview:view];
    
    shoppingCart = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    shoppingCart.layer.borderWidth = 0.5f;
    shoppingCart.layer.borderColor = [UIColor grayColor].CGColor;
    shoppingCart.layer.cornerRadius = 20;
    shoppingCart.center = CGPointMake(65, 25);
    [shoppingCart addTarget:self action:@selector(barBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    imageView.image = [UIImage imageNamed:@"shoppingCart"];
    imageView.center = CGPointMake(64, 25);
    [view addSubview:imageView];
    
    [view addSubview:shoppingCart];
    
    JoinShoppingCart = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    JoinShoppingCart.layer.cornerRadius = 20;
    JoinShoppingCart.backgroundColor = [UIColor purpleColor];
    JoinShoppingCart.center = CGPointMake(250, 25);
    [JoinShoppingCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    [JoinShoppingCart addTarget:self action:@selector(barBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:JoinShoppingCart];
    
    //显示购物车内商品数量的view
    numView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    numView.layer.cornerRadius = 7.5;
    numView.backgroundColor = [UIColor purpleColor];
    numView.center = CGPointMake(75, 17);
    [view addSubview:numView];
    
    numlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    numlabel.textAlignment = NSTextAlignmentCenter;
    numlabel.textColor = [UIColor whiteColor];
    numlabel.center = CGPointMake(7.5, 7.5);
    numlabel.font = [UIFont systemFontOfSize:13];
    numlabel.text = @"0";
    [numView addSubview:numlabel];
    
    //修改numlabel数目
    [self showNumLabelView];

}
-(void)showNumLabelView{
    int j = 0;
    for(int i = 0 ;i < cart.CartCommodity.count; i++){
        j += [[[cart.CartCommodity objectAtIndex:i] objectAtIndex:2] intValue];
    }
    if(j == 0)
        numView.hidden = YES;
    else{
        numView.hidden = NO;
        numlabel.text = [NSString stringWithFormat:@"%d",j];
    }
}

-(void)createBar{
    barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 60)];
    barView.backgroundColor = [UIColor whiteColor];
    barView.alpha = 0;
    [self.view addSubview:barView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 45)];
    label.text = @"商品详情";
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(187.5, 37);
    [barView addSubview:label];
    
    barBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(13, 20, 33, 33)];
    [barBackBtn setTitle:@"ㄑ" forState:UIControlStateNormal];
    [barBackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [barBackBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    barBackBtn.backgroundColor = [UIColor whiteColor];
    barBackBtn.layer.cornerRadius = 16.5;
    
    [self.view addSubview:barBackBtn];
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(375, 415);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -20, 375, 415) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollEnabled = NO;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        [_scrollView addSubview:_collectionView];
    }
    return _collectionView;
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 375, 617)];
        _scrollView.contentSize = CGSizeMake(0, 1105);
        _scrollView.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:236.0/255.0 blue:245.0/255.0 alpha:1];
        _scrollView.delegate = self;
        
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(UIView *)animationView{
    if(!_animationView){
        _animationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        _animationView.layer.cornerRadius = 7.5;
        _animationView.backgroundColor = [UIColor purpleColor];
        _animationView.center = CGPointMake(310, 634);
        
        [self.view addSubview:_animationView];
    }
    return _animationView;
}

#pragma mark btnAction
-(void)commentBtnAction{
    CommodityCommentViewController *vc = [[CommodityCommentViewController alloc]initWithCommodiyInfo:CommodityInfoDic];
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)backAction{
    self.navigationController.navigationBar.hidden = NO;
    
    self.didClickBckBtn();
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)barBtnAction:(UIButton *)btn{
    if(btn == shoppingCart){
        CartViewController *vc = [[CartViewController alloc]initWithLastVcIsPurchaseVc:YES];
        
        vc.returnCartCommodityNum = ^(int a){
            if(a == 0)
                numView.hidden = YES;
            else
                numlabel.text = [NSString stringWithFormat:@"%d",a];
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(btn == JoinShoppingCart){

        if(_sizeView.sizeBtnTag == 0 || _colorView.colorBtnTag == 0){
            NSLog(@"请选着尺码与颜色");
            //滑动到指定区域
            [_scrollView setContentOffset:CGPointMake(0, 380) animated:YES];
        }
        else{
            [self ShoppingChartAnimation];
            /*num name quantity price size color coverImage*/
            NSMutableArray *commodity = [NSMutableArray array];

            //获取购买的尺寸
            NSString *color;
            NSString *size;
            size = [[sizeAr objectAtIndex:_sizeView.sizeBtnTag - 1] objectForKey:@"size"];
            color = [[colorAr objectAtIndex:100 - _colorView.colorBtnTag] objectForKey:@"color"];
            //如是购物车数组里面保存的商品为0 则添加新的商品 数量为1

            /*如果购物车数组里面的商品不为0 检索购物车里面的商品
             若有相同商品 则商品数量加1
             若没有相同商品 则添加进cartcommodity
             */
            //目标i
            int destI = 0;
            BOOL judge = NO;//判断是否找到该商品
            for(int i = 0; i < cart.CartCommodity.count; i++){
                
                int a = [[[cart.CartCommodity objectAtIndex:i] objectAtIndex:0] intValue];
                int b = [[CommodityInfoDic objectForKey:@"num"] intValue];
                if(a == b){//有相同商品
                    NSString *s = [[cart.CartCommodity objectAtIndex:i] objectAtIndex:4];
                    NSString *c = [[cart.CartCommodity objectAtIndex:i] objectAtIndex:5];
                    if([s isEqualToString:size] && [c isEqualToString:color]){//如果尺寸和颜色都一摸一样 则表示购买相同的商品
                        judge = YES;
                        //保存商品所在的数组位置
                        destI = i;
                    }
                }
            }
            PurchaseModel *model = [[PurchaseModel alloc]init];
            NSDictionary *dic;
            
            if(judge == NO){//没有找到该商品
                //添加新商品
                [commodity addObject:[CommodityInfoDic objectForKey:@"num"]];
                [commodity addObject:[CommodityInfoDic objectForKey:@"name"]];
                [commodity addObject:@(1)];
                [commodity addObject:[CommodityInfoDic objectForKey:@"price"]];
                [commodity addObject:size];
                [commodity addObject:color];
                [commodity addObject:CoverImage];
                
                [cart.CartCommodity addObject:commodity];
                
                dic = @{@"operation":@"new",
                        @"id":self.appDelegate.userInfo.uid,
                        @"num":[CommodityInfoDic objectForKey:@"num"],
                        @"name":[CommodityInfoDic objectForKey:@"name"],
                        @"price":[CommodityInfoDic objectForKey:@"price"],
                        @"color":color,
                        @"size":size,
                        @"quantity":@(1),
                        @"category":[CommodityInfoDic objectForKey:@"category"]};
            }
            else{//找到该商品
                int originCount = [[[cart.CartCommodity objectAtIndex:destI] objectAtIndex:2] intValue];
                int newCount = originCount + 1;
                //替换数量
                [[cart.CartCommodity objectAtIndex:destI] replaceObjectAtIndex:2 withObject:@(newCount)];
                
                dic = @{@"operation":@"old",
                        @"id":self.appDelegate.userInfo.uid,
                        @"num":[CommodityInfoDic objectForKey:@"num"],
                        @"name":[CommodityInfoDic objectForKey:@"name"],
                        @"price":[CommodityInfoDic objectForKey:@"price"],
                        @"color":color,
                        @"size":size,
                        @"quantity":@(newCount),
                        @"category":[CommodityInfoDic objectForKey:@"category"]};
            }
            //向服务器提交信息
            [model insertCommodityToCart:dic];
        }
    }
}

#pragma mark CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell)
        cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, 375, 415)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 415)];
    
    if(indexPath.row == 0)
        imageView.image = CoverImage;
    else{
        //如果加载图片出现意外
        if(CommodityImage.count < 3){
            NSLog(@"dangerous");
            if(indexPath.row == 3){
                NSLog(@"its work");
                imageView.image = [CommodityImage objectAtIndex:indexPath.row - 2];
            }
        }
        else
            imageView.image = [CommodityImage objectAtIndex:indexPath.row - 1];
    }
    [cell addSubview:imageView];
    
    return cell;
}

#pragma mark scrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //如果滑动的不是collectionview
    if(scrollView != _collectionView){
        CGFloat alpha = (scrollView.contentOffset.y + 20) * 0.05;
        
        if(alpha <= 1 || alpha >= 0){
            barView.alpha = alpha;
        }
    }
}

#pragma mark animation
-(void)ShoppingChartAnimation{
    CAKeyframeAnimation *key = [CAKeyframeAnimation animation];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(192.5, 634) radius:117.5 startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(180) clockwise:NO];
    
    key.path = path.CGPath;
    key.duration = 0.5;
    key.keyPath = @"position";
    
    if(numView.hidden == YES)//如果原来numview是隐藏的 则需要显示出来
        [self performSelector:@selector(showNumViewAftherHalfSecond) withObject:nil afterDelay:0.5];
        
    [self.animationView.layer addAnimation:key forKey:nil];
    
    [self performSelector:@selector(changeNumLableAfherHalfSecond) withObject:nil afterDelay:0.5];    
}

-(void)showNumViewAftherHalfSecond{
    numView.hidden = NO;
}

-(void)changeNumLableAfherHalfSecond{
    int i = [numlabel.text intValue];
    numlabel.text = [NSString stringWithFormat:@"%d",i + 1];
}

#pragma mark hjg
-(UIView *)myview{//   七天包换
    if(!_myview){
        _myview = [[UIView alloc]initWithFrame:CGRectMake(0, 805, 375, 30)];
        _myview.backgroundColor=[UIColor whiteColor];
        
        UIButton *mybtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 375, 30)];
        [mybtn addTarget:self action:@selector(mybtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.myview addSubview:mybtn];
        
        
        UIImageView *myimageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        myimageview.image = [UIImage imageNamed:@"ok"];
        [self.myview addSubview:myimageview];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 70, 32)];
        label1.text = @"正品保证";
        [self.myview addSubview:label1];
        
        UIImageView *myimageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(145, 5, 20, 20)];
        myimageview2.image=[UIImage imageNamed:@"ok"];
        [self.myview addSubview:myimageview2];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(164, 0, 70, 32)];
        label2.text = @"极速退款";
        [self.myview addSubview:label2];
        
        UIImageView *myimageview3 = [[UIImageView alloc]initWithFrame:CGRectMake(276, 5, 20, 20)];
        myimageview3.image = [UIImage imageNamed:@"ok"];
        [self.myview addSubview:myimageview3];
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(296, 0, 70, 32)];
        label3.text = @"七天包换";
        [self.myview addSubview:label3];
        
        [self.scrollView addSubview:_myview];
    }
    return _myview;
}
-(void)mybtnAction{
    if (_myview1.hidden==YES) {
        _myview1.hidden=NO;
    }
    if(!_myview1){
        _myview1=[[UIView alloc]initWithFrame:CGRectMake(0, 200, 375, 467)];
        _myview1.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_myview1];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(165,10, 70, 50)];
        label1.text=@"基础服务";
        label1.textColor=[UIColor redColor];
        [self.myview1 addSubview:label1];
        
        UIImageView *imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(20, 50, 30, 30)];
        imageview1.image=[UIImage imageNamed:@"qi-2"];
        [self.myview1 addSubview:imageview1];
        
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(50, 50, 90, 30)];
        label2.text=@"正品保证";
        [self.myview1 addSubview:label2];
        
        UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(50,80, 370, 30)];
        label3.font=[UIFont systemFontOfSize:15];
        label3.text=@"该商品由中国人保承保正品保证险。";
        [self.myview1 addSubview:label3];
        
        UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(20, 120, 30, 30)];
        imageview2.image=[UIImage imageNamed:@"qi-1"];
        [self.myview1 addSubview:imageview2];
        
        UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(50, 120, 90, 30)];
        label4.text=@"极速退款";
        [self.myview1 addSubview:label4];
        
        UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(50,140, 310, 90)];
        label5.font=[UIFont systemFontOfSize:15];
        label5.numberOfLines=3;
        label5.text=@"极速退款是为诚信会员提供的退款退货流程的专享特权，额度是根据每个用户当前的信誉评级情况而定。";
        [self.myview1 addSubview:label5];
        
        UIImageView *imageview3=[[UIImageView alloc]initWithFrame:CGRectMake(20, 220, 30, 30)];
        imageview3.image=[UIImage imageNamed:@"qi-3"];
        [self.myview1 addSubview:imageview3];
        
        UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(50, 220, 130, 30)];
        label6.text=@"7天无理由退换";
        [self.myview1 addSubview:label6];
        
        UILabel *label7=[[UILabel alloc]initWithFrame:CGRectMake(50 , 230, 310, 90)];
        label7.font=[UIFont systemFontOfSize:15];
        label7.numberOfLines=2;
        label7.text=@"消费者在满足7天无理由退换货申请条件的前提下，可以提出“7天无理由退换货”的申请。";
        [self.myview1 addSubview:label7];
        
        UIButton *mybtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 417, 375, 50)];
        mybtn.backgroundColor=[UIColor redColor];
        [mybtn setTitle:@"完成" forState:UIControlStateNormal];
        [mybtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.myview1 addSubview:mybtn];
    }
}
-(void)btnAction{
    _myview1.hidden=YES;
}
-(UIView *)myview2{//积分
    if(!_myview2){
        _myview2=[[UIView alloc]initWithFrame:CGRectMake(0, 840, 375, 30)];
        _myview2.backgroundColor=[UIColor whiteColor];
        
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(8, 5, 30, 20)];
        imageview.image=[UIImage imageNamed:@"point"];
        [self.myview2 addSubview:imageview];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 180, 20)];
        
        NSString *string1=@"积分";
        NSString *string=[NSString stringWithFormat:@"购买可获得:%@",[CommodityInfoDic objectForKey:@"price"]];
        NSString *string3=[string stringByAppendingString:string1];
        label.text=string3;

        [self.myview2 addSubview:label];
        
        [self.scrollView addSubview:_myview2];
        
    }
    return _myview2;
}
-(UIView *)myview3{
    if(!_myview3){
        _myview3=[[UIView alloc]initWithFrame:CGRectMake(0, 875, 375, 120)];
        _myview3.backgroundColor=[UIColor whiteColor];
        [self.scrollView addSubview:_myview3];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
        label1.text=@"品牌";
        [self.myview3 addSubview:label1];
        
        UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, 200, 30)];
        label4.text=[CommodityInfoDic objectForKey:@"brand"];
        label4.textAlignment=NSTextAlignmentLeft;
        [self.myview3 addSubview:label4];
        
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10,40 , 100, 30)];
        label2.text=@"产地";
        [self.myview3 addSubview:label2];
        
        UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(80, 40, 200, 30)];
        label5.text=[CommodityInfoDic objectForKey:@"placeOfProduction"];
        NSLog(@"%@",CommodityInfoDic);
        label5.textAlignment=NSTextAlignmentLeft;
        [self.myview3 addSubview:label5];
        
        UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10,80,100, 30)];
        label3.text=@"特点";
        [self.myview3 addSubview:label3];
        
        UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(80, 80, 300, 30)];
        label6.text=[CommodityInfoDic objectForKey:@"trait"];
        label6.textAlignment=NSTextAlignmentLeft;
        [self.myview3 addSubview:label6];
    }
    return _myview3;
}
-(UIView *)myview5{
    if(!_myview5){
        _myview5=[[UIView alloc]initWithFrame:CGRectMake(15, 30, 345, 1)];
        _myview5.backgroundColor=[UIColor colorWithRed:234.0/255.0 green:236.0/255.0 blue:245.0/255.0 alpha:1];
        [self.myview3 addSubview:_myview5];
    }
    return _myview5;
}

-(UIView *)myview6{
    if(!_myview6){
        _myview6=[[UIView alloc]initWithFrame:CGRectMake(15, 80, 345, 1)];
        _myview6.backgroundColor=[UIColor colorWithRed:234.0/255.0 green:236.0/255.0 blue:245.0/255.0 alpha:1];
        [self.myview3 addSubview:_myview6];
    }
    return _myview6;
}

-(UIView *)myview7{
    if(!_myview7){
        _myview7=[[UIView alloc]initWithFrame:CGRectMake(0, 1000, 375, 60)];
        _myview7.backgroundColor=[UIColor whiteColor];
        [self.scrollView addSubview:_myview7];
        
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
        imageview.image=[UIImage imageNamed:@"Brand"];
        [self.myview7 addSubview:imageview];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(70, 15, 200, 30)];
        label.text=@"爱熙赛官方旗舰店";
        [self.myview7 addSubview:label];
        
    }
    return _myview7;
}
@end

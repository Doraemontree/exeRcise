//
//  CartViewController.m
//  exeRcise
//
//  Created by hemeng on 17/7/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CartViewController.h"
#import "CartModel.h"
#import "CartCommodityView.h"
#import "CartComoodityModel.h"

@interface CartViewController ()<CartCommodityViewDelegate,PayViewDelegate>{
    BOOL lastVcIsPurchaseVc;//判断上一个vc是不是purchasevc 是的话navi pop时需要隐藏navigationbar
    
    UIScrollView *scrollView;
    
    UIButton *accountBtn;
    UILabel *accountLabel;
    
    CartModel *cart;
    CartComoodityModel *model;

    
}

@end

@implementation CartViewController
-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (instancetype)initWithLastVcIsPurchaseVc:(BOOL)flag;
{
    self = [super init];
    if (self) {
        lastVcIsPurchaseVc = flag;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cart = [CartModel shareCartModel];
    
    model = [[CartComoodityModel alloc]init];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"购物车";

    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = back;
    
    self.navigationController.navigationBar.hidden = NO;
    
    if(cart.CartCommodity.count == 0){
        [self emptyCartView];
    }
    else{
        [self createView];
    }
}

//创造整个ui界面
-(PayView *)payView{
    if(!_payView){
        _payView = [[PayView alloc]initWithFrame:CGRectMake(0, 0, 280, 200) withMoney:accountLabel.text];
        _payView.center = CGPointMake(187.5, 333.5);
        _payView.layer.cornerRadius = 30;
        _payView.layer.masksToBounds = YES;
        _payView.delegate = self;
        
        [self.view addSubview:_payView];
    }
    return _payView;
}

-(void)createView{
    [self createScrollView];
    
    [self createCartCommodityView];
    
    [self CreateAccountView];
    
    [self calculateTotalPrice];
}

-(void)createScrollView{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 375, 597)];
    scrollView.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:236.0/255.0 blue:245.0/255.0 alpha:1];
    
    [self.view addSubview:scrollView];
}

-(void)CreateAccountView{
    UIView *accountView = [[UIView alloc]initWithFrame:CGRectMake(0, 587, 375, 80)];
    accountView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:accountView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(130, 7, 60, 25)];
    label.text = @"总金额:";
    label.textAlignment = NSTextAlignmentLeft;
    [accountView addSubview:label];
    
    accountBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 34, 345, 35)];
    accountBtn.layer.cornerRadius = 17.5;
    [accountBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [accountBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    accountBtn.backgroundColor = [UIColor purpleColor];
    [accountView addSubview:accountBtn];
    
    accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(195, 7, 100, 25)];
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.textColor = [UIColor purpleColor];
    accountLabel.text = @"¥0";
    [accountView addSubview:accountLabel];

}

-(void)createCartCommodityView{
    
    scrollView.contentSize = CGSizeMake(0, 20 + 160 * cart.CartCommodity.count);
    for(int i = 0; i < cart.CartCommodity.count ; i++){
        
        CartCommodityView *view = [[CartCommodityView alloc]initWithFrame:CGRectMake(0, 20 + (160 * i), 375, 160)
                                                                withImage:[[cart.CartCommodity objectAtIndex:i] objectAtIndex:6]
                                                                 withName:[[cart.CartCommodity objectAtIndex:i] objectAtIndex:1]
                                                                withPrice:[[cart.CartCommodity objectAtIndex:i] objectAtIndex:3]
                                                                withColor:[[cart.CartCommodity objectAtIndex:i] objectAtIndex:5]
                                                                 withSize:[[cart.CartCommodity objectAtIndex:i] objectAtIndex:4]
                                                             withQuantity:[[cart.CartCommodity objectAtIndex:i] objectAtIndex:2]];
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        view.tag = i + 1;
        [scrollView addSubview:view];
    }
}

-(void)emptyCartView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"emptyCart"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
    label.text = @"购物车是空的";
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(187.5, 393.5);
    [self.view addSubview:label];
}

-(void)payAction{
    [self createBlurEffectiveView];
    
    [self payView];
}

-(void)backAction{
    if(lastVcIsPurchaseVc == YES)
        self.navigationController.navigationBar.hidden = YES;
    
    int num = 0;
    for(int i = 0; i < cart.CartCommodity.count; i++){
        num += [[[cart.CartCommodity objectAtIndex:i] objectAtIndex:2] intValue];
    }
    self.returnCartCommodityNum(num);
    
    [self.navigationController popViewControllerAnimated:YES];
}
//计算并显示总金额
-(void)calculateTotalPrice{
    int sum = 0;
    for(int i = 0; i < cart.CartCommodity.count; i++){
        int price = [[[cart.CartCommodity objectAtIndex:i] objectAtIndex:3] intValue];
        int quantity = [[[cart.CartCommodity objectAtIndex:i] objectAtIndex:2] intValue];
        
        sum += quantity * price;
    }
    accountLabel.text = [NSString stringWithFormat:@"%d",sum];
}

#pragma mark btnActionDelegate
-(void)didClickAddBtn:(CartCommodityView *)view{
    NSInteger t = view.tag;
    /*num name quantity price size color coverImage*/
    int q = [[[cart.CartCommodity objectAtIndex:t - 1] objectAtIndex:2] intValue];
    if(q < 9){//最大购买数量为9
        [[cart.CartCommodity objectAtIndex:t - 1] replaceObjectAtIndex:2 withObject:@(q + 1)];
        
        view.quantity.text = [NSString stringWithFormat:@"%d",(q + 1)];
        
        view.subtractBtn.selected = NO;
        if(q + 1 == 9)
            view.addBtn.selected = YES;
        [self calculateTotalPrice];
        //更新服务器
        [model updateNetWorkCartCommodityInfoWithCommodityInfo:[cart.CartCommodity objectAtIndex:t -1]
                                                 withOperation:@"add"
                                                        withId:self.appDelegate.userInfo.uid];
    }
}

-(void)didClickSubtractBtn:(CartCommodityView *)view{
    NSInteger t = view.tag;
    int q = [[[cart.CartCommodity objectAtIndex:t - 1] objectAtIndex:2] intValue];
    
    if(q > 1){//最小购买数量为1
        [[cart.CartCommodity objectAtIndex:t - 1] replaceObjectAtIndex:2 withObject:@(q - 1)];
        
        view.quantity.text = [NSString stringWithFormat:@"%d",(q - 1)];
        
        view.addBtn.selected = NO;
        if(q - 1 == 1)
            view.subtractBtn.selected = YES;
        
        [self calculateTotalPrice];
        //更新服务器
        [model updateNetWorkCartCommodityInfoWithCommodityInfo:[cart.CartCommodity objectAtIndex:t -1]
                                                 withOperation:@"subtract"
                                                        withId:self.appDelegate.userInfo.uid];
    }
}

-(void)didClickDeleteBtn:(CartCommodityView *)view{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"删掉的商品可能被人抢走哦~要删除吗?" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        int tag = (int)view.tag;
        
        [self clearCartCommodityViewWithDeleteViewTag:tag];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"先留着" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)clearCartCommodityViewWithDeleteViewTag:(int)tag{
    //清除所对应view的内存
    CartCommodityView *deleteView = (CartCommodityView *)[self.view viewWithTag:tag];
    deleteView.hidden = YES;//隐藏
    deleteView.tag = 0;
    deleteView = nil;
    //后续所有的view前移
    for(int i = tag; i < cart.CartCommodity.count; i++){
        CartCommodityView *view = (CartCommodityView *)[self.view viewWithTag:i + 1];
        //依次执行动画
        [UIView animateWithDuration:0.4 animations:^{
            view.frame = CGRectMake(0, 20 + 160 * (i - 1), 375, 160);
        }];
        //改变他的tag值
        view.tag = i;
    }
    //先更新服务器 再删除本地信息
    [model updateNetWorkCartCommodityInfoWithCommodityInfo:[cart.CartCommodity objectAtIndex:tag - 1]
                                             withOperation:@"delete"
                                                    withId:self.appDelegate.userInfo.uid];
    //清除cartCommodity数组相应信息
    [cart.CartCommodity removeObjectAtIndex:tag - 1];
    
    [self calculateTotalPrice];

}
#pragma mark snapShot
-(UIImage *)snapShot{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
-(void)createBlurEffectiveView{
    UIImage * image = [self snapShot];
    
    self.blurView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.blurView.image = image;
    [self.view addSubview:self.blurView];
    
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //创建模糊view
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.view.bounds;
    
    [self.blurView addSubview:effectView];
    
}
#pragma mark payviewdelegate
-(void)didClickConfirmBtn:(PayView *)payView{

    [_blurView removeFromSuperview];
    [_payView removeFromSuperview];
    
    self.payView = nil;
    self.blurView = nil;
    //向服务器提交信息
    //清空cart commodity
    //清空服务器cart

    ///*num name quantity price size color coverImage*/
    for(int i = 0; i <cart.CartCommodity.count; i++){
        
        NSDictionary *dic = @{@"id":self.appDelegate.userInfo.uid,
                              @"name":[[cart.CartCommodity objectAtIndex:i]objectAtIndex:1],
                              @"num":[[cart.CartCommodity objectAtIndex:i]objectAtIndex:0],
                              @"quantity":[[cart.CartCommodity objectAtIndex:i]objectAtIndex:2],
                              @"price":[[cart.CartCommodity objectAtIndex:i]objectAtIndex:3]};
        
        [model uploadPurchaseCommodityWithDic:dic];
    }
    [cart clearCart];
    
    self.returnCartCommodityNum(0);
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didClickPayViewDeleteBtn:(PayView *)payView{
    [_blurView removeFromSuperview];
    [_payView removeFromSuperview];
    
    self.payView = nil;
    self.blurView = nil;
}


@end

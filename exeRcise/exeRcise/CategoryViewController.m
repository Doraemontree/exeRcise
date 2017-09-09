//
//  CategoryViewController.m
//  exeRcise
//
//  Created by hemeng on 17/7/5.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CategoryViewController.h"
#import "ShoppingViewController.h"

@interface CategoryViewController (){
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
    
    UIView *ShadowView;
    
    int number;
    
    UIScrollView *bicycleView;
    UIScrollView *clothesView;
    UIScrollView *shoesView;
    UIScrollView *ballView;
    UIScrollView *fitnessEquipmentView;
    UIScrollView *accessoriseView;
    
    //imageBtn
    UIButton *roadBicycleBtn;
    UIButton *mountainBicycleBtn;
    UIButton *smallWheelBicycleBtn;
    
    //
    UIButton *ballUniform;
    UIButton *ballWear;
    
    //
    UIButton *basketballShoes;
    UIButton *footballShoes;
    
    //
    UIButton *basketball;
    UIButton *football;
    
    //
    UIButton *dumbbell;
    
}

@end

@implementation CategoryViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(categoryNumber:) name:@"categoryNumber" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"分类";
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = back;
    
    [self createBtn];
    // Do any additional setup after loading the view.
}
//根据不同的values创建view
-(void)categoryNumber:(NSNotification *)noti{
    
    number = [noti.userInfo[@"value"] intValue];
}
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//创建竖条
-(void)createBtn{
    
    btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 60, 95, 45)];
    btn1.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    [btn1 setTitle:@"自行车" forState:UIControlStateNormal];
    
    btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 105, 95, 45)];
    btn2.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    [btn2 setTitle:@"运动服" forState:UIControlStateNormal];
    
    btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 150, 95, 45)];
    btn3.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    [btn3 setTitle:@"运动鞋" forState:UIControlStateNormal];
    
    btn4 = [[UIButton alloc]initWithFrame:CGRectMake(0, 195, 95, 45)];
    btn4.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    [btn4 setTitle:@"球类" forState:UIControlStateNormal];
    
    btn5 = [[UIButton alloc]initWithFrame:CGRectMake(0, 240, 95, 45)];
    btn5.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    [btn5 setTitle:@"健身器材" forState:UIControlStateNormal];
    
    btn6 = [[UIButton alloc]initWithFrame:CGRectMake(0, 285, 95, 45)];
    btn6.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    [btn6 setTitle:@"装备/配件" forState:UIControlStateNormal];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    [self.view addSubview:btn5];
    [self.view addSubview:btn6];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 330, 95, 337)];
    view.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    [self.view addSubview:view];
    
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn6 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    ShadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 3, 45)];
    ShadowView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:ShadowView];
    
    switch (number) {
        case 1:
            btn1.selected = YES;
            btn1.backgroundColor = [UIColor whiteColor];
            ShadowView.frame = CGRectMake(0, 60, 3, 45);
            [self createBicycleView];
            break;
        case 2:
            btn2.selected = YES;
            btn2.backgroundColor = [UIColor whiteColor];
            ShadowView.frame = CGRectMake(0, 105, 3, 45);
            [self createClothesView];
            break;
        case 3:
            btn3.selected = YES;
            btn3.backgroundColor = [UIColor whiteColor];
            ShadowView.frame = CGRectMake(0, 150, 3, 45);
            [self createShoesView];
            break;
        case 4:
            btn4.selected = YES;
            btn4.backgroundColor = [UIColor whiteColor];
            ShadowView.frame = CGRectMake(0, 195, 3, 45);
            [self createBallView];
            break;
        case 5:
            btn5.selected = YES;
            btn5.backgroundColor = [UIColor whiteColor];
            ShadowView.frame = CGRectMake(0, 240, 3, 45);
            [self createfitnessEquipmentView];
            break;
        case 6:
            btn6.selected = YES;
            btn6.backgroundColor = [UIColor whiteColor];
            ShadowView.frame = CGRectMake(0, 285, 3, 45);
            break;
            
        default:
            break;
    }
    
}
//btn按钮action
-(void)btnAction:(UIButton *)btn{
    btn1.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    btn2.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    btn3.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    btn4.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    btn5.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    btn6.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:223.0/255.0 alpha:1];
    btn1.selected = NO;
    btn2.selected = NO;
    btn3.selected = NO;
    btn4.selected = NO;
    btn5.selected = NO;
    btn6.selected = NO;
    
    btn.selected = YES;
    btn.backgroundColor = [UIColor whiteColor];
    
    if(btn == btn1){
        ShadowView.frame = CGRectMake(0, 60, 3, 45);
        [self createBicycleView];
        [self.view bringSubviewToFront:bicycleView];
    }
    else if(btn == btn2){
        ShadowView.frame = CGRectMake(0, 105, 3, 45);
        [self createClothesView];
        [self.view bringSubviewToFront:clothesView];
    }
    else if(btn == btn3){
        ShadowView.frame = CGRectMake(0, 150, 3, 45);
        [self createShoesView];
        [self.view bringSubviewToFront:shoesView];
    }
    else if(btn == btn4){
        ShadowView.frame = CGRectMake(0, 195, 3, 45);
        [self createBallView];
        [self.view bringSubviewToFront:ballView];
    }
    else if(btn == btn5){
        ShadowView.frame = CGRectMake(0, 240, 3, 45);
        [self createfitnessEquipmentView];
        [self.view bringSubviewToFront:fitnessEquipmentView];
    }
    else if(btn == btn6)
        ShadowView.frame = CGRectMake(0, 285, 3, 45);
}
-(void)createBicycleView{
    
    if(!bicycleView){
        bicycleView = [[UIScrollView alloc]initWithFrame:CGRectMake(95, 60, 280, 607)];
        bicycleView.contentSize  = CGSizeMake(0, 740);
        bicycleView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bicycleView];
        
        //
        
        mountainBicycleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        mountainBicycleBtn.center = CGPointMake(140, 110);
        [mountainBicycleBtn addTarget:self action:@selector(gotoShoppingViewController:) forControlEvents:UIControlEventTouchUpInside];
        mountainBicycleBtn.backgroundColor = [UIColor whiteColor];
        [bicycleView addSubview:mountainBicycleBtn];
        
        UIImageView *mountainBicycleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        mountainBicycleImageView.image = [UIImage imageNamed:@"MountainBikeCycling"];
        mountainBicycleImageView.center = CGPointMake(140, 110);
        mountainBicycleImageView.layer.cornerRadius = 70;
        mountainBicycleImageView.contentMode = UIViewContentModeScaleAspectFit;
        mountainBicycleImageView.layer.borderWidth = 1.f;
        mountainBicycleImageView.layer.borderColor = [UIColor purpleColor].CGColor;
        mountainBicycleImageView.userInteractionEnabled = NO;
        [bicycleView addSubview:mountainBicycleImageView];
        
        UILabel *mountainBicycleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        mountainBicycleLabel.text = @"山地自行车";
        mountainBicycleLabel.center = CGPointMake(140, 192);
        mountainBicycleLabel.textAlignment = NSTextAlignmentCenter;
        mountainBicycleLabel.font = [UIFont systemFontOfSize:15];
        [bicycleView addSubview:mountainBicycleLabel];
        
        //
        roadBicycleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        roadBicycleBtn.center = CGPointMake(140, 330);
        [roadBicycleBtn addTarget:self action:@selector(gotoShoppingViewController:) forControlEvents:UIControlEventTouchUpInside];
        roadBicycleBtn.backgroundColor = [UIColor whiteColor];
        [bicycleView addSubview:roadBicycleBtn];
        
        UIImageView *roadBicycleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        roadBicycleImageView.image = [UIImage imageNamed:@"roadBicycle"];
        roadBicycleImageView.center = CGPointMake(140, 330);
        roadBicycleImageView.layer.cornerRadius = 70;
        roadBicycleImageView.contentMode = UIViewContentModeScaleAspectFit;
        roadBicycleImageView.layer.borderWidth = 1.f;
        roadBicycleImageView.layer.borderColor = [UIColor purpleColor].CGColor;
        roadBicycleImageView.userInteractionEnabled = NO;
        [bicycleView addSubview:roadBicycleImageView];
        
        UILabel *roadBicycleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        roadBicycleLabel.text = @"公路自行车";
        roadBicycleLabel.center = CGPointMake(140, 412);
        roadBicycleLabel.textAlignment = NSTextAlignmentCenter;
        roadBicycleLabel.font = [UIFont systemFontOfSize:15];
        [bicycleView addSubview:roadBicycleLabel];
        
        //
        smallWheelBicycleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        smallWheelBicycleBtn.center = CGPointMake(140, 330 + 220);
        [smallWheelBicycleBtn addTarget:self action:@selector(gotoShoppingViewController:) forControlEvents:UIControlEventTouchUpInside];
        smallWheelBicycleBtn.backgroundColor = [UIColor whiteColor];
        [bicycleView addSubview:smallWheelBicycleBtn];
        
        UIImageView *smallWheelBicycleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        smallWheelBicycleImageView.image = [UIImage imageNamed:@"smallWheelBicycle"];
        smallWheelBicycleImageView.center = CGPointMake(140, 330 + 220);
        smallWheelBicycleImageView.layer.cornerRadius = 70;
        smallWheelBicycleImageView.contentMode = UIViewContentModeScaleAspectFit;
        smallWheelBicycleImageView.layer.borderWidth = 1.f;
        smallWheelBicycleImageView.layer.borderColor = [UIColor purpleColor].CGColor;
        smallWheelBicycleImageView.userInteractionEnabled = NO;
        [bicycleView addSubview:smallWheelBicycleImageView];
        
        UILabel *smallWheelBicycleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        smallWheelBicycleLabel.text = @"小轮自行车";
        smallWheelBicycleLabel.center = CGPointMake(140, 412 + 220);
        smallWheelBicycleLabel.textAlignment = NSTextAlignmentCenter;
        smallWheelBicycleLabel.font = [UIFont systemFontOfSize:15];
        [bicycleView addSubview:smallWheelBicycleLabel];
        
    }
    else{
        [self.view bringSubviewToFront:bicycleView];
        
    }
}
-(void)createClothesView{
    if(!clothesView){
        clothesView = [[UIScrollView alloc]initWithFrame:CGRectMake(95, 60, 280, 607)];
        clothesView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:clothesView];
        
        ballUniform = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        ballUniform.center = CGPointMake(140, 110);
        [ballUniform addTarget:self action:@selector(gotoShoppingViewController:) forControlEvents:UIControlEventTouchUpInside];
        ballUniform.backgroundColor = [UIColor whiteColor];
        [clothesView addSubview:ballUniform];
        
        UIImageView *ballUniformImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        ballUniformImageView.image = [UIImage imageNamed:@"ballUniform"];
        ballUniformImageView.center = CGPointMake(140, 110);
        ballUniformImageView.layer.cornerRadius = 70;
        ballUniformImageView.layer.masksToBounds = YES;
        ballUniformImageView.contentMode = UIViewContentModeScaleAspectFit;
        ballUniformImageView.layer.borderWidth = 1.f;
        ballUniformImageView.layer.borderColor = [UIColor purpleColor].CGColor;
        ballUniformImageView.userInteractionEnabled = NO;
        [clothesView addSubview:ballUniformImageView];
        
        UILabel *ballUniformLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        ballUniformLabel.text = @"运动服";
        ballUniformLabel.center = CGPointMake(140, 192);
        ballUniformLabel.textAlignment = NSTextAlignmentCenter;
        ballUniformLabel.font = [UIFont systemFontOfSize:15];
        [clothesView addSubview:ballUniformLabel];
        
        //
        ballWear = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        ballWear.center = CGPointMake(140, 330);
        [ballWear addTarget:self action:@selector(gotoShoppingViewController:) forControlEvents:UIControlEventTouchUpInside];
        ballWear.backgroundColor = [UIColor whiteColor];
        [clothesView addSubview:ballWear];
        
        UIImageView *ballWearImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        ballWearImageView.image = [UIImage imageNamed:@"ballWear"];
        ballWearImageView.center = CGPointMake(140, 330);
        ballWearImageView.layer.cornerRadius = 70;
        ballWearImageView.contentMode = UIViewContentModeScaleAspectFit;
        ballWearImageView.layer.borderWidth = 1.f;
        ballWearImageView.layer.borderColor = [UIColor purpleColor].CGColor;
        ballWearImageView.userInteractionEnabled = NO;
        [clothesView addSubview:ballWearImageView];
        
        UILabel *ballWearLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        ballWearLabel.text = @"球服";
        ballWearLabel.center = CGPointMake(140, 412);
        ballWearLabel.textAlignment = NSTextAlignmentCenter;
        ballWearLabel.font = [UIFont systemFontOfSize:15];
        [clothesView addSubview:ballWearLabel];
    }
}
-(void)createShoesView{
    if(!shoesView){
        shoesView = [[UIScrollView alloc]initWithFrame:CGRectMake(95, 60, 280, 607)];
        shoesView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:shoesView];
        
        basketballShoes = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        basketballShoes.center = CGPointMake(140, 110);
        [basketballShoes addTarget:self action:@selector(gotoShoppingViewController:) forControlEvents:UIControlEventTouchUpInside];
        basketballShoes.backgroundColor = [UIColor whiteColor];
        [shoesView addSubview:basketballShoes];
        
        UIImageView *basketballShoesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        basketballShoesImageView.image = [UIImage imageNamed:@"basketballShoes"];
        basketballShoesImageView.center = CGPointMake(140, 110);
        basketballShoesImageView.layer.cornerRadius = 70;
        basketballShoesImageView.layer.masksToBounds = YES;
        basketballShoesImageView.contentMode = UIViewContentModeScaleAspectFit;
        basketballShoesImageView.layer.borderWidth = 1.f;
        basketballShoesImageView.layer.borderColor = [UIColor purpleColor].CGColor;
        basketballShoesImageView.userInteractionEnabled = NO;
        [shoesView addSubview:basketballShoesImageView];
        
        UILabel *basketballShoesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        basketballShoesLabel.text = @"篮球鞋";
        basketballShoesLabel.center = CGPointMake(140, 192);
        basketballShoesLabel.textAlignment = NSTextAlignmentCenter;
        basketballShoesLabel.font = [UIFont systemFontOfSize:15];
        [shoesView addSubview:basketballShoesLabel];
        
        //
        footballShoes = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        footballShoes.center = CGPointMake(140, 330);
        [footballShoes addTarget:self action:@selector(gotoShoppingViewController:) forControlEvents:UIControlEventTouchUpInside];
        footballShoes.backgroundColor = [UIColor whiteColor];
        [shoesView addSubview:footballShoes];
        
        UIImageView *footballShoesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        footballShoesImageView.image = [UIImage imageNamed:@"footballShoes"];
        footballShoesImageView.center = CGPointMake(140, 330);
        footballShoesImageView.layer.cornerRadius = 70;
        footballShoesImageView.contentMode = UIViewContentModeScaleAspectFit;
        footballShoesImageView.layer.borderWidth = 1.f;
        footballShoesImageView.layer.borderColor = [UIColor purpleColor].CGColor;
        footballShoesImageView.userInteractionEnabled = NO;
        [shoesView addSubview:footballShoesImageView];
        
        UILabel *footballShoesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        footballShoesLabel.text = @"足球鞋";
        footballShoesLabel.center = CGPointMake(140, 412);
        footballShoesLabel.textAlignment = NSTextAlignmentCenter;
        footballShoesLabel.font = [UIFont systemFontOfSize:15];
        [shoesView addSubview:footballShoesLabel];
    }
}
-(void)createBallView{
    if(!ballView){
        ballView = [[UIScrollView alloc]initWithFrame:CGRectMake(95, 60, 280, 607)];
        ballView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:ballView];
        
        basketball = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        basketball.center = CGPointMake(140, 110);
        [basketball addTarget:self action:@selector(gotoShoppingViewController:) forControlEvents:UIControlEventTouchUpInside];
        basketball.backgroundColor = [UIColor whiteColor];
        [ballView addSubview:basketball];
        
        UIImageView *basketballImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        basketballImageView.image = [UIImage imageNamed:@"basketball"];
        basketballImageView.center = CGPointMake(140, 110);
        basketballImageView.layer.cornerRadius = 70;
        basketballImageView.layer.masksToBounds = YES;
        basketballImageView.contentMode = UIViewContentModeScaleAspectFit;
        basketballImageView.layer.borderWidth = 1.f;
        basketballImageView.layer.borderColor = [UIColor purpleColor].CGColor;
        basketballImageView.userInteractionEnabled = NO;
        [ballView addSubview:basketballImageView];
        
        UILabel *basketballLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        basketballLabel.text = @"篮球";
        basketballLabel.center = CGPointMake(140, 192);
        basketballLabel.textAlignment = NSTextAlignmentCenter;
        basketballLabel.font = [UIFont systemFontOfSize:15];
        [ballView addSubview:basketballLabel];
        
        //
        football = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        football.center = CGPointMake(140, 330);
        [football addTarget:self action:@selector(gotoShoppingViewController:) forControlEvents:UIControlEventTouchUpInside];
        football.backgroundColor = [UIColor whiteColor];
        [ballView addSubview:football];
        
        UIImageView *footballImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        footballImageView.image = [UIImage imageNamed:@"football"];
        footballImageView.center = CGPointMake(140, 330);
        footballImageView.layer.cornerRadius = 70;
        footballImageView.contentMode = UIViewContentModeScaleAspectFit;
        footballImageView.layer.borderWidth = 1.f;
        footballImageView.layer.borderColor = [UIColor purpleColor].CGColor;
        footballImageView.userInteractionEnabled = NO;
        [ballView addSubview:footballImageView];
        
        UILabel *footballLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        footballLabel.text = @"足球";
        footballLabel.center = CGPointMake(140, 412);
        footballLabel.textAlignment = NSTextAlignmentCenter;
        footballLabel.font = [UIFont systemFontOfSize:15];
        [ballView addSubview:footballLabel];
    }
}
-(void)createfitnessEquipmentView{
    if(!fitnessEquipmentView){
        fitnessEquipmentView = [[UIScrollView alloc]initWithFrame:CGRectMake(95, 60, 280, 607)];
        fitnessEquipmentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:fitnessEquipmentView];
        
        dumbbell = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        dumbbell.center = CGPointMake(140, 110);
        [dumbbell addTarget:self action:@selector(gotoShoppingViewController:) forControlEvents:UIControlEventTouchUpInside];
        dumbbell.backgroundColor = [UIColor whiteColor];
        [fitnessEquipmentView addSubview:dumbbell];
        
        UIImageView *dumbbellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        dumbbellImageView.image = [UIImage imageNamed:@"dumbbell"];
        dumbbellImageView.center = CGPointMake(140, 110);
        dumbbellImageView.layer.cornerRadius = 70;
        dumbbellImageView.layer.masksToBounds = YES;
        dumbbellImageView.contentMode = UIViewContentModeScaleAspectFit;
        dumbbellImageView.layer.borderWidth = 1.f;
        dumbbellImageView.layer.borderColor = [UIColor purpleColor].CGColor;
        dumbbellImageView.userInteractionEnabled = NO;
        [fitnessEquipmentView addSubview:dumbbellImageView];
        
        UILabel *dumbbellLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        dumbbellLabel.text = @"哑铃";
        dumbbellLabel.center = CGPointMake(140, 192);
        dumbbellLabel.textAlignment = NSTextAlignmentCenter;
        dumbbellLabel.font = [UIFont systemFontOfSize:15];
        [fitnessEquipmentView addSubview:dumbbellLabel];
        
    }
}

-(void)gotoShoppingViewController:(UIButton *)btn{
    NSString *itemStr;
    if(btn == mountainBicycleBtn)
        itemStr = @"mountainBicycle";
    else if(btn == roadBicycleBtn)
        itemStr = @"roadBicycle";
    else if(btn == smallWheelBicycleBtn)
        itemStr = @"smallWheelBicycle";
    else if(btn == ballUniform)
        itemStr = @"ballUniform";
    else if(btn == ballWear)
        itemStr = @"ballWear";
    else if(btn == basketballShoes)
        itemStr = @"basketballShoes";
    else if(btn == footballShoes)
        itemStr = @"footballShoes";
    else if(btn == basketball)
        itemStr = @"basketball";
    else if(btn == football)
        itemStr = @"football";
    else if(btn == dumbbell)
        itemStr = @"dumbbell";
    
    ShoppingViewController *vc = [[ShoppingViewController alloc]initWithItemStr:itemStr];
    
    [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

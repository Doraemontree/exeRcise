//
//  advertViewController.m
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "advertViewController.h"
#import "advertModel.h"

@interface advertViewController (){
    int imageNum;
    
    UIImage *advertImage;
    
    UIScrollView *scrollView;
    
    UIImageView *imageView;
}

@end

@implementation advertViewController

- (instancetype)initWithAdvertNum:(int)num
{
    self = [super init];
    if (self) {
        imageNum = num;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.title = @"活动信息";
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = back;
    
    advertModel *model = [[advertModel alloc]init];
    
    [model getAdvertImageWithNum:imageNum];
    
    [self createScrollView];
    
    [self createImageView];
    
    model.returnImage = ^(UIImage *image){
        advertImage = image;
        
        if(advertImage.size.height < 3500){
            imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + 1200);
            scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 1200);
        }
        else if(advertImage.size.height < 3900 && advertImage.size.height > 3500){
            imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + 1400);
            scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 1400);
        }
        else if(advertImage.size.height > 3900){
            imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + 1600);
            scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 1600);
        }
        imageView.image = advertImage;
    };
    
    // Do any additional setup after loading the view.
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createScrollView{
    scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:scrollView];
}

-(void)createImageView{
    imageView = [[UIImageView alloc]init];
    
    imageView.backgroundColor = [UIColor whiteColor];
    
    [scrollView addSubview:imageView];
}


@end

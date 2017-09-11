//
//  QRScanResultViewController.m
//  exeRcise
//
//  Created by hemeng on 2017/9/11.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "QRScanResultViewController.h"
#import "AppDelegate.h"

@interface QRScanResultViewController ()

@property(nonatomic, strong)UILabel *_title;

@property(nonatomic, strong)UIView *shareView;

@property(nonatomic, strong)UILabel *shareCode;

@property(nonatomic, strong)UIImageView *UserImage;

@end

@implementation QRScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    NSArray *array = [_AuthCode componentsSeparatedByString:@"i"];
    int code = [[array objectAtIndex:0] intValue];
    if(code > 99999 && code < 1000000 && array.count > 1){
        __title.text = [NSString stringWithFormat:@"来自%@的分享",[array objectAtIndex:1]];
        _shareCode.text = [array objectAtIndex:0];
        
        NSString *urlStr = @"http://139.199.158.105/userImage/";
        NSString *imageName = [[array objectAtIndex:1] stringByAppendingString:@".jpeg"];
        NSString *url = [urlStr stringByAppendingString:imageName];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.URLCache = nil;
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:configuration];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            UIImage *image = [UIImage imageWithData:responseObject];
            
            _UserImage.image = image;
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];
        
   
        
        
        //[_UserImage setImageWithURL:[NSURL URLWithString:[urlStr stringByAppendingString:imageName]]];
    }
    else{
        __title.text = @"未能识别出分享码";
    }
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _AuthCode = @"";
    }
    return self;
}

-(void)initUI{
    _shareView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 370)];
    _shareView.center = self.view.center;
    _shareView.layer.cornerRadius = 15;
    _shareView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_shareView];
    
    __title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 40)];
    __title.center = CGPointMake(150, 65);
    __title.textColor = [UIColor purpleColor];
    __title.font = [UIFont systemFontOfSize:20];
    __title.textAlignment = NSTextAlignmentCenter;
    [_shareView addSubview:__title];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [cancelBtn setImage:[UIImage imageNamed:@"qrcode_button_image_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.center = CGPointMake(280, 20);
    [_shareView addSubview:cancelBtn];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"分享码";
    label.center = CGPointMake(150, 305);
    label.textColor = [UIColor purpleColor];
    label.textAlignment = NSTextAlignmentCenter;
    [_shareView addSubview:label];
    
    _shareCode = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    _shareCode.text = @"";
    _shareCode.textAlignment = NSTextAlignmentCenter;
    _shareCode.textColor = [UIColor purpleColor];
    _shareCode.font = [UIFont systemFontOfSize:23];
    _shareCode.center = CGPointMake(150, 330);
    [_shareView addSubview:_shareCode];
    
    _UserImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    _UserImage.backgroundColor = [UIColor whiteColor];
    _UserImage.layer.cornerRadius = 60;
    _UserImage.layer.masksToBounds = YES;
    _UserImage.center = CGPointMake(150, 185);
    [_shareView addSubview:_UserImage];
}

-(void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

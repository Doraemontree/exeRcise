//
//  QRCodeViewController.m
//  exeRcise
//
//  Created by hemeng on 2017/9/8.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "QRCodeViewController.h"
#import "AppDelegate.h"
#import <LBXScanNative.h>

@interface QRCodeViewController ()

@property(nonatomic,strong)AppDelegate *appDelegate;

@property(nonatomic,strong)UIImageView *qrCodeImageView;

@property(nonatomic,strong)UIImage *qrImage;

@property(nonatomic,strong)UILabel *share;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)UIButton *refreshBtn;

@property int shareNum;

@property int countDown;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的二维码";

    self.navigationController.navigationBar.hidden = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = back;
    
    _countDown = 30;
    
    [self randomShareNum];
    
    [self initUIView];
    
    [self createQRImage];
}

-(void)initUIView {

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
    label.center = CGPointMake(self.view.bounds.size.width / 2, 90);
    label.text = @"分享码";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    _share = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    _share.center = CGPointMake(self.view.bounds.size.width / 2, 115);
    _share.text = [NSString stringWithFormat:@"%.6d", _shareNum];
    _share.textAlignment = NSTextAlignmentCenter;
    _share.textColor = [UIColor purpleColor];
    _share.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:_share];
    
    UILabel *qrCode = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 60)];
    qrCode.text = @"二维码";
    qrCode.textAlignment = NSTextAlignmentCenter;
    qrCode.center = CGPointMake(self.view.bounds.size.width / 2, 210);
    [self.view addSubview:qrCode];
    
    _qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 250)];
    _qrCodeImageView.center = CGPointMake(self.view.bounds.size.width / 2, 360);
    _qrCodeImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_qrCodeImageView];
    
    UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 60)];
    tip.text = @"请打开exeRciseAPP,扫面二维码!";
    tip.textColor = [UIColor grayColor];
    tip.font = [UIFont systemFontOfSize:15];
    tip.center = CGPointMake(self.view.bounds.size.width / 2, 640);
    tip.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tip];
    
    _refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    _refreshBtn.center = CGPointMake(self.view.bounds.size.width / 2, 560);
    _refreshBtn.layer.cornerRadius = 35;
    _refreshBtn.layer.borderWidth = 2;
    _refreshBtn.layer.borderColor = [UIColor purpleColor].CGColor;
    [_refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [_refreshBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [_refreshBtn addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshBtn];
}

-(void)createQRImage{
    _qrImage = [LBXScanNative createQRWithString:[NSString stringWithFormat:@"%di%@", _shareNum, self.appDelegate.userInfo.uid] QRSize:_qrCodeImageView.bounds.size];
    _qrCodeImageView.image = [self addImageOnQRImage];
}

-(void)refreshAction{
    _refreshBtn.layer.borderColor = [UIColor grayColor].CGColor;
    _refreshBtn.userInteractionEnabled = NO;
    _countDown = 30;
    
    [self randomShareNum];
    [self createQRImage];
    _share.text = [NSString stringWithFormat:@"%d", _shareNum];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [_timer fire];
}

-(void)randomShareNum{
    do {
        _shareNum = (arc4random() % 1000000);
    }
    while(_shareNum < 99999);
}

-(void)timerAction{
    if(_countDown == 0){
        _refreshBtn.userInteractionEnabled = YES;
        [_timer invalidate];
        _timer = nil;
        _refreshBtn.layer.borderColor = [UIColor purpleColor].CGColor;
        [_refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
        [_refreshBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    }
    else{
        _refreshBtn.layer.borderColor = [UIColor grayColor].CGColor;
        [_refreshBtn setTitle:[NSString stringWithFormat:@"%d", _countDown] forState:UIControlStateNormal];
        [_refreshBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _countDown--;
    }
}

-(void)backAction{
    self.navigationController.navigationBar.hidden = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

-(AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(UIImage *)addImageOnQRImage {
    UIGraphicsBeginImageContext(_qrImage.size);
    [_qrImage drawInRect:CGRectMake(0, 0, _qrImage.size.width, _qrImage.size.height)];
    NSString *imageName = [self.appDelegate.userInfo.uid stringByAppendingString:@".jpeg"];
    NSString *fullpath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:fullpath];
    
    CGFloat centerW = 57.7;
    CGFloat centerH = 57.7;
    CGFloat centerY = (_qrImage.size.width - 57.7) / 2;
    CGFloat centerX = (_qrImage.size.height - 57.7) / 2;
    
    [image drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end

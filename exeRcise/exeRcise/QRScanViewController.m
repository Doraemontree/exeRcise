//
//  QRScanViewController.m
//  exeRcise
//
//  Created by hemeng on 2017/9/9.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "QRScanViewController.h"
#import <LBXScan/LBXScanNative.h>
#import <LBXScanView.h>
#import "UIButtonFunc.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "UIViewController+ControllerExtension.h"
#import "QRScanResultViewController.h"


@interface QRScanViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, strong)LBXScanView *scanView;

@property(nonatomic, strong)LBXScanViewStyle *style;

@property(nonatomic, strong)UILabel *textTitle;//中部的标签标题

@property(nonatomic, strong)UIView *bottomViews;//底部其他按钮父视图

@property(nonatomic, strong)UIButton *buttonPhoto;//我的相册按钮

@property(nonatomic, strong)UIButton *buttonHandle;//手动识别按钮

@property(nonatomic, strong)LBXScanNative *scanObject;//扫描封装对象

@property(nonatomic, assign)BOOL isOpenInterestRect;//启动区域识别功能

@property(nonatomic, assign)BOOL isNeesScanImage;//是否需要扫码图像

@end

@implementation QRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self setDefinesPresentationContext:YES];
    
    [self initQRScan];
    
    //加个背景色 一开始不要用透明的  透明颜色需要系统渲染占用资源 造成卡顿
    self.view.backgroundColor = [UIColor blackColor];
    
    _isOpenInterestRect = YES;
    
    _isNeesScanImage = YES;
    
    [self addQRScanView];
    
    self.navigationItem.title = @"扫一扫";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = back;
    
    [self addTitleLabel];
    
    [self addBottomViews];
    
    [self performSelector:@selector(startScanQrCode) withObject:nil afterDelay:0.5];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

//初始化scanview的style
-(void)initQRScan{
    
    if(_style == nil){
        _style = [[LBXScanViewStyle alloc]init];
    }
    
    _style.centerUpOffset = 44;
    _style.xScanRetangleOffset = 50;
    _style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    _style.photoframeLineW = 3;
    _style.photoframeAngleH = 18;
    _style.photoframeAngleW = 18;
    _style.isNeedShowRetangle = NO;
    _style.animationImage = LBXScanViewAnimationStyle_LineMove;
    
    UIImage *imageLine = [UIImage imageNamed:@"qrcode_scan_light_bule"];
    _style.animationImage = imageLine;
}

//添加扫描框view
-(void)addQRScanView{
    if(_scanView == nil){
        _scanView = [[LBXScanView alloc]initWithFrame:self.view.frame style: _style];
        [self.view addSubview:_scanView];
    }
    [_scanView startDeviceReadyingWithText:@"相机启动中"];
}

//添加提示title
-(void)addTitleLabel{
    _textTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    _textTitle.textColor = [UIColor whiteColor];
    _textTitle.font = [UIFont systemFontOfSize:15];
    _textTitle.text = @"请将相机对准二维码";
    _textTitle.textAlignment = NSTextAlignmentCenter;
    _textTitle.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 2.7 / 4);
    [self.view addSubview:_textTitle];
}

//添加底部views
-(void)addBottomViews{
    if(_bottomViews == nil){
        _bottomViews = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) - 125, self.view.bounds.size.width, 100)];
        _bottomViews.backgroundColor = [UIColor clearColor];
    }
    [self.view addSubview:_bottomViews];
    
    UIImage *image1 = [UIImage imageNamed:@"qr_handle_button_image"];
    _buttonHandle = [[UIButtonFunc alloc]initWithFrame:CGRectMake(0, 0, image1.size.width, image1.size.height + 30)];
    _buttonHandle.center = CGPointMake(CGRectGetWidth(_bottomViews.frame) / 4, CGRectGetHeight(_bottomViews.frame) / 2);
    _buttonHandle.titleLabel.font = [UIFont systemFontOfSize:10];
    [_buttonHandle setImage:image1 forState:UIControlStateNormal];
    [_buttonHandle setTitle:@"手动输入" forState:UIControlStateNormal];
    [_buttonHandle addTarget:self action:@selector(modeHandleEnterQrCondeVC:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomViews addSubview:_buttonHandle];
    
    UIImage *image2 = [UIImage imageNamed:@"qr_photo_button_image"];
    _buttonPhoto = [[UIButtonFunc alloc]initWithFrame:CGRectMake(0, 0, image2.size.width, image2.size.height + 30)];
    _buttonPhoto.center = CGPointMake(CGRectGetWidth(_bottomViews.frame) * 3 / 4, CGRectGetHeight(_bottomViews.frame) / 2);
    _buttonPhoto.titleLabel.font = [UIFont systemFontOfSize:10];
    [_buttonPhoto setImage:image2 forState:UIControlStateNormal];
    [_buttonPhoto setTitle:@"相机选取" forState:UIControlStateNormal];
    [_buttonPhoto addTarget:self action:@selector(openLocalPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomViews addSubview:_buttonPhoto];
}

//开始扫描
-(void)startScanQrCode{
    self.view.backgroundColor = [UIColor clearColor];
    
    if(![self isGetCameraPermission]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机不允许访问" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
    }
    else{
        [_scanView stopDeviceReadying];//停止显示相机启动中
        [_scanView startScanAnimation];//开始扫描动画
        
        UIView *videoView = [[UIView alloc]initWithFrame:self.view.frame];
        videoView.backgroundColor = [UIColor clearColor];
        [self.view insertSubview:videoView atIndex:0];
        
        if(_scanObject == nil){
            CGRect cropRect = CGRectZero;
            if(_isOpenInterestRect){
                cropRect = [LBXScanView getScanRectWithPreView:self.view style:_style];
            }
            //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
            NSArray *arrayCodeType = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeCode128Code];
            _scanObject = [[LBXScanNative alloc]initWithPreView:videoView ObjectType:arrayCodeType cropRect:cropRect success:^(NSArray<LBXScanResult *> *array) {
                
                [self.scanView stopScanAnimation];
                [self handleScanResultWithResult:array];
                
            }];
            [_scanObject setNeedCaptureImage:_isNeesScanImage];
        }
        [_scanObject startScan];
    }
}

//处理扫描结果
-(void)handleScanResultWithResult:(NSArray<LBXScanResult *> *)result{
    if(result.count < 1){
        [self handleResultErrorWithError:nil];
        return;
    }
    
    LBXScanResult *scanResult = [result objectAtIndex:0];
    if(scanResult.strScanned == nil){
        [self handleResultErrorWithError:nil];
        return;
    }
    [self modeHandleSuccessedVC:scanResult.strScanned];
}

//处理错误
-(void)handleResultErrorWithError:(NSString *)strResult{
    if(strResult == nil){
        [self showMessage:@"识别失败" :2.0];
        [self RestartDevic];
    }
}

-(void)modeHandleSuccessedVC:(NSString *)authCode{

    QRScanResultViewController *result = [[QRScanResultViewController alloc]init];
    result.AuthCode = authCode;
    result.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
    
    [self presentViewController:result animated:YES completion:nil];
}

//继续扫码
-(void)RestartDevic{
    [_scanView startScanAnimation];
    
    if(_scanObject != nil){
        [_scanObject stopScan];
        [_scanObject startScan];
    }
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)isGetCameraPermission{
    if([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] != AVAuthorizationStatusDenied){
        return YES;
    }
    
    return NO;
}

-(BOOL)isGetPhotoPermission{
    if([[[UIDevice currentDevice] systemVersion]floatValue] < 8.0){
        //        if([ALAssetsLibrary authorizationStatus] != ALAuthorizationStatusDenied){ 8.0以下才用实际可以删除
        //            return YES;
        //        }
    }
    else{
        if([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusDenied){
            return YES;
        }
    }
    return NO;
}

-(void)modeHandleEnterQrCondeVC:(UIButton *)sender{
    
    
}

//打开相册
-(void)openLocalPhoto:(UIButton *)sender{
    if(![self isGetPhotoPermission]){
        [self showMessage:@"没有打开相册权限" :1.5];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.navigationBar.barStyle = UIBarStyleDefault;
    picker.navigationBar.tintColor = [UIColor blackColor];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if(image == nil){
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    [LBXScanNative recognizeImage:image success:^(NSArray<LBXScanResult *> *array) {
        [self handleScanResultWithResult:array];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end

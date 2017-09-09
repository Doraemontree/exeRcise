//
//  InfoViewController.m
//  exeRcise
//
//  Created by hemeng on 17/6/23.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "InfoViewController.h"
#import "alterInfoViewController.h"
#import <UIKit+AFNetworking.h>
#import "infoModel.h"

NSString *Cell = @"identifier";

@interface InfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    UIImage *savedImage;
    UIImageView *imageView;//用户头像
}

@end

@implementation InfoViewController
-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationItem.title = @"个人信息";
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    backBtn.tintColor = [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = backBtn;
    
    [self UserImageBtn];
    
    [self password];
    
    [self HeightAndWeight];
    
    [self daliyAim];
    
    [self UserName];
    
    [self line1];
    
    [self line2];
    
    [self line3];
    
    [self line4];
    
    // Do any additional setup after loading the view.
}
-(UIButton *)UserImageBtn{
    
    if(!_UserImageBtn){
        _UserImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 100, 330, 100)];
        [_UserImageBtn setTitle:@"头像" forState:UIControlStateNormal];
        _UserImageBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [_UserImageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _UserImageBtn.layer.masksToBounds = YES;

        [_UserImageBtn addTarget:self action:@selector(UserImageBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(220, 83, 100, 100)];
        imageView.layer.cornerRadius = 50;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = NO;
        
        NSString *str = [self.appDelegate.userInfo.uid stringByAppendingString:@".jpeg"];
        imageView.image = [self setImageWithName:str];
        
        [self.view addSubview:_UserImageBtn];
        [self.view addSubview:imageView];

    }
    return _UserImageBtn;
}

-(UIButton *)password{
    if(!_password){
        _password = [[UIButton alloc]initWithFrame:CGRectMake(30, 200, 330, 100)];
        [_password setTitle:@"密码" forState:UIControlStateNormal];
        _password.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [_password setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_password addTarget:self action:@selector(PDUHButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(230, 235, 20, 30)];
        imageview1.image=[UIImage imageNamed:@"lock"];
        
        [self.view addSubview:imageview1];
        [self.view addSubview:_password];
    }
    return _password;
}

-(UIButton *)HeightAndWeight{
    if(!_HeightAndWeight){
        _HeightAndWeight = [[UIButton alloc]initWithFrame:CGRectMake(30, 400, 330, 100)];
        
        [_HeightAndWeight setTitle:@"身高体重" forState:UIControlStateNormal];
        _HeightAndWeight.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [_HeightAndWeight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_HeightAndWeight addTarget:self action:@selector(PDUHButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(230, 435, 100, 30)];
        NSString *string3=@"cm";
        NSString *string=[NSString stringWithFormat:@"%d%@", self.appDelegate.userInfo.height,string3];
        label.text=string;
        [self.view addSubview:label];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(230, 465, 100, 30)];
        NSString *sting4=@"kg";
        NSString *string2= [NSString stringWithFormat:@"%d%@",self.appDelegate.userInfo.weight,sting4];
        label1.text=string2;
        [self.view addSubview:label1];
        
        [self.view addSubview:_HeightAndWeight];
    }
    return _HeightAndWeight;
}

-(UIButton *)UserName{
    if(!_UserName){

        _UserName = [[UIButton alloc]initWithFrame:CGRectMake(30, 300, 330, 100)];
        
        [_UserName setTitle:@"用户名" forState:UIControlStateNormal];
        _UserName.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [_UserName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_UserName addTarget:self action:@selector(PDUHButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(230, 335, 100, 30)];
        label.text=self.appDelegate.userInfo.name;
        [self.view addSubview:label];
        
        [self.view addSubview:_UserName];
    }
    return _UserName;
}

-(UIButton *)daliyAim{
    
    if(!_daliyAim){
        _daliyAim = [[UIButton alloc]initWithFrame:CGRectMake(30, 500, 330, 100)];
        
        [_daliyAim setTitle:@"每日目标" forState:UIControlStateNormal];
        _daliyAim.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [_daliyAim setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_daliyAim addTarget:self action:@selector(PDUHButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(230, 535, 100, 30)];
        NSString *string5=@"大卡";
        NSString *string1=[NSString stringWithFormat:@"%.0f%@", self.appDelegate.userInfo.aimC,string5];
        label.text=string1;
        [self.view addSubview:label];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(230, 565, 100, 30)];
        
        NSString *string7=@"公里";
        NSString*string2=[NSString stringWithFormat:@"%.2f%@",self.appDelegate.userInfo.aimD,string7];
        label1.text=string2;
        
        [self.view addSubview:label1];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(230, 595, 100, 30)];
        NSString *string6=@"分";
        NSString *string3=[NSString stringWithFormat:@"%.0f%@",self.appDelegate.userInfo.aimT,string6];
        
        label2.text=string3;
        [self.view addSubview:label2];
        [self.view addSubview:_daliyAim];

    }
    return _daliyAim;
}

-(void)PDUHButtonAction:(UIButton *)btn{
    alterInfoViewController *alter = [[alterInfoViewController alloc]init];
    
    NSDictionary *dic;
    
    if(btn == _password){
        dic = @{@"value":@"密码"};
    }
    else if(btn == _HeightAndWeight){
        dic = @{@"value":@"身高体重"};
    }
    else if(btn == _daliyAim){
        dic = @{@"value":@"每日目标"};
    }
    else if(btn == _UserName){
        dic = @{@"value":@"用户名"};
    }

    NSNotification *notification = [NSNotification notificationWithName:@"openAlterInfoVC" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    
    [self.navigationController pushViewController:alter animated:YES];
}

-(void)UserImageBtnAction{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:album];
    [alert addAction:camera];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    NSString *str = [self.appDelegate.userInfo.uid stringByAppendingString:@".jpeg"];//通过用户名拼接.jpeg生成的str来保存不同用户的不同头像
    //保存到本地documents 并且上传网络
    [self saveImage:image withName:str];

    imageView.image = [self setImageWithName:str];
    
}
-(void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{//将头像保存进沙盒中并使用唯一名字
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage,0.5);//转化成jpegData

    NSString *fullpath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:imageName];
    
    [imageData writeToFile:fullpath atomically:NO];
    
    infoModel *model = [[infoModel alloc]init];
    
    if([model updateUserImageOnNetWorkWith:imageData])
        NSLog(@"上传成功");
    else
        NSLog(@"上传失败");
}
-(UIImage *)setImageWithName:(NSString *)str{
    
    UIImage *image;
    NSString *fullpath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:str];
    image = [[UIImage alloc]initWithContentsOfFile:fullpath];
    if(image)
        return image;
    else
        return [UIImage imageNamed:@"user"];
}

-(void)backAction{
    self.navigationController.navigationBar.hidden = YES;
    
    self.refreshUserImage();
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark line
-(UIView *)line1{   //划线1-4
    if(!_line1){
        _line1=[[UIView alloc]initWithFrame:CGRectMake(30, 200, 300, 1)];
        _line1.backgroundColor=[UIColor grayColor];
        [self.view addSubview:_line1];
    }
    return _line1;
}
-(UIView *)line2{
    if(!_line2){
        _line2=[[UIView alloc]initWithFrame:CGRectMake(30, 300, 300, 1)];
        _line2.backgroundColor=[UIColor grayColor];
        [self.view addSubview:_line2];
    }
    return _line1;
}
-(UIView *)line3{
    if(!_line3){
        _line3=[[UIView alloc]initWithFrame:CGRectMake(30, 400, 300, 1)];
        _line3.backgroundColor=[UIColor grayColor];
        [self.view addSubview:_line3];
    }
    return _line1;
}
-(UIView *)line4{
    if(!_line4){
        _line4=[[UIView alloc]initWithFrame:CGRectMake(30, 500, 300, 1)];
        _line4.backgroundColor=[UIColor grayColor];
        [self.view addSubview:_line4];
    }
    return _line1;
}

@end

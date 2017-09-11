//
//  UserView.m
//  exeRcise
//
//  Created by hemeng on 17/5/2.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "UserView.h"
#import "AppDelegate.h"
#import "ViewControllerModel.h"


static NSString *identifier = @"Cell";

@implementation UserView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self background];
        
        [self UserImage];
        
        [self UserName];
        
        _titleOne = [[NSArray alloc]initWithObjects:@"运动生涯",@"数据分析",@"修改个人信息",@"我的二维码",@"扫一扫", nil];
        _titleTwo = [[NSArray alloc]initWithObjects:@"设置", nil];
        
        [self tableView];
        
        [self exitBtn];
    }
    return self;
}

-(UIImageView *)UserImage{
    if(!_UserImage){
        _UserImage                     = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _UserImage.center              = CGPointMake(self.bounds.size.width/2, 100);
        _UserImage.layer.cornerRadius  = 50;
        _UserImage.layer.masksToBounds = YES;
        _UserImage.backgroundColor     = [UIColor whiteColor];
        [self setImage];
        
        [self addSubview:_UserImage];
    }
    return _UserImage;
}

-(UIImageView *)background{
    if(!_background){
        _background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        
        _background.image = [UIImage imageNamed:@"background2"];
        
        [self addSubview:_background];
    }
    return _background;
}

-(UILabel *)UserName{
    if(!_UserName){
        _UserName               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _UserName.center        = CGPointMake(self.bounds.size.width/2, 180);
        _UserName.textAlignment = NSTextAlignmentCenter;
        _UserName.text          = self.appDelegate.userInfo.name;
        _UserName.font          = [UIFont systemFontOfSize:25];
        
        [self addSubview:_UserName];
    }
    return _UserName;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 180, self.bounds.size.width, self.bounds.size.height - 280) style:UITableViewStyleGrouped];
        
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.scrollEnabled   = NO;
        
        [self addSubview:_tableView];
    }
    return _tableView;
}

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0)
        return [_titleOne count];
    
    return [_titleTwo count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;//右侧箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.section == 0)
        cell.textLabel.text = [_titleOne objectAtIndex:indexPath.row];
    else
        cell.textLabel.text = [_titleTwo objectAtIndex:indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            NSNotification *notification = [[NSNotification alloc]initWithName:@"openAnaylseController" object:nil userInfo:nil];
            
            [[NSNotificationCenter defaultCenter]postNotification:notification];
        }
        else if(indexPath.row == 1){
            NSNotification *notification = [[NSNotification alloc]initWithName:@"openChartController" object:nil userInfo:nil];
            
            [[NSNotificationCenter defaultCenter]postNotification:notification];
        }
        else if(indexPath.row == 2){
            NSNotification *notification = [[NSNotification alloc]initWithName:@"openInfoController" object:nil userInfo:nil];
            
            [[NSNotificationCenter defaultCenter]postNotification:notification];
        }
        else if(indexPath.row == 3){
            NSNotification *notification = [[NSNotification alloc]initWithName:@"openQRCodeController" object:nil userInfo:nil];
            
            [[NSNotificationCenter defaultCenter]postNotification:notification];
        }
        else if(indexPath.row == 4){
            NSNotification *notification = [[NSNotification alloc]initWithName:@"openQRScanViewController" object:nil userInfo:nil];
            
            [[NSNotificationCenter defaultCenter]postNotification:notification];
        }
    }
    else if(indexPath.section == 1){
        if(indexPath.row == 0){
            
        }
    }
}

-(UIButton *)exitBtn{
    if(!_exitBtn){
        _exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, self.bounds.size.height - 140, self.bounds.size.width - 60, 40)];
        _exitBtn.layer.cornerRadius = 10;
        _exitBtn.backgroundColor    = [UIColor redColor];
        
        [_exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_exitBtn];
    }
    return _exitBtn;
}

-(void)exitBtnAction{
    [self.delegate DidClickExitButton:self];
    
}

-(void)setImage{
    NSString *imageStr = [self.appDelegate.userInfo.uid stringByAppendingString:@".jpeg"];
    
    NSString *fullpath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageStr];
    
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:fullpath];
    
    if(image)
        self.UserImage.image = image;
    else
        self.UserImage.image = [UIImage imageNamed:@"user"];
}

-(void)refreshUserView{
    self.UserName.text = self.appDelegate.userInfo.name;
    
    //ViewControllerModel *model = [[ViewControllerModel alloc]init];
    //[model loadUserImageWithUid:self.appDelegate.userInfo.uid withUIImageView:_UserImage];
}
@end

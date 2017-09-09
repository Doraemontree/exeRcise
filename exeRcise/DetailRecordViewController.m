//
//  DetailRecordViewController.m
//  exeRcise
//
//  Created by hemeng on 17/5/5.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "DetailRecordViewController.h"
#import "AppDelegate.h"
#import "MapRecordViewController.h"
#import "recordModel.h"


static NSString *identifier = @"Cell";

@interface DetailRecordViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    recordModel *model;
    
    BOOL isEqual;
}

@property(nonatomic,strong)AppDelegate *appDelegate;

@end

@implementation DetailRecordViewController

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"运动记录";
    
    self.navigationController.navigationBar.hidden = NO;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(RightItemAction)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self background];
    
    //加载数据前先对比本地数据库与服务器上的数据是否一致 不一致则要删除本地 从新加载服务器上的数据
    
    model = [[recordModel alloc]init];
    
    [model IsEqualToNetWorkData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notiAction:) name:@"AfterCompareRecord" object:nil];
}

-(UIImageView *)background{
    if(!_background){
        _background       = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _background.image = [UIImage imageNamed:@"background2"];
        
        [self.view addSubview:_background];
    }
    return  _background;
}

-(UITableView *)recordTableView{
    if(!_recordTableView){
        _recordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65) style:UITableViewStylePlain];
        
        _recordTableView.delegate        = self;
        _recordTableView.dataSource      = self;
        _recordTableView.backgroundColor = [UIColor clearColor];
        _recordTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_recordTableView];
    }
    return _recordTableView;
}

#pragma mark action
-(void)RightItemAction{
    
}

-(void)notiAction:(NSNotification *)noti{
    if([[noti.userInfo objectForKey:@"isEqual"] isEqualToString:@"yes"]){
        
        self.recordAr = [model GetRecordDataFromDataBase];
        
    }
    else if([[noti.userInfo objectForKey:@"isEqual"] isEqualToString:@"no"]){
        
        self.recordAr = [model GetRecordDataFromNetWork];
        
    }
    
    [self recordTableView];
}

-(void)backAction{
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.recordAr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"recordCell" owner:self options:nil];
    
    if(nib.count >0){
        self.customCell = [nib objectAtIndex:0];
        cell = self.customCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *type    = (UILabel *)[_customCell viewWithTag:1];
    UILabel *distant = (UILabel *)[_customCell viewWithTag:2];
    UILabel *time    = (UILabel *)[_customCell viewWithTag:3];
    UILabel *calorie = (UILabel *)[_customCell viewWithTag:4];
    UILabel *date    = (UILabel *)[_customCell viewWithTag:5];
    
    Record *r = [self.recordAr objectAtIndex:indexPath.row];
    switch (r.type) {
        case 0:
            type.text = @"跑步";
            break;
        case 1:
            type.text = @"骑车";
            break;
        case 2:
            type.text = @"步行";
            break;
        default:
            break;
    }
    distant.text = [NSString stringWithFormat:@"%.2f",r.distant];
    calorie.text = [NSString stringWithFormat:@"%d",(int)r.calorie];
    time.text    = [NSString stringWithFormat:@"%d",(int)r.time];
    date.text    = r.date;
 
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:self.recordTableView cellForRowAtIndexPath:indexPath];

    return cell.frame.size.height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MapRecordViewController *record = [[MapRecordViewController alloc]initWithMapRecordNum:(int)indexPath.row + 1];
    
    [self.navigationController pushViewController:record animated:YES];
}

@end

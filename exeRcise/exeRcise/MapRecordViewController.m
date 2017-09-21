//
//  MapRecordViewController.m
//  exeRcise
//
//  Created by hemeng on 17/6/27.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "MapRecordViewController.h"
#import "MapRecordModel.h"
#import "AppDelegate.h"

@interface MapRecordViewController (){
    __block NSArray *RecordAr;
    
    int MapRecordNum;
}

@property(nonatomic,strong)AppDelegate *appDelegate;

@end

@implementation MapRecordViewController

- (instancetype)initWithMapRecordNum:(int)num
{
    self = [super init];
    if (self) {
        MapRecordNum = num;

    }
    return self;
}

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.title = @"轨迹查看";
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    

    [self mapRecordView];
    
    [self GETMapTrack];

    //接受消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti) name:@"SuccessGetRecord" object:nil];

}

-(MapRecordView *)mapRecordView{
    if(!_mapRecordView){
        self.mapRecordView = [[MapRecordView alloc]initWithFrame:CGRectMake(0, 65, 375, 602)];
        
        [self.view addSubview:self.mapRecordView];
    }
    return _mapRecordView;
}

-(void)GETMapTrack{
    MapRecordModel *model = [[MapRecordModel alloc]init];
    
    [model getMapTrackRecordWithUId:self.appDelegate.userInfo.uid withRecordNum:MapRecordNum withBlock:^(NSArray *ar) {
        
        RecordAr = [NSArray arrayWithArray:ar];
    }];
}

-(void)noti{//拿到数据后解析

    [self.mapRecordView setStartPointLocactionWithLatitude:[[[RecordAr objectAtIndex:0] objectForKey:@"latitude"]doubleValue]
                                             withLongitude:[[[RecordAr objectAtIndex:0] objectForKey:@"longitude"]doubleValue]];
    
    int count = (int)RecordAr.count;
    
    int judge = 0;//判断是否改变线条颜色
    
    //储存断点数组 从1开始
    NSMutableArray *breakpoint = [NSMutableArray array];
    
    //由于不同颜色的线断是分开的所以判断线断的个数
    for(int i = 0; i < count; i++){
        NSDictionary *dic = [RecordAr objectAtIndex:i];
        
        if([[dic objectForKey:@"isExercise"]intValue] == judge){//当isExercise为0时 表明第一个断点 以此类推
            //保存断点位置
            [breakpoint addObject:[NSNumber numberWithInt:i + 1]];
            //judge反转
            if(judge == 0)
                judge = 1;
            else
                judge = 0;
        }

        if(i + 1 == count){//遍历到最后一个点时
            if(breakpoint.count == 0){//如果还没有断点 断点则是最后一个
                [breakpoint addObject:[NSNumber numberWithInt:i + 1]];
            }
        }
    }
    int startPoint = 0;//每条线断的起点 最大值小于breakPoint
    
    int color = 1;
    
    //遍历所有断点 每一次循环构成一条直线
    for(int i = 0; i < breakpoint.count ; i++){
        
        int breakPoint = [[breakpoint objectAtIndex:i]intValue];
        
        int n = breakPoint - startPoint;//
        CLLocationCoordinate2D commonPolylineCoords[n];//总计包含内容n＋1个

        for(int j = 0; j < n; j++){//总执行n＋1次
            NSDictionary *dic = [RecordAr objectAtIndex:j + startPoint];

            commonPolylineCoords[j].latitude = [[dic objectForKey:@"latitude"]doubleValue];
            commonPolylineCoords[j].longitude = [[dic objectForKey:@"longitude"]doubleValue];

        }
        //起点
        startPoint = breakPoint - 1;
        
        [self.mapRecordView drawTrackWitCLLocationCoordinate2D:commonPolylineCoords withCount:n withColor:color];
        
        //换第二条线条时转换颜色
        if(color == 1)
            color = 0;
        else
            color = 1;
    }
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

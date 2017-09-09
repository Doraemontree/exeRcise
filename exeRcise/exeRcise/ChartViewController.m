//
//  ChartViewController.m
//  exeRcise
//
//  Created by hemeng on 17/7/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "ChartViewController.h"
#import "ChartModel.h"

@interface ChartViewController (){
    NSArray *recordAr;
    
    UILabel *averageNum;
    
    UILabel *totalNum;
}

@end

@implementation ChartViewController

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:236.0/255.0 blue:245.0/255.0 alpha:1];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationItem.title = @"数据分析";
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = back;
    
    [self chartView];
    
    [self createLabel];

    ChartModel *model = [[ChartModel alloc]init];
    
    [model getRecordWithUId:self.appDelegate.userInfo.uid];
    
    model.returnRecord = ^(NSArray *ar){
        recordAr = [NSArray arrayWithArray:ar];
        
        [self performSelector:@selector(analyseRecordAr) withObject:nil];
    };
    
}
-(void)createLabel{
    _average = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
    _average.center = CGPointMake(187.5 - 80, 130);
    _average.text = @"平均每日公里";
    _average.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_average];
    
    _total = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
    _total.center = CGPointMake(187.5 + 80, 130);
    _total.text = @"总公里";
    _total.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_total];
    
    averageNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
    averageNum.center = CGPointMake(187.5 - 80, 170);
    averageNum.text = @"0";
    averageNum.font = [UIFont systemFontOfSize:33];
    averageNum.textColor = [UIColor colorWithRed:81.0/255.0 green:227.0/255.0 blue:216.0/255.0 alpha:1];
    averageNum.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:averageNum];
    
    totalNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
    totalNum.center = CGPointMake(187.5 + 80, 170);
    totalNum.text = @"0";
    totalNum.font = [UIFont systemFontOfSize:33];
    totalNum.textColor = [UIColor colorWithRed:81.0/255.0 green:227.0/255.0 blue:216.0/255.0 alpha:1];
    totalNum.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:totalNum];
}

-(void)analyseRecordAr{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSTimeInterval interval1 = 24 * 60 * 60;
    NSTimeInterval interval2 = 24 * 60 * 60 * 2;
    NSTimeInterval interval3 = 24 * 60 * 60 * 3;
    NSTimeInterval interval4 = 24 * 60 * 60 * 4;
    NSTimeInterval interval5 = 24 * 60 * 60 * 5;
    NSTimeInterval interval6 = 24 * 60 * 60 * 6;
    
    NSString *str1 = [formatter stringFromDate:date];
    NSString *str2 = [formatter stringFromDate:[date dateByAddingTimeInterval:-interval1]];
    NSString *str3 = [formatter stringFromDate:[date dateByAddingTimeInterval:-interval2]];
    NSString *str4 = [formatter stringFromDate:[date dateByAddingTimeInterval:-interval3]];
    NSString *str5 = [formatter stringFromDate:[date dateByAddingTimeInterval:-interval4]];
    NSString *str6 = [formatter stringFromDate:[date dateByAddingTimeInterval:-interval5]];
    NSString *str7 = [formatter stringFromDate:[date dateByAddingTimeInterval:-interval6]];
    
    //从今天开始到过去7天前
    float t1 = 0,t2 = 0,t3 = 0,t4 = 0,t5 = 0,t6 = 0,t7 = 0;
    
    for (NSDictionary *dic in recordAr) {
        
        NSString *str = [[dic objectForKey:@"date"] substringToIndex:10];
        
        if([str isEqualToString:str1]){
            t1 += [[dic objectForKey:@"distance"] floatValue];
        }
        else if([str isEqualToString:str2]){
            t2 += [[dic objectForKey:@"distance"] floatValue];
        }
        else if([str isEqualToString:str3]){
            t3 += [[dic objectForKey:@"distance"] floatValue];
        }
        else if([str isEqualToString:str4]){
            t4 += [[dic objectForKey:@"distance"] floatValue];
        }
        else if([str isEqualToString:str5]){
            t5 += [[dic objectForKey:@"distance"] floatValue];
        }
        else if([str isEqualToString:str6]){
            t6 += [[dic objectForKey:@"distance"] floatValue];
        }
        else if([str isEqualToString:str7]){
            t7 += [[dic objectForKey:@"distance"] floatValue];
        }
    }
    [_chartView ViewAnimationWithDataOne:t7 two:t6 three:t5 four:t4 five:t3 six:t2 seven:t1];
    
    float totalT = t1 + t2 + t3 + t4 + t5 + t6 + t7;
    float averageT = totalT / 7;
    
    //[self labelNumAnimationWithTotal:totalT withAverage:averageT];
    
    totalNum.text = [NSString stringWithFormat:@"%.3f",totalT];
    averageNum.text = [NSString stringWithFormat:@"%.3f",averageT];    
}
//-(void)labelNumAnimationWithTotal:(float)total withAverage:(float)average{
//    
////    CABasicAnimation *basic = [CABasicAnimation animation];
////    
////    basic.keyPath = @"values";
////    
////    basic.fromValue = @(0);
////    
////    basic.toValue = @(total);
////    
////    basic.duration = 1.f;
////    
////    [totalNum.layer addAnimation:basic forKey:nil];
//    
//    [UIView animateWithDuration:1 animations:^{
//        totalNum.text = [NSString stringWithFormat:@"%.3f",total];
//    }];
//}

-(void)backAction{
    self.navigationController.navigationBar.hidden = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(ChartView *)chartView{
    if(!_chartView){
        _chartView = [[ChartView alloc]initWithFrame:CGRectMake(0, 167, 375, 500) withTodayDate:[NSDate date]];
        
        [self.view addSubview:_chartView];
    }
    return _chartView;
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

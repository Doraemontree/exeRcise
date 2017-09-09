//
//  middleTableView.m
//  exeRcise
//
//  Created by hemeng on 17/5/2.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "middleTableView.h"

@implementation middleTableView

static NSString *identifier = @"Cell";
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self exerciseWay];
    }
    return self;
}

-(UITableView *)exerciseWay{
    if(!_exerciseWay){
        _exerciseWay = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _exerciseWay.delegate = self;
        _exerciseWay.dataSource = self;
        _exerciseWay.backgroundColor = [UIColor clearColor];
        _exerciseWay.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [self addSubview:_exerciseWay];
        
    }
    return _exerciseWay;
}

#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *way = [[NSArray alloc]initWithObjects:@"跑步",@"骑行",@"步行", nil];
    NSArray *imageWay = [[NSArray alloc]initWithObjects:@"run",@"cycling",@"walking", nil];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"myCell" owner:self options:nil];
    
    if(nib.count>0){
        self.customCell = [nib objectAtIndex:0];
        cell = self.customCell;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:100];
    
    image.layer.cornerRadius = 15;
    image.image = [UIImage imageNamed:[imageWay objectAtIndex:indexPath.row]];
    image.layer.masksToBounds = YES;
    
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
    
    label.text = [way objectAtIndex:indexPath.row];
    label.textColor = [UIColor whiteColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{//返回高度
    UITableViewCell *cell = [self tableView:_exerciseWay cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{//通过通知传值
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:indexPath.row] forKey:@"number"];
    
    NSNotification *notification = [NSNotification notificationWithName:@"gotoExerciseVC" object:nil userInfo:dic];
    
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    
}

@end

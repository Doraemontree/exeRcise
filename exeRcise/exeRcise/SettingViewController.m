//
//  SettingViewController.m
//  exeRcise
//
//  Created by hemeng on 17/6/23.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController (){
    NSArray *tableAr;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationItem.title = @"设置";
    
    [self tableview];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableview{
    if(_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStylePlain];
        
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
-(void)createData{
    tableAr = @[@"个人信息"];
    
    
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

//
//  NaviController.m
//  exeRcise
//
//  Created by hemeng on 17/4/20.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "NaviController.h"

@interface NaviController ()

@end

@implementation NaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.backgroundColor           = [UIColor whiteColor];
    self.navigationBar.barStyle                  = UIBarStyleDefault;
    self.navigationBar.hidden                    = YES;
    self.navigationBar.frame                     = CGRectMake(0, 0, self.view.bounds.size.width, 20);
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // Do any additional setup after loading the view.
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

//
//  customAlert.h
//  exeRcise
//
//  Created by hemeng on 17/6/17.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customAlert : UIView{
    
    UILabel *message;;
    
    UIActivityIndicatorView *indicator;
}

-(void)setMessage:(NSString *)str isCenter:(BOOL)flag;

-(void)ActivityIndicatorViewHidden;


@end

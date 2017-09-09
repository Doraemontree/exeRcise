//
//  EssayViewController.h
//  exeRcise
//
//  Created by hemeng on 17/5/11.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EssayViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIImageView *pic;

@property(nonatomic,strong)UILabel *Title;

@property(nonatomic,strong)UILabel *paragraphOne;

@property(nonatomic,strong)UISwipeGestureRecognizer *swipeGesture;

@end

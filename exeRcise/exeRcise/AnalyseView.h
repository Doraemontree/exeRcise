//
//  AnalyseView.h
//  exeRcise
//
//  Created by hemeng on 17/5/15.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AnalyseView : UIView{
    float maxDis;
    float maxTime;//单位 miao
    float Tcalorie;
    float Tdistance;
    float Ttime;
    int type;
    NSString *fStr;

}
@property(nonatomic,strong)UIImageView *background;

@property(nonatomic,strong)UILabel *distance;

@property(nonatomic,strong)UILabel *time;

@property(nonatomic,strong)UILabel *calorie;

@property(nonatomic,strong)UILabel *MostDis;

@property(nonatomic,strong)UILabel *MostTime;

@property(nonatomic,strong)UILabel *favourite;

- (instancetype)initWithFrame:(CGRect)frame withType:(int)typ withMaxDis:(float)dis withMaxTime:(float)maxtime withTotalCalorie:(float)c withTotalTime:(float)t withTotalDis:(float)d withFavouriteType:(NSString *)f;

@end

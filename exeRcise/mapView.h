//
//  mapView.h
//  exeRcise
//
//  Created by hemeng on 17/4/27.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <CoreMotion/CoreMotion.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "POP.h"

@class  mapView;
@protocol MapViewDelegate <NSObject>

-(void)DidClickBackMapButton:(mapView *)view;

@end


@interface mapView : UIView<MAMapViewDelegate>{
    CLLocationCoordinate2D commonPolyCoords[4];//连线
    
    double accelerationX;//加速计数据
    double accelerationY;
    double accelerationZ;
    
    double gravityX;//重力加速度
    double gravityY;
    double gravityZ;
    
    CGFloat sqrtValue;//减去重力加速度后的矢量加速度
    
    NSMutableArray *locationCoordinate;//保存定位点 所有点位组成一条线保存在allpolyline
    NSMutableArray *allPolyLine;//保存所有线段
    BOOL lastTimeIsExercising;//上一次的isexercising值
    
    BOOL color;//运动时绿色1暂停时红色0 默认1
    
}

@property (nonatomic,strong)MAMapView *map;
@property (nonatomic)BOOL isExercising;//判断是在运动还是暂停运动 默认为yes在运动
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, strong) UIButton *gpsButton;

@property (nonatomic, strong) UIButton *backMap;

@property (nonatomic)int distanceFilter;//定位点更新过滤器

@property (nonatomic)int UpdateTime;//更新次数

@property (nonatomic)double distance;//前进距离 单位km

@property (nonatomic,strong)NSMutableArray *exp;//保存gps定位点的数组

@property (nonatomic,strong)CMMotionManager *motion;

@property (nonatomic,weak)id<MapViewDelegate>delegate;

@property(nonatomic,strong)NSMutableArray *MapReocrdAr;//用于向服务器传输定位点


- (instancetype)initWithFrame:(CGRect)frame withDistanceFilter:(int)distanceFilter;

-(void)DoAnimationIn;
-(void)DoAnimationOut;
@end

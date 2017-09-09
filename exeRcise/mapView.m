//
//  mapView.m
//  exeRcise
//
//  Created by hemeng on 17/4/27.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "mapView.h"


@implementation mapView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 9fb6bb13fa1afc98438a35c27bdd4c2c
}
*/
- (instancetype)initWithFrame:(CGRect)frame withDistanceFilter:(int)distanceFilter
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.distanceFilter  = distanceFilter;
        _UpdateTime          = 0;
        _distance            = 0.0;
        _isExercising        = YES;
        lastTimeIsExercising = YES;
        _exp                 = [NSMutableArray array];
        locationCoordinate   = [NSMutableArray array];
        allPolyLine          = [NSMutableArray array];
        accelerationX        = 0;
        accelerationY        = 0;
        accelerationZ        = 0;
        gravityX             = 0;
        gravityY             = 0;
        gravityZ             = 0;
        sqrtValue            = 0;
        color                = 0;
        self.MapReocrdAr     = [NSMutableArray array];
        
        [self createMap];
        [self creatMotion];
        [self createGpsBtn];
        [self backMap];

    }
    return self;
}
-(void)creatMotion{
    _motion = [[CMMotionManager alloc]init];
    if([_motion isAccelerometerAvailable]){
        _motion.accelerometerUpdateInterval = 0.02;//50hz跟新频率
        
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        
        [_motion startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData,NSError *error){
            
            accelerationX = accelerometerData.acceleration.x;
            accelerationY = accelerometerData.acceleration.y;
            accelerationZ = accelerometerData.acceleration.z;
            
        }];
    }
    if([_motion isDeviceMotionAvailable]){
        _motion.deviceMotionUpdateInterval = 0.02;//50Hz 一秒返回50次数据
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [_motion startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion *device,NSError *error ){
            
            gravityX = device.gravity.x;
            gravityY = device.gravity.y;
            gravityZ = device.gravity.z;

            sqrtValue =sqrt((accelerationX - gravityX)*(accelerationX - gravityX)+(accelerationY - gravityY)*(accelerationY - gravityY)+(accelerationZ - gravityZ)*(accelerationZ - gravityZ));//速度
            
        }];
    }

}

-(void)createMap{
    [AMapServices sharedServices].apiKey      = @"9fb6bb13fa1afc98438a35c27bdd4c2c";
    [AMapServices sharedServices].enableHTTPS = YES;
    
    self.map = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.map.showsUserLocation                  = YES;
    self.map.delegate                           = self;
    self.map.userTrackingMode                   = MAUserTrackingModeFollow;
    self.map.pausesLocationUpdatesAutomatically = NO;
    self.map.distanceFilter                     = _distanceFilter;
    self.map.allowsBackgroundLocationUpdates    = YES;
    
    [self addSubview:self.map];

}

-(UIButton *)backMap{
    if(!_backMap){
        _backMap = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        _backMap.layer.cornerRadius   = 20;
        _backMap.backgroundColor      = [UIColor whiteColor];
        _backMap.layer.masksToBounds  = YES;
        self.backMap.center           = CGPointMake(self.bounds.size.width/2, self.bounds.size.height + 50);
        self.backMap.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [_backMap setImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
        [_backMap addTarget:self action:@selector(backMapAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_backMap];
    }
    return _backMap;
}

-(void)createGpsBtn{
    self.gpsButton                  = [self makeGPSButtonView];
    self.gpsButton.center           = CGPointMake(self.bounds.size.width/2, self.bounds.size.height + 50);
    self.gpsButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    
    [self addSubview:self.gpsButton];
}

- (UIButton *)makeGPSButtonView {
    UIButton *ret          = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 + 100, self.bounds.size.height - 150, 60, 60)];
    ret.backgroundColor    = [UIColor whiteColor];
    ret.layer.cornerRadius = 20;
    
    [ret setImage:[UIImage imageNamed:@"gpsStat1"] forState:UIControlStateNormal];
    [ret addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];
    
    return ret;
}

- (void)gpsAction {
    if(self.map.userLocation.updating && self.map.userLocation.location) {
        
        [self.map setCenterCoordinate:self.map.userLocation.location.coordinate animated:YES];
        
        [self.gpsButton setSelected:YES];
    }
}
-(void)backMapAction{
 
    [self.delegate DidClickBackMapButton:self];
}

#pragma mark -MAMAPdelegate
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.image = [UIImage imageNamed:@"userPosition-1"];
        pre.lineWidth = 3;
        pre.showsHeadingIndicator = YES;
        
        [self.map updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
        self.userLocationAnnotationView = view;
    }
}
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation){
        _UpdateTime++;
        
        NSMutableArray *temp = [NSMutableArray array];//temp目前的定位点
        
        double latitude = userLocation.location.coordinate.latitude;
        double longitude = userLocation.location.coordinate.longitude;
        
        //保留7位小数
        NSString *la = [NSString stringWithFormat:@"%.7f",latitude];
        NSString *lo = [NSString stringWithFormat:@"%.7f",longitude];
        
        [temp addObject:[NSNumber numberWithDouble:[la doubleValue]]];
        [temp addObject:[NSNumber numberWithDouble:[lo doubleValue]]];
        
        [_exp addObject:temp];
        
        if(_UpdateTime < 4)//剔除一开始多余的定位点
            [_exp removeAllObjects];
            
        int n = (int)_exp.count;
        
        //if(sqrtValue > 0.5){//有一定的加速度表示在运动
            if(n >= 2 && _isExercising == YES){//运动时候才计算距离

                CLLocationCoordinate2D loc1 = {
                    [[[_exp objectAtIndex:n-2] objectAtIndex:0] doubleValue],
                    [[[_exp objectAtIndex:n-2] objectAtIndex:1] doubleValue]};
                CLLocationCoordinate2D loc2 = {
                    [[[_exp objectAtIndex:n-1] objectAtIndex:0] doubleValue],
                    [[[_exp objectAtIndex:n-1] objectAtIndex:1] doubleValue]};
                
                MAMapPoint p1 = MAMapPointForCoordinate(loc1);
                MAMapPoint p2 = MAMapPointForCoordinate(loc2);
                
                CLLocationDistance distance1 =  MAMetersBetweenMapPoints(p1, p2);//计算距离
                
                _distance +=(distance1/1000);//单位 km
            }
            
        //}
        if(lastTimeIsExercising != self.isExercising){//表示一直暂停或一直运动
            [locationCoordinate addObject:[NSNumber numberWithBool:lastTimeIsExercising]];//该数组的最后一个元素保存该线断是运动还是暂停
            
            NSMutableArray *temp1 = [NSMutableArray arrayWithArray:locationCoordinate];//用于读取locationcoordinate最后一点
            
            [allPolyLine addObject:temp1];//保存该线段
            [locationCoordinate removeAllObjects];//清空该数组用于存放新线段
            [locationCoordinate addObject:[temp1 objectAtIndex:temp1.count - 2]];//上个线段的终点作为新线段的起点
            
            lastTimeIsExercising = self.isExercising;
        }
        for(int j = 0;j < allPolyLine.count; j++){//遍历与构造之前的线段
            
            int nq = (int)[[allPolyLine objectAtIndex:j] count];
            
            CLLocationCoordinate2D commonPolylineCoords[nq - 1];;
            
            for(int i = 0; i< nq - 1; i++){
                commonPolylineCoords[i].latitude = [[[[allPolyLine objectAtIndex:j] objectAtIndex:i] objectAtIndex:0] doubleValue];
                commonPolylineCoords[i].longitude = [[[[allPolyLine objectAtIndex:j] objectAtIndex:i] objectAtIndex:1]doubleValue];
                
            }
            if([[[allPolyLine objectAtIndex:j] lastObject]boolValue] == YES)//设置线段颜色
                color = YES;
            else
                color = NO;
            
            MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:nq-1];
            //在地图上添加折线对象
            [self.map addOverlay: commonPolyline];
            
        }

        if(self.isExercising == NO)//设置现在线段颜色
            color = NO;
        else
            color = YES;
        
        [locationCoordinate addObject:temp];
        
        int nq = (int)locationCoordinate.count;
        
        CLLocationCoordinate2D commonPolylineCoords[nq];
        
        for(int i = 0; i< locationCoordinate.count; i++){
            commonPolylineCoords[i].latitude = [[[locationCoordinate objectAtIndex:i] objectAtIndex:0]doubleValue];
            commonPolylineCoords[i].longitude = [[[locationCoordinate objectAtIndex:i] objectAtIndex:1]doubleValue];
            
        }
        //构造折线对象
        MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:locationCoordinate.count];
        //在地图上添加折线对象
        [self.map addOverlay: commonPolyline];
        
        //等temp用完后再保存map轨迹记录
        [temp addObject:[NSNumber numberWithBool:self.isExercising]];
        
        if(_UpdateTime >= 4)//剔除一开始多余的4个定位点
            [self.MapReocrdAr addObject:temp];
    }
    if (!updatingLocation && self.userLocationAnnotationView != nil)//箭头旋转
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );

        }];
    }
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 5.f;
        
        if(color == YES)
            polylineRenderer.strokeColor  = [UIColor greenColor];
        else{
            polylineRenderer.lineCap         = kCGLineCapSquare;
            polylineRenderer.lineDashPattern = @[@10, @10];
            polylineRenderer.strokeColor = [UIColor redColor];
        }
        
        return polylineRenderer;
    }
    
    return nil;
}
#pragma mark animation
-(void)DoAnimationIn{
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    spring.toValue             = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width/2 + 80, self.bounds.size.height - 150)];
    spring.springSpeed         = 20.f;
    spring.springBounciness    = 9.f;
    spring.beginTime           = CACurrentMediaTime() + 0.1f;
    
    [self.backMap.layer pop_addAnimation:spring forKey:nil];
    
    POPSpringAnimation *spring2 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    spring2.toValue             = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width/2 - 80, self.bounds.size.height - 150)];
    spring2.springSpeed         = 20.f;
    spring2.springBounciness    = 9.f;
    spring2.beginTime           = CACurrentMediaTime() + 0.1f;
    
    [self.gpsButton.layer pop_addAnimation:spring2 forKey:nil];
}

-(void)DoAnimationOut{
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    spring.toValue             = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height + 50)];
    spring.springSpeed         = 25.f;
    spring.beginTime           = CACurrentMediaTime();
    
    [self.backMap.layer pop_addAnimation:spring forKey:nil];
    [self.gpsButton.layer pop_addAnimation:spring forKey:nil];
}
@end

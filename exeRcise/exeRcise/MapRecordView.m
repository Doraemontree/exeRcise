//
//  MapRecordView.m
//  exeRcise
//
//  Created by hemeng on 17/6/27.
//  Copyright © 2017年 hemeng. All rights reserved.


#import "MapRecordView.h"

@implementation MapRecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createMap];
        
        _color = YES;
    }
    return self;
}

-(void)createMap{
    [AMapServices sharedServices].apiKey      = @"9fb6bb13fa1afc98438a35c27bdd4c2c";
    [AMapServices sharedServices].enableHTTPS = YES;
    
    self.map = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.map.showsUserLocation                  = YES;
    
    self.map.delegate                           = self;
    self.map.userTrackingMode                   = MAUserTrackingModeFollow;
    self.map.pausesLocationUpdatesAutomatically = NO;
    self.map.allowsBackgroundLocationUpdates    = YES;
    self.map.zoomLevel                          = 13;
    
    [self addSubview:self.map];
}

-(void)setStartPointLocactionWithLatitude:(double)latitude withLongitude:(double)longitude{
    self.map.centerCoordinate = CLLocationCoordinate2DMake(latitude,longitude);
    
}

-(void)drawTrackWitCLLocationCoordinate2D:(CLLocationCoordinate2D *)coordinate withCount:(int)count withColor:(int)color{
    
    //设置color
    if(color == 1)
        _color = YES;
    else
        _color = NO;
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:coordinate count:count];
    
    //在地图上添加折线对象
    [self.map addOverlay: commonPolyline];

}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 5.f;
        
        if(_color == YES)
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

@end

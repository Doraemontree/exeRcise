//
//  MapRecordView.h
//  exeRcise
//
//  Created by hemeng on 17/6/27.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface MapRecordView : UIView<MAMapViewDelegate>

@property (nonatomic,strong)MAMapView *map;

@property (nonatomic)BOOL color;//yes 为绿色 no为红色

-(void)setStartPointLocactionWithLatitude:(double)latitude withLongitude:(double)longitude;

-(void)drawTrackWitCLLocationCoordinate2D:(CLLocationCoordinate2D *)coordinate withCount:(int)count withColor:(int)color;

@end

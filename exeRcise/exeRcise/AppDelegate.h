//
//  AppDelegate.h
//  exeRcise
//
//  Created by hemeng on 17/4/19.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ViewController.h"
#import "NaviController.h"

#import "User+CoreDataProperties.h"
#import "Uinfo+CoreDataProperties.h"
#import "WalkingData+CoreDataProperties.h"
#import "RunningData+CoreDataProperties.h"
#import "CyclingData+CoreDataProperties.h"
#import "Record+CoreDataProperties.h"
#import "nUserInfo.h"
#import <UIKit+AFNetworking.h>

@class UserInfoModel;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property(nonatomic,strong)nUserInfo *userInfo;

- (void)saveContext;


@end


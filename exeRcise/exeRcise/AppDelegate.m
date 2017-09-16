//
//  AppDelegate.m
//  exeRcise
//
//  Created by hemeng on 17/4/19.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking.h>
#import "ViewControllerModel.h"
#import "ViewControllerHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //网络监听器
//    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
//    
//    NSURL *url = [[NSURL alloc]initWithString:@"https://139.199.158.105"];
//    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
//    
//    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                
//                NSLog(@"有网络");
//                break;
//                
//            case AFNetworkReachabilityStatusNotReachable:
//            default:
//                
//                NSLog(@"无网络");
//                break;
//        }
//
//    }];
//    
//    [manager.reachabilityManager startMonitoring];

    _userInfo = [[nUserInfo alloc]init];//贯穿全局的唯一userinfo保持从数据库读取的信息

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if(![userDefault objectForKey:@"id"]){
        
        [userDefault setObject:@"" forKey:@"id"];
    }
    else{
        NSLog(@"exist");
    }
    
    //获取上个用户登录帐号
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *uid = [userDefault objectForKey:@"id"];
    
    ViewControllerModel *model = [[ViewControllerModel alloc]init];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    /*判断写到appdelegate 不会重复加载viewcontroller viewdidload只加载界面不做逻辑判断*/
    //如果uid是空值
    if([uid isEqualToString:@""]){//没有默认用户则进入下载界面
        
        LoginViewController *login = [[LoginViewController alloc]init];//登录界面
        
        NaviController *navi = [[NaviController alloc]initWithRootViewController:login];
        
        self.window.rootViewController = navi;
        
        [self.window makeKeyAndVisible];
        
        //检查上次登录时间
        login.checkLastLoginTime = ^{
            NSLog(@"checkLastLoginTimeBlock");
            //更新最后登录时间和今天的运动情况
            [model autoUpdateLastLoginTimeAndTodayCDT];
            
            //这个时候userinfo的uid已经初始化了
            //模型从服务器上下载用户头像
            [model DownloadUserImageTolocalWithUid:_userInfo.uid];
            
        };
        login.refreshViewBlock = ^{
            NSLog(@"refreshViewBlock");
        };
    }
    else{//有默认登陆用户则从本地下载数据到appdelegate
        //创建模型
        ViewController *v = [[ViewController alloc]initWithNibName:nil bundle:nil];
        
        NaviController *navi = [[NaviController alloc]initWithRootViewController:v];
        
        self.window.rootViewController = navi;
        
        [self.window makeKeyAndVisible];
        
        _userInfo = [model GetUserInfo:uid];
        
        [model autoUpdateLastLoginTimeAndTodayCDT];
        
        [model DownloadUserImageTolocalWithUid:uid];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"exeRcise"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end

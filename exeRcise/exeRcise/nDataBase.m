//
//  nDataBase.m
//  exeRcise
//
//  Created by hemeng on 17/6/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "nDataBase.h"
#import <objc/message.h>

@implementation nDataBase

-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

-(NSArray *)loadDataFromLocalWithUserId:(NSString *)uid withEntity:(NSString *)entityname{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@",uid];
    
    NSArray *fetchObjects = [self GetFetchedObjectWithEntityName:entityname withPredicate:predicate];
    
    return fetchObjects;
}

#pragma mark add
-(void)addUserWithDic:(NSDictionary *)dic{
    
    NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    User *u = [[User alloc]initWithEntity:entityDes insertIntoManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    u.uid           = [dic objectForKey:@"id"];
    u.password      = [dic objectForKey:@"password"];
    u.name          = [dic objectForKey:@"name"];
    u.lastLoginTime = [dic objectForKey:@"lastLoginTime"];
    
    [self.appDelegate saveContext];
}

-(void)addUinfoWithDic:(NSDictionary *)dic{
    
    NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Uinfo" inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    Uinfo *u = [[Uinfo alloc]initWithEntity:entityDes insertIntoManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    u.uid    = [dic objectForKey:@"id"];
    u.height = [[dic objectForKey:@"height"] intValue];;
    u.weight = [[dic objectForKey:@"weight"] intValue];
    u.sex    = [dic objectForKey:@"sex"];
    u.aimC   = [[dic objectForKey:@"aimC"] floatValue];
    u.aimD   = [[dic objectForKey:@"aimD"] floatValue];
    u.aimT   = [[dic objectForKey:@"aimT"] floatValue];
    
    [self.appDelegate saveContext];
}

-(void)addRunningDataWithDic:(NSDictionary *)dic{
    NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"RunningData" inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    RunningData *r = [[RunningData alloc]initWithEntity:entityDes insertIntoManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    r.uid    = [dic objectForKey:@"id"];
    r.totalC = [[dic objectForKey:@"totalC"] floatValue];
    r.totalD = [[dic objectForKey:@"totalD"] floatValue];
    r.totalT = [[dic objectForKey:@"totalT"] floatValue];
    r.todayC = [[dic objectForKey:@"todayC"] floatValue];
    r.todayD = [[dic objectForKey:@"todayD"] floatValue];
    r.todayT = [[dic objectForKey:@"todayT"] floatValue];
    
    [self.appDelegate saveContext];
}

-(void)addCyclingDataWithDic:(NSDictionary *)dic{
    NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"CyclingData" inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    CyclingData *r = [[CyclingData alloc]initWithEntity:entityDes insertIntoManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    r.uid    = [dic objectForKey:@"id"];
    r.totalC = [[dic objectForKey:@"totalC"] floatValue];
    r.totalD = [[dic objectForKey:@"totalD"] floatValue];
    r.totalT = [[dic objectForKey:@"totalT"] floatValue];
    r.todayC = [[dic objectForKey:@"todayC"] floatValue];
    r.todayD = [[dic objectForKey:@"todayD"] floatValue];
    r.todayT = [[dic objectForKey:@"todayT"] floatValue];
    
    [self.appDelegate saveContext];
}

-(void)addWalkingDataWithDic:(NSDictionary *)dic{
    
    NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"WalkingData" inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    WalkingData *r = [[WalkingData alloc]initWithEntity:entityDes insertIntoManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    r.uid    = [dic objectForKey:@"id"];
    r.totalC = [[dic objectForKey:@"totalC"] floatValue];
    r.totalD = [[dic objectForKey:@"totalD"] floatValue];
    r.totalT = [[dic objectForKey:@"totalT"] floatValue];
    r.todayC = [[dic objectForKey:@"todayC"] floatValue];
    r.todayD = [[dic objectForKey:@"todayD"] floatValue];
    r.todayT = [[dic objectForKey:@"todayT"] floatValue];
    
    [self.appDelegate saveContext];
}

-(void)addRecordWithDic:(NSDictionary *)dic{
    NSEntityDescription *entitiDes = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    Record *r = [[Record alloc]initWithEntity:entitiDes insertIntoManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    r.uid     = [dic objectForKey:@"id"];
    r.num     = [[dic objectForKey:@"num"] intValue];
    r.type    = [[dic objectForKey:@"type"] intValue];
    r.calorie = [[dic objectForKey:@"calorie"] floatValue];
    r.distant = [[dic objectForKey:@"distance"] floatValue];
    r.time    = [[dic objectForKey:@"time"] floatValue];
    r.speed   = [dic objectForKey:@"speed"];//SPEED是string类型
    r.date    = [dic objectForKey:@"date"];
    
    [self.appDelegate saveContext];
}

//-(void)updateCyclingWithUid:(NSString *)uid withCalorie:(float)C withDistance:(float)D withTime:(float)T{
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@", uid];
//
//    NSArray *fetchedObjects = [self GetFetchedObjectWithEntityName:@"CyclingData" withPredicate:predicate];
//
//    for(CyclingData *c in fetchedObjects){
//        
//        c.todayC += C;
//        c.todayD += D;
//        c.todayT += T;
//        c.totalC += C;
//        c.totalD += D;
//        c.totalT += T;
//    }
//    [self.appDelegate saveContext];
//}

-(void)updateExeciseDataWithTableName:(NSString *)tablename withDic:(NSDictionary *)dic{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@", [dic objectForKey:@"id"]];
    
    NSArray *fetchedObjects = [self GetFetchedObjectWithEntityName:tablename withPredicate:predicate];
    
    BOOL isTodaySetZero = [[dic objectForKey:@"isTodaySetZero"] boolValue];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:tablename inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];

    //动态获取类实例
    Class obj = NSClassFromString(tablename);
    id data = [[obj alloc]initWithEntity:entity insertIntoManagedObjectContext:self.appDelegate.persistentContainer.viewContext];

    if(isTodaySetZero == YES){
        
        for(data in fetchedObjects){
            [data setValue:[NSNumber numberWithFloat:0] forKey:@"todayC"];
            [data setValue:[NSNumber numberWithFloat:0] forKey:@"todayD"];
            [data setValue:[NSNumber numberWithFloat:0] forKey:@"todayT"];
        }
    }
    else{
        for(data in fetchedObjects){
            float totalC = [[data valueForKey:@"totalC"]floatValue];
            float totalD = [[data valueForKey:@"totalD"]floatValue];
            float totalT = [[data valueForKey:@"totalT"]floatValue];
            
            float todayC = [[data valueForKey:@"todayC"]floatValue];
            float todayD = [[data valueForKey:@"todayD"]floatValue];
            float todayT = [[data valueForKey:@"todayT"]floatValue];
            
            float C = [[dic objectForKey:@"calorie"] floatValue];
            float D = [[dic objectForKey:@"distance"] floatValue];
            float T = [[dic objectForKey:@"time"] floatValue];
            
             NSLog(@"%f,%f,%f",[[dic objectForKey:@"calorie"]floatValue],[[dic objectForKey:@"distance"]floatValue],[[dic objectForKey:@"time"]floatValue]);
            
            [data setValue:[NSNumber numberWithFloat:C+todayC] forKey:@"todayC"];
            [data setValue:[NSNumber numberWithFloat:D+todayD] forKey:@"todayD"];
            [data setValue:[NSNumber numberWithFloat:T+todayT] forKey:@"todayT"];
            [data setValue:[NSNumber numberWithFloat:C+totalC] forKey:@"totalC"];
            [data setValue:[NSNumber numberWithFloat:D+totalD] forKey:@"totalD"];
            [data setValue:[NSNumber numberWithFloat:T+totalT] forKey:@"totalT"];
            
        }
    }
    [self.appDelegate saveContext];

}
-(void)updateCyclingWithUid:(NSString *)uid withDic:(NSDictionary *)dic{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@", uid];
    
    NSArray *fetchedObjects = [self GetFetchedObjectWithEntityName:@"CyclingData" withPredicate:predicate];
    
    float C = [[dic objectForKey:@"calorie"] floatValue];
    float D = [[dic objectForKey:@"distance"] floatValue];
    float T = [[dic objectForKey:@"time"] floatValue];
    BOOL isTodaySetZero = [[dic objectForKey:@"isTodaySetZero"] boolValue];
    
    for(CyclingData *c in fetchedObjects){
        
        if(isTodaySetZero == YES){
            c.todayC = 0;
            c.todayD = 0;
            c.todayT = 0;
        }
        else{
            c.todayC += C;
            c.todayD += D;
            c.todayT += T;
            c.totalC += C;
            c.totalD += D;
            c.totalT += T;
        }
    }
    [self.appDelegate saveContext];
}


-(void)updateUserWithUid:(NSString *)uid
                withName:(NSString *)name
            withPassword:(NSString *)password
       withlastLoginTime:(NSString *)lastLoginTime{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@",uid];
    
    NSArray *fetchedObjects = [self GetFetchedObjectWithEntityName:@"User" withPredicate:predicate];
    
    for(User *u in fetchedObjects){
        u.uid = uid;
        u.password = password;
        u.name = name;
        u.lastLoginTime = lastLoginTime;
    }
    
    [self.appDelegate saveContext];
}
-(void)updateUinfoWithUid:(NSString *)uid
                  withSex:(NSString *)sex
               withHeight:(int)height
               withWeight:(int)weight
                 withAimC:(float)aimC
                 withAimD:(float)aimD
                 withAimT:(float)aimT{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@",uid];
    
    NSArray *fetchedObjects = [self GetFetchedObjectWithEntityName:@"Uinfo" withPredicate:predicate];
    
    for(Uinfo *u in fetchedObjects){
        u.uid = uid;
        u.sex = sex;
        u.height = height;
        u.weight = weight;
        u.aimC = aimC;
        u.aimD = aimD;
        u.aimT = aimT;
    }
    
    [self.appDelegate saveContext];
}
-(void)deleteRecord:(NSString *)uid{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@", uid];
    
    NSArray *fetchedObjects = [self GetFetchedObjectWithEntityName:@"Record" withPredicate:predicate];
    
    for(Record *u in fetchedObjects){
        [self.appDelegate.persistentContainer.viewContext deleteObject:u];
    }
    [self.appDelegate saveContext];
}
-(void)deleteUser:(NSString *)username{

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@", username];

    NSArray *fetchedObjects = [self GetFetchedObjectWithEntityName:@"User" withPredicate:predicate];

    for(User *u in fetchedObjects){
        [self.appDelegate.persistentContainer.viewContext deleteObject:u];
    }
    
    predicate = [NSPredicate predicateWithFormat:@"uid == %@", username];
    
    fetchedObjects = [self GetFetchedObjectWithEntityName:@"Uinfo" withPredicate:predicate];
    
    for(Uinfo *u in fetchedObjects){
        [self.appDelegate.persistentContainer.viewContext deleteObject:u];
    }


    predicate = [NSPredicate predicateWithFormat:@"uid == %@", username];

    fetchedObjects = [self GetFetchedObjectWithEntityName:@"CyclingData" withPredicate:predicate];

    for(CyclingData *u in fetchedObjects){
        [self.appDelegate.persistentContainer.viewContext deleteObject:u];
    }

    predicate = [NSPredicate predicateWithFormat:@"uid == %@", username];

    fetchedObjects = [self GetFetchedObjectWithEntityName:@"RunningData" withPredicate:predicate];

    for(RunningData *u in fetchedObjects){
        [self.appDelegate.persistentContainer.viewContext deleteObject:u];
    }

    predicate = [NSPredicate predicateWithFormat:@"uid == %@", username];

    fetchedObjects = [self GetFetchedObjectWithEntityName:@"WalkingData" withPredicate:predicate];

    for(WalkingData *u in fetchedObjects){
        [self.appDelegate.persistentContainer.viewContext deleteObject:u];
    }

    [self.appDelegate saveContext];

}

-(NSArray *)GetFetchedObjectWithEntityName:(NSString *)entityname withPredicate:(NSPredicate *)predicate{//fetch操作

    // 建立获取数据的请求对象，并指明操作实体
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityname inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
    
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted

    NSError *error = nil;

    NSArray *fetchedObjects = [self.appDelegate.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];

    if (fetchedObjects == nil) {
        NSLog(@"error:%@",error);
    }
    return fetchedObjects;

}


@end

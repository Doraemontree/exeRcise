//
//  nDataBase.h
//  exeRcise
//
//  Created by hemeng on 17/6/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//
/**
 Core Data 是数据持久化存储的最佳方式
 数据最终的存储类型可以是：SQLite数据库，XML，二进制，内存里，或自定义数据类型
 在Mac OS X 10.5Leopard及以后的版本中，开发者也可以通过继承NSPersistentStore类以创建自定义的存储格式
 好处：能够合理管理内存，避免使用sql的麻烦，高效
 构成：
 (1)NSManagedObjectContext（被管理的数据上下文）
 操作实际内容（操作持久层）  托管对象上下文，进行数据操作时大多都是和这个类打交道。
 作用：插入数据，查询数据，删除数据
 (2)NSManagedObjectModel（被管理的数据模型）
 数据库所有表格或数据结构，包含各实体的定义信息  托管对象模型，一个托管对象模型关联一个模型文件(.xcdatamodeld)，存储着数据库的数据结构。
 作用：添加实体的属性，建立属性之间的关系
 操作方法：视图编辑器，或代码
 (3)NSPersistentStoreCoordinator（持久化存储助理）
 相当于数据库的连接器  持久化存储协调器，负责协调存储区和上下文之间的关系。
 作用：设置数据存储的名字，位置，存储方式，和存储时机
 (4)NSManagedObject（被管理的数据记录）
 相当于数据库中的表格记录   托管对象类，所有CoreData中的托管对象(即实体)都必须继承自当前类，根据实体创建托管对象类文件。
 (5)NSFetchRequest（获取数据的请求）
 相当于查询语句
 (6)NSEntityDescription（实体结构）
 相当于表格结构
 (7)后缀为.xcdatamodeld的包
 里面是.xcdatamodel文件，用数据模型编辑器编辑
 编译后为.momd或.mom文件
 
 
 */


//封装数据库操作 一切与数据库有关的都是这个操作
#import <Foundation/Foundation.h>

#ifndef _APPDELEGATE_H_
#define _APPDELEGATE_H_
#import "AppDelegate.h"
@class AppDelegate;
#endif

@interface nDataBase : NSObject

@property(nonatomic,strong)AppDelegate *appDelegate;
/*
 param uid 用户id
 param entityname 表名 表示从哪个表加载数据
 返回值为数组
 根据用户id与表加载所有该id的所有数据
 */
-(NSArray *)loadDataFromLocalWithUserId:(NSString *)uid withEntity:(NSString *)entityname;


-(void)addUserWithDic:(NSDictionary *)dic;
-(void)addUinfoWithDic:(NSDictionary *)dic;
-(void)addRunningDataWithDic:(NSDictionary *)dic;
-(void)addCyclingDataWithDic:(NSDictionary *)dic;
-(void)addWalkingDataWithDic:(NSDictionary *)dic;
-(void)addRecordWithDic:(NSDictionary *)dic;

-(void)updateExeciseDataWithTableName:(NSString *)tablename withDic:(NSDictionary *)dic;
-(void)updateUserWithUid:(NSString *)uid
                withName:(NSString *)name
            withPassword:(NSString *)password
       withlastLoginTime:(NSString *)lastLoginTime;
-(void)updateUinfoWithUid:(NSString *)uid
                  withSex:(NSString *)sex
               withHeight:(int)height
               withWeight:(int)weight
                 withAimC:(float)aimC
                 withAimD:(float)aimD
                 withAimT:(float)aimT;


-(void)deleteUser:(NSString *)username;
-(void)deleteRecord:(NSString *)uid;


@end

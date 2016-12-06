//
//  DBManager.m
//  LoveLife
//
//  Created by 张明军 on 15/12/29.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "FMDBOneList.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@implementation FMDBOneList
{
    FMDatabase * _dataBase;
   
}
static FMDBOneList * manager=nil;
+(FMDBOneList *)defaultManager
{
    //只调用一次，保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if(manager==nil){
        manager=[[FMDBOneList alloc]init];
        }
    });
    
    return manager;
}

- (instancetype)init
{
    if(self=[super init]){
        
    NSString * path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/addYiFei.db"];
    
        //很据路径创建表
        _dataBase = [[FMDatabase alloc]initWithPath:path];

        //如果创建成功 打开
        if ([_dataBase open]) {
           NSString *createSql = @"create table if not exists addYiFei(id varchar(1024),shopName varchar(1024),shopSize varchar(1024),shopMed varchar(1024),shopColor varchar(1024),shopPrice varchar(1024),shopHuoBi varchar(1024),shopTiaoK varchar(1024),shopAdderss varchar(1024),shopDescribe varchar(1024),shopInfo varchar(1024),shopCustom varchar(1024),shopContent varchar(1024),shopPicture varchar(6000))";
            //integer 数字  varchar字符串   glob 二进制数据NSData
            if ([_dataBase executeUpdate:createSql]){//executeUpdate 返回值是BOOL
                //executeUpdate 增、删、改、创建 都是使用这个方法
                NSLog(@"创建成功");
            }else{
                NSLog(@"%@",[_dataBase lastErrorMessage]);
            }
        }
    }
    return self;
}

//插入
- (void)insertDataModel:(shopData *)model{
    
    NSString * insertSql = @"insert into addYiFei(id,shopName,shopSize,shopMed,shopColor,shopPrice,shopHuoBi,shopTiaoK,shopAdderss,shopDescribe,shopInfo,shopCustom,shopContent,shopPicture) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

    BOOL success=[_dataBase executeUpdate:insertSql,model.companyID,model.shopName,model.shopSize,model.shopMed,model.shopColor,model.shopPrice,model.shopHuoBi,model.shopTiaoK,model.shopAdderss,model.shopDescribe,model.shopInfo,model.shopCustom,model.shopContent,model.shopPicture];
  
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"插入成功");
    }
}

//修改数据
- (void)updateDataModel:(shopData *)model{
    
    NSString *sql = [NSString stringWithFormat:@"update addYiFei set id = '%@', shopName = '%@',shopSize = '%@', shopMed = '%@', shopColor = '%@' ,shopPrice = '%@' ,shopHuoBi = '%@', shopTiaoK = '%@',shopAdderss='%@', shopDescribe = '%@' , shopInfo = '%@' ,shopCustom = '%@',shopContent = '%@',shopPicture = '%@'",model.companyID,model.shopName,model.shopSize,model.shopMed,model.shopColor,model.shopPrice,model.shopHuoBi,model.shopTiaoK,model.shopAdderss,model.shopDescribe,model.shopInfo,model.shopCustom,model.shopContent,model.shopPicture];
  BOOL success = [_dataBase executeUpdate:sql];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"插入成功");
    }
}

//查找
- (BOOL)isHasDataIDFromTable:(NSString* )dataId
{
    
    NSString * isSql = @"select *from addYiFei where id=?";
    
    //FMResultSet 查询结果的集合类
    FMResultSet * set = [_dataBase executeQuery:isSql,dataId];
    //[set next] 查找当前行 找到继续中查找下一行
    if ([set next]) {
        return YES;
    }else{
        return NO;
    }
    return [set next];//next 返回时一个BOOL
}
//删除
- (void)deleteNameFromTable:(NSString* )dataId
{
    NSString * deleteSql = @"delete from addYiFei where id = ?";
    if ([_dataBase executeUpdate:deleteSql,dataId]) {
        NSLog(@"删除成功");
    }
}


- (NSArray *)getData{
    
    NSString *resultSql = @"select *from addYiFei";
    FMResultSet * set = [_dataBase executeQuery:resultSql];
    NSMutableArray * arr = [NSMutableArray array];
    while ([set next]) {
      shopData* model = [[shopData alloc]init];
        model.companyID = [set stringForColumn:@"id"];
        model.shopName = [set stringForColumn:@"shopName"];
        model.shopSize=[set stringForColumn:@"shopSize"];
        model.shopMed=[set stringForColumn:@"shopMed"];
        model.shopColor=[set stringForColumn:@"shopColor"];
        model.shopPrice = [set stringForColumn:@"shopPrice"];
        model.shopHuoBi = [set stringForColumn:@"shopHuoBi"];
        model.shopTiaoK=[set stringForColumn:@"shopTiaoK"];
        model.shopAdderss=[set stringForColumn:@"shopAdderss"];
        model.shopDescribe=[set stringForColumn:@"shopDescribe"];
        model.shopInfo = [set stringForColumn:@"shopInfo"];
        model.shopCustom = [set stringForColumn:@"shopCustom"];
        model.shopContent=[set stringForColumn:@"shopContent"];
       model.shopPicture = [set stringForColumn:@"shopPicture"];
        [arr addObject:model];
    }
    return arr;
}


@end




















//
//  AskPriceList.m
//  Yi_Fei
//
//  Created by yons on 16/12/19.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AskPriceList.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface AskPriceList (){
    FMDatabase * _dataBase;
}

@end


@implementation AskPriceList

static AskPriceList * manager=nil;

+(AskPriceList *)defaultManager
{
    //只调用一次，保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if(manager==nil){
            manager=[[AskPriceList alloc]init];
        }
    });
    return manager;
}


- (instancetype)init
{
    if(self=[super init]){
        NSString * path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/AskPrice.db"];
        //很据路径创建表
        _dataBase = [[FMDatabase alloc]initWithPath:path];
        //如果创建成功 打开
        if ([_dataBase open]) {
            NSString *createSql = @"create table if not exists AskPrice(ind integer PRIMARY KEY AUTOINCREMENT,companyID varchar(1024),shopName varchar(1024),shopSize varchar(1024),shopMed varchar(1024),shopColor varchar(1024),shopPrice varchar(1024),shopHuoBi varchar(1024),shopTiaoK varchar(1024),shopAdderss varchar(1024),shopDescribe varchar(1024),shopInfo varchar(1024),shopCustom varchar(1024),shopContent varchar(1024),shopPicture varchar(6000),time  varchar(1024),flag varchar(1024),count varchar(1024) ,cleintName varchar(1024),shopSpecific varchar(1024))";
            //integer 数字  varchar字符串   glob 二进制数据NSData
            if ([_dataBase executeUpdate:createSql]){
                //executeUpdate 返回值是BOOL
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
- (void)insertDataModel:(AskPriceModel *)model{
    
    NSString * insertSql = @"insert into AskPrice(companyID,shopName,shopSize,shopMed,shopColor,shopPrice,shopHuoBi,shopTiaoK,shopAdderss,shopDescribe,shopInfo,shopCustom,shopContent,shopPicture,time,record,count,cleintName,shopSpecific) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    BOOL success=[_dataBase executeUpdate:insertSql,model.companyID,model.shopName,model.shopSize,model.shopMed,model.shopColor,model.shopPrice,model.shopHuoBi,model.shopTiaoK,model.shopAdderss,model.shopDescribe,model.shopInfo,model.shopCustom,model.shopContent,model.shopPicture,model.time,model.record,model.count,model.cleintName,model.shopSpecific];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"插入成功");
    }
}

//修改数据
- (void)updateDataModel:(AskPriceModel *)model number:(int)number  {
    
    NSString *sql = [NSString stringWithFormat:@"update AskPrice set companyID = ?, shopName = ?,shopSize = ?, shopMed = ?, shopColor = ? ,shopPrice = ? ,shopHuoBi = ?, shopTiaoK = ?,shopAdderss= ?, shopDescribe = ? , shopInfo = ? ,shopCustom = ?,shopContent = ?,shopPicture = ?,time = ?,record = ?,count = ?,cleintName = ? ,shopSpecific = ?  where  ind = ?"];
    NSString *str = [NSString stringWithFormat:@"%d",number];
    BOOL success = [_dataBase executeUpdate:sql,model.companyID,model.shopName,model.shopSize,model.shopMed,model.shopColor,model.shopPrice,model.shopHuoBi,model.shopTiaoK,model.shopAdderss,model.shopDescribe,model.shopInfo,model.shopCustom,model.shopContent,model.shopPicture,model.time,model.record,model.count,model.cleintName,model.shopSpecific,str];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"修改成功");
    }
}

//查找
- (BOOL)isHasDataIDFromTable:(int)dataId;
{
    NSString * isSql = @"select *from AskPrice where ind =?";
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
- (void)deleteNameFromTable:(int)dataId
{
    NSString * deleteSql = @"delete from AskPrice where ind = ?";
    if ([_dataBase executeUpdate:deleteSql,dataId]) {
        NSLog(@"删除成功");
    }
}

- (NSArray *)getDataWith:(NSString*)dataId{

    NSString * resultSql = @"select *from AskPrice where cleintName =?";
    FMResultSet * set = [_dataBase executeQuery:resultSql,dataId];
    NSMutableArray * arr = [NSMutableArray array];
    while ([set next]) {
        AskPriceModel* model = [[AskPriceModel alloc]init];
        model.companyID = [set stringForColumn:@"companyID"];
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
        model.time = [set stringForColumn:@"time"];
        model.count = [set stringForColumn:@"count"];
        model.record = [set stringForColumn:@"record"];
        model.cleintName = [set stringForColumn:@"cleintName"];
        model.shopSpecific = [set stringForColumn:@"shopSpecific"];
        model.ind = [set  intForColumn:@"ind" ];
        [arr addObject:model];
    }
  return arr;
}




















@end

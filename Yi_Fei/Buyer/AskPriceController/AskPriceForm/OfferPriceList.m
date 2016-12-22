//
//  AskPriceList.m
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "OfferPriceList.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface OfferPriceList ()
{
    FMDatabase * _dataBase;
}

@end

@implementation OfferPriceList


static OfferPriceList * manager=nil;
+(OfferPriceList *)defaultManager
{
    //只调用一次，保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if(manager==nil){
            manager=[[OfferPriceList alloc]init];
        }
    });
    return manager;
}


- (instancetype)init
{
    if(self=[super init]){
        NSString * path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/offerPrice.db"];
        //很据路径创建表
        _dataBase = [[FMDatabase alloc]initWithPath:path];
        //如果创建成功 打开
        if ([_dataBase open]) {
            NSString *createSql = @"create table if not exists offerPrice(ind integer PRIMARY KEY AUTOINCREMENT,companyID varchar(1024),shopName varchar(1024),shopSize varchar(1024),shopMed varchar(1024),shopColor varchar(1024),shopPrice varchar(1024),shopHuoBi varchar(1024),shopTiaoK varchar(1024),shopAdderss varchar(1024),shopDescribe varchar(1024),shopInfo varchar(1024),shopCustom varchar(1024),shopContent varchar(1024),shopPicture varchar(6000),time  varchar(1024),flag varchar(1024),count varchar(1024) ,cleintName varchar(1024),shopSpecific varchar(1024) )";
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
- (void)insertDataModel:(OfferPriceModel *)model{
    
    NSString * insertSql = @"insert into offerPrice(companyID,shopName,shopSize,shopMed,shopColor,shopPrice,shopHuoBi,shopTiaoK,shopAdderss,shopDescribe,shopInfo,shopCustom,shopContent,shopPicture,time,flag,count,cleintName,shopSpecific) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    BOOL success=[_dataBase executeUpdate:insertSql,model.companyID,model.shopName,model.shopSize,model.shopMed,model.shopColor,model.shopPrice,model.shopHuoBi,model.shopTiaoK,model.shopAdderss,model.shopDescribe,model.shopInfo,model.shopCustom,model.shopContent,model.shopPicture,model.time,model.flag,model.count,model.cleintName,model.shopSpecific];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"插入成功");
    }
    
}

//修改数据
- (void)updateDataModel:(OfferPriceModel *)model number:(int)number  {
    
    NSString *sql = [NSString stringWithFormat:@"update offerPrice set companyID = ?, shopName = ?,shopSize = ?, shopMed = ?, shopColor = ? ,shopPrice = ? ,shopHuoBi = ?, shopTiaoK = ?,shopAdderss= ?, shopDescribe = ? , shopInfo = ? ,shopCustom = ?,shopContent = ?,shopPicture = ?,time = ?,flag = ?,count = ?,cleintName = ?,shopSpecific = ?  where  ind = ?"];
    NSString *str = [NSString stringWithFormat:@"%d",number];
    BOOL success = [_dataBase executeUpdate:sql,model.companyID,model.shopName,model.shopSize,model.shopMed,model.shopColor,model.shopPrice,model.shopHuoBi,model.shopTiaoK,model.shopAdderss,model.shopDescribe,model.shopInfo,model.shopCustom,model.shopContent,model.shopPicture,model.time,model.flag,model.count,model.cleintName,model.shopSpecific,str];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"修改成功");
    }
}

//查找
- (BOOL)isHasDataIDFromTable:(int)dataId;
{
    NSString * isSql = @"select *from offerPrice where ind =?";
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
    NSString *str = [NSString stringWithFormat:@"%d",dataId];
    NSString * deleteSql = @"delete from offerPrice where ind = ?";
    if ([_dataBase executeUpdate:deleteSql,str]) {
        NSLog(@"删除成功");
    }
}



- (NSArray *)getDataWith:(NSString*)dataId{
    
   NSString * resultSql = @"select *from offerPrice where cleintName =?";
    FMResultSet * set = [_dataBase executeQuery:resultSql,dataId];
    NSMutableArray * arr = [NSMutableArray array];
    while ([set next]) {
        OfferPriceModel* model = [[OfferPriceModel alloc]init];
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
        model.flag = [set stringForColumn:@"flag"];
        model.cleintName = [set stringForColumn:@"cleintName"];
        model.shopSpecific = [set stringForColumn:@"shopSpecific"];
        model.ind = [set  intForColumn:@"ind" ];
        [arr addObject:model];
    }
    return arr;
}













@end




























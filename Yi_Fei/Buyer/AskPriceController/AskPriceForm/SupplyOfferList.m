
//
//  SupplyOfferList.m
//  Yi_Fei
//
//  Created by yons on 17/1/4.
//  Copyright © 2017年 ZMJPersonal. All rights reserved.
//

#import "SupplyOfferList.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface SupplyOfferList (){
    FMDatabase * _dataBase;
}

@end

@implementation SupplyOfferList

static SupplyOfferList * manager=nil;
+(SupplyOfferList *)defaultManager
{
    //只调用一次，保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if(manager==nil){
            manager=[[SupplyOfferList alloc]init];
        }
    });
    return manager;
}



- (instancetype)init
{
    if(self=[super init]){
        NSString * path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/SupplyOfferPrice.db"];
        //很据路径创建表
        _dataBase = [[FMDatabase alloc]initWithPath:path];
        //如果创建成功 打开
        if ([_dataBase open]) {
            NSString *createSql = @"create table if not exists CustomerAskPrice(ind integer PRIMARY KEY AUTOINCREMENT,companyID varchar(1024),shopName varchar(1024) ,shopSpecific varchar(1024),shopMed varchar(1024) ,shopSize varchar(1024),shopColor varchar(1024) ,count varchar(1024),flag varchar(1024) ,time  varchar(1024),offerTime varchar(1024),shopDescribe varchar(1024),imageOne glob(6000),imageTwo glob(6000),imageThree glob(6000),imageFour glob(6000),supplyName varchar(1024),companyName varchar(1024),shopHuoBi varchar(1024),shopTiaoK varchar(1024),shopCustom varchar(1024),shopContent varchar(1024),shopInfo varchar(1024) ,shopPrice varchar(1024),shopAdderss varchar(1024) ,identify varchar(1024))";
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
- (void)insertDataModel:(SupplyOfferModel *)model{
    
    NSString * insertSql = @"insert into CustomerAskPrice(companyID,shopName,shopSpecific,shopMed,shopSize,shopColor,count,flag,time,offerTime ,shopDescribe,imageOne,imageTwo,imageThree,imageFour,supplyName,companyName,shopHuoBi,shopTiaoK,shopCustom ,shopContent,shopInfo,shopPrice,shopAdderss,identify) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    BOOL success=[_dataBase executeUpdate:insertSql,model.companyID,model.shopName,model.shopSpecific,model.shopMed,model.shopSize,model.shopColor,model.count,model.flag,model.time,model.offerTime,model.shopDescribe,model.imageOne,model.imageTwo,model.imageThree,model.imageFour,model.supplyName,model.companyName,model.shopHuoBi,model.shopTiaoK,model.shopCustom,model.shopContent,model.shopInfo,model.shopPrice,model.shopAdderss,model.identify];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"插入成功");
    }
}




- (NSArray *)getDataName:(NSString*)name and:(NSString*)companyName identify:(NSString*)identify{
    
    NSString * resultSql = @"select *from CustomerAskPrice where (customerName = ? and companyName = ? and  identify = ? ) order by askTime asc ";
    FMResultSet * set = [_dataBase executeQuery:resultSql,name,companyName,identify];
    NSMutableArray * arr = [NSMutableArray array];
    while ([set next]) {
        SupplyOfferModel* model = [[SupplyOfferModel alloc]init];
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
        model.imageOne = [set dataForColumn:@"imageOne"];
        model.imageTwo = [set dataForColumn:@"imageTwo"];
        model.imageThree = [set dataForColumn:@"imageThree"];
        model.imageFour = [set dataForColumn:@"imageFour"];
        model.time = [set stringForColumn:@"time"];
        model.count = [set stringForColumn:@"count"];
        model.flag = [set stringForColumn:@"flag"];
        model.supplyName = [set stringForColumn:@"supplyName"];
        model.shopSpecific = [set stringForColumn:@"shopSpecific"];
        model.offerTime = [set stringForColumn:@"offerTime"];
        model.companyName = [set stringForColumn:@"companyName"];
        model.identify = [set stringForColumn:@"identify"];
        model.ind = [set  intForColumn:@"ind" ];
        [arr addObject:model];
    }
    return arr;
}







//根据字段搜索留样询价
-(NSArray *)getDataName:(NSString*)name and:(NSString*)companyName and:(NSString*)index  identify:(NSString*)identify{
    
    NSString * resultSql = @"select *from CustomerAskPrice where customerName = ? and companyName = ?  and flag = ? and identify = ? ";
    FMResultSet * set = [_dataBase executeQuery:resultSql,name,companyName,index,identify];
    NSMutableArray * arr = [NSMutableArray array];
    while ([set next]) {
        SupplyOfferModel* model = [[SupplyOfferModel alloc]init];
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
        model.imageOne = [set dataForColumn:@"imageOne"];
        model.imageTwo = [set dataForColumn:@"imageTwo"];
        model.imageThree = [set dataForColumn:@"imageThree"];
        model.imageFour = [set dataForColumn:@"imageFour"];
        model.time = [set stringForColumn:@"time"];
        model.count = [set stringForColumn:@"count"];
        model.flag = [set stringForColumn:@"flag"];
        model.supplyName = [set stringForColumn:@"supplyName"];
        model.shopSpecific = [set stringForColumn:@"shopSpecific"];
        model.offerTime = [set stringForColumn:@"askTime"];
        model.companyName = [set stringForColumn:@"companyName"];
        model.identify = [set stringForColumn:@"identify"];
        model.ind = [set  intForColumn:@"ind" ];
        [arr addObject:model];
    }
    return arr;
}







-(NSArray *)getDataName:(NSString*)name and:(NSString*)companyName and:(NSString*)index{
    
    NSString * resultSql = @"select *from CustomerAskPrice where customerName = ? and companyName = ?  and flag = ? ";
    FMResultSet * set = [_dataBase executeQuery:resultSql,name,companyName,index];
    NSMutableArray * arr = [NSMutableArray array];
    while ([set next]) {
        SupplyOfferModel* model = [[SupplyOfferModel alloc]init];
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
        model.imageOne = [set dataForColumn:@"imageOne"];
        model.imageTwo = [set dataForColumn:@"imageTwo"];
        model.imageThree = [set dataForColumn:@"imageThree"];
        model.imageFour = [set dataForColumn:@"imageFour"];
        model.time = [set stringForColumn:@"time"];
        model.count = [set stringForColumn:@"count"];
        model.flag = [set stringForColumn:@"flag"];
        model.supplyName = [set stringForColumn:@"supplyName"];
        model.shopSpecific = [set stringForColumn:@"shopSpecific"];
        model.offerTime = [set stringForColumn:@"offerTime"];
        model.companyName = [set stringForColumn:@"companyName"];
        model.identify = [set stringForColumn:@"identify"];
        model.ind = [set  intForColumn:@"ind" ];
        [arr addObject:model];
    }
    return arr;
}

- (void)deleteElement:(NSString*)name and:(NSString*)companyName index:(NSString*)index num:(NSString*)num{
    
    NSString * deleteSql = @"delete from CustomerAskPrice where customerName = ? and companyName = ? and flag = ? and ind = ? ";
    if ([_dataBase executeUpdate:deleteSql,name,companyName,index,num]) {
        NSLog(@"删除成功");
    }
}


- (BOOL)isHasElement:(NSString*)name and:(NSString*)companyName productName:(NSString*)productName index:(NSString*)index{
    
    NSString * isSql = @"select *from CustomerAskPrice where customerName =? and companyName = ? and  shopName = ? and flag = ? ";
    FMResultSet * set = [_dataBase executeQuery:isSql,name,companyName,productName,index];
    if ([set next]) {
        return YES;
    }else{
        return NO;
    }
    return [set next];
}




-(void)updateMolde:(SupplyOfferModel *)model Element:(NSString*)name and:(NSString*)companyName  num:(NSString*)num index:(NSString*)index{

    NSString *sql = [NSString stringWithFormat:@"update CustomerAskPrice set companyID = ?, shopName = ?,shopSpecific = ?, shopMed = ?, shopSize = ? ,shopColor = ? ,count = ?, flag = ?,time= ?, offerTime = ? , shopDescribe = ? ,imageOne = ?,imageTwo = ?,imageThree = ?,imageFour = ?,shopHuoBi = ? ,shopTiaoK = ? ,shopCustom = ? ,shopContent = ?,shopInfo = ?,shopPrice = ? ,shopAdderss = ?   ,identify = ?  where  supplyName = ? and  companyName = ? and flag = ? and ind = ?"];
    BOOL success = [_dataBase executeUpdate:sql,model.companyID,model.shopName,model.shopSpecific,model.shopMed,model.shopSize,model.shopColor,model.count,model.flag,model.time,model.offerTime,model.shopDescribe,model.imageOne,model.imageTwo,model.imageThree,model.imageFour,model.shopHuoBi,model.shopTiaoK,model.shopCustom,model.shopContent,model.shopInfo,model.shopPrice,model.shopAdderss,model.identify,name,companyName,num,index];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"修改成功");
    }
}








@end



































//
//  NewTwoList.m
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "NewTwoList.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@implementation NewTwoList
{
    FMDatabase * _dataBase;
}

static NewTwoList * manager=nil;

+(NewTwoList *)newListManager
{
    //只调用一次，保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if(manager==nil){
            manager = [[NewTwoList alloc]init];
        }
    });
    return manager;
}


- (instancetype)init
{
    if(self=[super init]){
        
        NSString * path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/addTwoYiFei.db"];
        //很据路径创建表
        _dataBase = [[FMDatabase alloc]initWithPath:path];
        //如果创建成功 打开
        if ([_dataBase open]) {
            
         NSString *createSql = @"create table if not exists addTwoYiFei(ind integer PRIMARY KEY AUTOINCREMENT,companyID varchar(1024),shopName varchar(1024),shopSize varchar(1024),shopMed varchar(1024),shopColor varchar(1024),shopPrice varchar(1024),shopHuoBi varchar(1024),shopTiaoK varchar(1024),shopAdderss varchar(1024),shopDescribe varchar(1024),shopInfo varchar(1024),shopCustom varchar(1024),shopContent varchar(1024),shopPicture varchar(6000))";
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
- (void)insertDataModel:(ProductionData *)model{
    NSString * insertSql = @"insert into addTwoYiFei(companyID,shopName,shopSize,shopMed,shopColor,shopPrice,shopHuoBi,shopTiaoK,shopAdderss,shopDescribe,shopInfo,shopCustom,shopContent,shopPicture) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    BOOL success=[_dataBase executeUpdate:insertSql,model.companyID,model.shopName,model.shopSize,model.shopMed,model.shopColor,model.shopPrice,model.shopHuoBi,model.shopTiaoK,model.shopAdderss,model.shopDescribe,model.shopInfo,model.shopCustom,model.shopContent,model.shopPicture];
    if (!success) {
    NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
    NSLog(@"插入成功");
    }
}

//修改数据
- (void)updateDataModel:(ProductionData *)model number:(int)number{
    
    NSString *sql = [NSString stringWithFormat:@"update addTwoYiFei set companyID = ?, shopName = ?,shopSize = ?, shopMed = ?, shopColor = ? ,shopPrice = ? ,shopHuoBi = ?, shopTiaoK = ?,shopAdderss= ?, shopDescribe = ? , shopInfo = ? ,shopCustom = ?,shopContent = ?,shopPicture = ? where  ind = ?"];
    NSString *str = [NSString stringWithFormat:@"%d",number];
    BOOL success = [_dataBase executeUpdate:sql,model.companyID,model.shopName,model.shopSize,model.shopMed,model.shopColor,model.shopPrice,model.shopHuoBi,model.shopTiaoK,model.shopAdderss,model.shopDescribe,model.shopInfo,model.shopCustom,model.shopContent,model.shopPicture,str];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"插入成功");
    }
}

//查找
- (BOOL)isHasDataIDFromTable:(int)dataId
{
    NSString * isSql = @"select *from addTwoYiFei where ind=?";
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
- (void)deleteNameFromTable:(NSString*)dataId
{
    NSString * deleteSql = @"delete from addTwoYiFei where companyID = ?";
    if ([_dataBase executeUpdate:deleteSql,dataId]) {
        NSLog(@"删除成功");
    }
}


- (NSArray *)getData{
    
    NSString *resultSql = @"select *from addTwoYiFei";
    FMResultSet * set = [_dataBase executeQuery:resultSql];
    NSMutableArray * arr = [NSMutableArray array];
    while ([set next]) {
        ProductionData* model = [[ProductionData alloc]init];
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
        model.ind = [set  intForColumn:@"ind" ];
        [arr addObject:model];
    }
    return arr;
}







































@end

















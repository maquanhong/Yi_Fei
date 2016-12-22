//
//  TemplateList.m
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TemplateList.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface TemplateList (){
    FMDatabase * _dataBase;
}

@end



@implementation TemplateList

static TemplateList * manager=nil;

+(TemplateList *)defaultManager
{
    //只调用一次，保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if(manager==nil){
            manager=[[TemplateList alloc]init];
        }
    });
    return manager;
}


- (instancetype)init
{
    if(self=[super init]){
        NSString * path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Template.db"];
        //很据路径创建表
        _dataBase = [[FMDatabase alloc]initWithPath:path];
        //如果创建成功 打开
        if ([_dataBase open]) {
            NSString *createSql = @"create table if not exists Template(ind integer PRIMARY KEY AUTOINCREMENT,companyID varchar(1024),shopName varchar(1024),shopPrice varchar(1024),shopMed varchar(1024),shopColor varchar(1024),sizeUnit varchar(1024),HeightUnit varchar(1024),shopSize varchar(1024),shopHeight varchar(1024),shopNumOne varchar(1024),shopHeightOne varchar(1024),shopSizeOne varchar(1024),shopNumTwo varchar(1024),shopHeightTwo varchar(6000),shopSizeTwo  varchar(1024),shopHuoBi varchar(1024),shopTiaoK varchar(1024) ,shopPicture varchar(1024),customeTile varchar(1024),customeContent varchar(1024),shopAddress varchar(1024))";
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
- (void)insertDataModel:(TemplateModel *)model{
    NSString * insertSql = @"insert into Template(companyID,shopName,shopPrice,shopMed,shopColor,sizeUnit,HeightUnit,shopSize,shopHeight,shopNumOne,shopHeightOne,shopSizeOne,shopNumTwo,shopHeightTwo,shopSizeTwo,shopHuoBi,shopTiaoK,shopPicture,customeTile,customeContent,shopAddress) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    BOOL success=[_dataBase executeUpdate:insertSql,model.companyID,model.shopName,model.shopPrice,model.shopMed,model.shopColor,model.sizeUnit,model.HeightUnit,model.shopSize,model.shopHeight,model.shopNumOne,model.shopHeightOne,model.shopSizeOne,model.shopNumTwo,model.shopHeightTwo,model.shopSizeTwo,model.shopHuoBi,model.shopTiaoK,model.shopPicture,model.customeTile,model.customeContent,model.shopAddress];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"插入成功");
    }
}


//修改数据
- (void)updateDataModel:(TemplateModel *)model number:(int)number  {
    
    NSString *sql = [NSString stringWithFormat:@"update Template set companyID = ?, shopName = ?,shopPrice = ?, shopMed = ?, shopColor = ? ,sizeUnit = ? ,HeightUnit = ?, shopSize = ?,shopHeight= ?, shopNumOne = ? , shopHeightOne = ? ,shopSizeOne = ?,shopNumTwo = ?,shopHeightTwo = ?,shopSizeTwo = ?,shopHuoBi = ?,shopTiaoK = ?,shopPicture = ?,customeTile = ?,customeContent = ?,shopAddress = ?  where  ind = ?"];
    NSString *str = [NSString stringWithFormat:@"%d",number];
    BOOL success = [_dataBase executeUpdate:sql,model.companyID,model.shopName,model.shopPrice,model.shopMed,model.shopColor,model.sizeUnit,model.HeightUnit,model.shopSize,model.shopHeight,model.shopNumOne,model.shopHeightOne,model.shopSizeOne,model.shopNumTwo,model.shopHeightTwo,model.shopSizeTwo,model.shopHuoBi,model.shopTiaoK,model.shopPicture,model.customeTile,model.customeContent,model.shopAddress,str];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"修改成功");
    }
}

//查找
- (BOOL)isHasDataIDFromTable:(int)dataId;
{
    NSString * isSql = @"select *from Template where ind =?";

    FMResultSet * set = [_dataBase executeQuery:isSql,dataId];
    if ([set next]) {
        return YES;
    }else{
        return NO;
    }
    return [set next];
}

//删除
- (void)deleteNameFromTable:(int)dataId
{
    NSString * deleteSql = @"delete from Template where companyID = ?";
    if ([_dataBase executeUpdate:deleteSql,dataId]) {
        NSLog(@"删除成功");
    }
}


#pragma mark 从创建的数据库中读取所有的值
- (NSArray *)getData{
    
    NSString *resultSql = @"select *from Template";
    FMResultSet * set = [_dataBase executeQuery:resultSql];
    NSMutableArray * arr = [NSMutableArray array];
    while ([set next]) {
        TemplateModel* model = [[TemplateModel alloc]init];
        model.companyID = [set stringForColumn:@"companyID"];
        model.shopPrice = [set stringForColumn:@"shopPrice"];
        model.shopName = [set stringForColumn:@"shopName"];
        model.shopMed=[set stringForColumn:@"shopMed"];
        model.shopColor=[set stringForColumn:@"shopColor"];
        model.sizeUnit = [set stringForColumn:@"sizeUnit"];
        model.HeightUnit=[set stringForColumn:@"HeightUnit"];
        model.shopSize=[set stringForColumn:@"shopSize"];
        model.shopHeight=[set stringForColumn:@"shopHeight"];
        model.shopNumOne = [set stringForColumn:@"shopNumOne"];
        model.shopHeightOne = [set stringForColumn:@"shopHeightOne"];
        model.shopSizeOne=[set stringForColumn:@"shopSizeOne"];
        model.shopNumTwo = [set stringForColumn:@"shopNumTwo"];
        model.shopHeightTwo = [set stringForColumn:@"shopHeightTwo"];
        model.shopSizeTwo=[set stringForColumn:@"shopSizeTwo"];
        model.shopHuoBi=[set stringForColumn:@"shopHuoBi"];
        model.shopTiaoK=[set stringForColumn:@"shopTiaoK"];
        model.shopPicture = [set stringForColumn:@"shopPicture"];
        model.customeTile = [set stringForColumn:@"customeTile"];
        model.customeContent=[set stringForColumn:@"customeContent"];
        model.shopAddress = [set stringForColumn:@"shopAddress"];
        [arr addObject:model];
    }
    return arr;
}















@end



























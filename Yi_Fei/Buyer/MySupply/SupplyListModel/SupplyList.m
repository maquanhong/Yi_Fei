//
//  SupplyList.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SupplyList.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface SupplyList ()
{
    FMDatabase * _dataBase;
}

@end


@implementation SupplyList


static SupplyList * manager=nil;

+(SupplyList *)defaultManager
{
    //只调用一次，保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if(manager==nil){
            manager=[[SupplyList alloc]init];
        }
    });
    return manager;
}


- (instancetype)init
{
    if(self=[super init]){
        NSString * path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/supply.db"];
        //很据路径创建表
        _dataBase = [[FMDatabase alloc]initWithPath:path];
        //如果创建成功 打开
        
        if ([_dataBase open]) {
            NSString *createSql = @"create table if not exists supply(ind integer PRIMARY KEY AUTOINCREMENT,supplyName varchar(1024),companyName varchar(1024),position varchar(1024),phone varchar(1024),emailAddress varchar(1024),companyAddress varchar(1024),industryType varchar(1024),companyLogo varchar(1024),otherNote varchar(1024) )";
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
- (void)insertDataModel:(SupplyModel *)model{
    NSString * insertSql = @"insert into supply(supplyName,companyName,position,phone,emailAddress,companyAddress,industryType,companyLogo,otherNote) values(?,?,?,?,?,?,?,?,?)";
    BOOL success=[_dataBase executeUpdate:insertSql,model.supplyName,model.companyName,model.position,model.phone,model.emailAddress,model.companyAddress,model.industryType,model.companyLogo,model.otherNote];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"插入成功");
    }
}

//修改数据
- (void)updateDataModel:(SupplyModel *)model number:(int)number  {
    
    NSString *sql = [NSString stringWithFormat:@"update supply set supplyName = ?, companyName = ?,position = ?, phone = ?, emailAddress = ? ,companyAddress = ? ,industryType = ?, companyLogo = ?,otherNote= ?  where  ind = ?"];
    NSString *str = [NSString stringWithFormat:@"%d",number];
    BOOL success = [_dataBase executeUpdate:sql,model.supplyName,model.companyName,model.position,model.phone,model.emailAddress,model.companyAddress,model.industryType,model.companyLogo,model.otherNote,str];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"修改成功");
    }
}

//查找
- (BOOL)isHasDataIDFromTable:(NSString*)dataId;
{
    NSString * isSql = @"select *from supply where phone =?";
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
    NSString * deleteSql = @"delete from supply where supplyName = ?";
    if ([_dataBase executeUpdate:deleteSql,dataId]) {
        NSLog(@"删除成功");
    }
}


#pragma mark 从创建的数据库中读取所有的值
- (NSArray *)getData{
    
    NSString *resultSql = @"select *from supply";
    FMResultSet * set = [_dataBase executeQuery:resultSql];
    NSMutableArray * arr = [NSMutableArray array];
    while ([set next]) {
        SupplyModel* model = [[SupplyModel alloc]init];
        model.supplyName = [set stringForColumn:@"supplyName"];
        model.companyName = [set stringForColumn:@"companyName"];
        model.position=[set stringForColumn:@"position"];
        model.phone=[set stringForColumn:@"phone"];
        model.emailAddress=[set stringForColumn:@"emailAddress"];
        model.companyAddress = [set stringForColumn:@"companyAddress"];
        model.industryType = [set stringForColumn:@"industryType"];
        model.companyLogo=[set stringForColumn:@"companyLogo"];
        model.otherNote=[set stringForColumn:@"otherNote"];
        model.ind = [set  intForColumn:@"ind" ];
        [arr addObject:model];
    }
    return arr;
}




















@end








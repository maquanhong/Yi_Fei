//
//  CustomerList.m
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CustomerList.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface CustomerList ()
{
    FMDatabase * _dataBase;
}

@end

@implementation CustomerList

static CustomerList * manager=nil;

+(CustomerList *)defaultManager
{
    //只调用一次，保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if(manager==nil){
            manager=[[CustomerList alloc]init];
        }
    });
    return manager;
}


- (instancetype)init
{
    if(self=[super init]){
    NSString * path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Custromer.db"];
        //很据路径创建表
    _dataBase = [[FMDatabase alloc]  initWithPath:path];
        //如果创建成功 打开
    if ([_dataBase open]) {
    NSString *createSql = @"create table if not exists Custromer(ind integer PRIMARY KEY AUTOINCREMENT,customerName varchar(1024),companyName varchar(1024),position varchar(1024),phone varchar(1024),emailAddress varchar(1024),companyAddress varchar(1024),industryType varchar(1024),companyLogo glob(1024),otherNote varchar(1024) )";
        if ([_dataBase executeUpdate:createSql]){
                NSLog(@"创建成功");
            }else{
                NSLog(@"%@",[_dataBase lastErrorMessage]);
            }
        }
    }
    return self;
}

//插入
- (void)insertDataModel:(CustomerModel *)model{
    NSString * insertSql = @"insert into Custromer(customerName,companyName,position,phone,emailAddress,companyAddress,industryType,companyLogo,otherNote) values(?,?,?,?,?,?,?,?,?)";
    BOOL success=[_dataBase executeUpdate:insertSql,model.customerName,model.companyName,model.position,model.phone,model.emailAddress,model.companyAddress,model.industryType,model.companyLogo,model.otherNote];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"插入成功");
    }
}

//修改数据
- (void)updateDataModel:(CustomerModel *)model number:(int)number  {
    
    NSString *sql = [NSString stringWithFormat:@"update Custromer set customerName = ?, companyName = ?,position = ?, phone = ?, emailAddress = ? ,companyAddress = ? ,industryType = ?, companyLogo = ?,otherNote= ?  where  ind = ?"];
    NSString *str = [NSString stringWithFormat:@"%d",number];
    BOOL success = [_dataBase executeUpdate:sql,model.customerName,model.companyName,model.position,model.phone,model.emailAddress,model.companyAddress,model.industryType,model.companyLogo,model.otherNote,str];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"修改成功");
    }
}

//查找
- (BOOL)isHasDataIDFromTable:(NSString*)dataId;
{
    NSString * isSql = @"select *from Custromer where phone =?";
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
    NSString * deleteSql = @"delete from Custromer where phone = ?";
    if ([_dataBase executeUpdate:deleteSql,dataId]) {
        NSLog(@"删除成功");
    }
}


#pragma mark 从创建的数据库中读取所有的值
- (NSArray *)getData{
    
    NSString *resultSql = @"select *from Custromer";
    FMResultSet * set = [_dataBase executeQuery:resultSql];
    NSMutableArray * arr = [NSMutableArray array];
    while ([set next]) {
        CustomerModel* model = [[CustomerModel alloc]init];
        model.customerName = [set stringForColumn:@"customerName"];
        model.companyName = [set stringForColumn:@"companyName"];
        model.position=[set stringForColumn:@"position"];
        model.phone=[set stringForColumn:@"phone"];
        model.emailAddress=[set stringForColumn:@"emailAddress"];
        model.companyAddress = [set stringForColumn:@"companyAddress"];
        model.industryType = [set stringForColumn:@"industryType"];
        model.companyLogo=[set dataForColumn:@"companyLogo"];
        model.otherNote=[set stringForColumn:@"otherNote"];
        model.ind = [set  intForColumn:@"ind" ];
        [arr addObject:model];
    }
    return arr;
}
































@end















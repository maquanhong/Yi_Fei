//
//  UserList.m
//  Yi_Fei
//
//  Created by yons on 16/12/20.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "UserList.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface UserList (){
    FMDatabase * _dataBase;
}

@end

@implementation UserList

static UserList * manager=nil;
+(UserList *)defaultManager
{
    //只调用一次，保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
    if(manager==nil){
    manager=[[UserList alloc]init];
    }
    });
    return manager;
}


- (instancetype)init
{
    if(self=[super init]){
        NSString * path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/User.db"];
        //很据路径创建表
        _dataBase = [[FMDatabase alloc]initWithPath:path];
        //如果创建成功 打开
        if ([_dataBase open]) {
            NSString *createSql = @"create table if not exists User(ind integer PRIMARY KEY AUTOINCREMENT,picture varchar(6000),name varchar(1024),industry varchar(1024),size varchar(1024),business varchar(1024),product varchar(1024),url varchar(1024),adderss varchar(1024),link varchar(1024),phone varchar(1024),email varchar(1024),position varchar(1024))";
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
- (void)insertDataModel:(UserModel *)model{

    NSString * insertSql = @"insert into User(picture,name,industry,size,business,product,url,adderss,link,phone,email,position) values (?,?,?,?,?,?,?,?,?,?,?,?)";
    BOOL success=[_dataBase executeUpdate:insertSql,model.picture,model.name,model.industry,model.size,model.business,model.product,model.url,model.adderss,model.link,model.phone,model.email,model.position];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"插入成功");
    }
}

//修改数据
- (void)updateDataModel:(UserModel*)model data:(NSString*)data {
    NSString *sql = [NSString stringWithFormat:@"update User set picture = ?, name = ?,industry = ?, size = ?, business = ? ,product = ? ,url = ?, adderss = ?,link= ?, phone = ? , email = ? ,position = ?  where  phone = ?"];
    BOOL success = [_dataBase executeUpdate:sql,model.picture,model.name,model.industry,model.size,model.business,model.product,model.url,model.adderss,model.link,model.phone,model.email,model.position,data];
    if (!success) {
        NSLog(@"%@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"修改成功");
    }
}

//查找
- (BOOL)isHasDataIDFromTable:(NSString*)data
{
    NSString * isSql = @"select *from User where phone =?";
    //FMResultSet 查询结果的集合类
    FMResultSet * set = [_dataBase executeQuery:isSql,data];
    //[set next] 查找当前行 找到继续中查找下一行
    if ([set next]) {
        return YES;
    }else{
        return NO;
    }
    return [set next];//next 返回时一个BOOL
}


- (UserModel *)getDataWith:(NSString*)data{
    NSString * resultSql = @"select *from User where phone =?";
    FMResultSet * set = [_dataBase executeQuery:resultSql,data];
    UserModel* model ;
    while ([set next]) {
      model = [[UserModel alloc]init];
        model.picture = [set stringForColumn:@"picture"];
        model.name = [set stringForColumn:@"name"];
        model.industry=[set stringForColumn:@"industry"];
        model.size=[set stringForColumn:@"size"];
        model.business=[set stringForColumn:@"business"];
        model.product = [set stringForColumn:@"product"];
        model.url = [set stringForColumn:@"url"];
        model.adderss=[set stringForColumn:@"adderss"];
        model.link=[set stringForColumn:@"link"];
        model.phone=[set stringForColumn:@"phone"];
        model.email = [set stringForColumn:@"email"];
        model.position = [set stringForColumn:@"position"];
        model.ind = [set  intForColumn:@"ind" ];
    }
      return model;
}





































@end





































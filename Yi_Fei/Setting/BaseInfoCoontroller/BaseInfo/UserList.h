//
//  UserList.h
//  Yi_Fei
//
//  Created by yons on 16/12/20.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserList : NSObject

+(UserList *)defaultManager;

//插入数据
- (void)insertDataModel:(UserModel *)model;

//修改数据
- (void)updateDataModel:(UserModel*)model and:(NSString*)name and:(NSString*)companyName;

//查询数据
- (BOOL)isHasDataIDFrom:(NSString*)name and:(NSString*)companyName;

//根据字段搜索结果
- (UserModel *)getDataName:(NSString*)name and:(NSString*)companyName;


@end
















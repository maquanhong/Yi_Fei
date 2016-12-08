//
//  DBManager.h
//  LoveLife
//
//  Created by 张明军 on 15/12/29.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "shopData.h"


@interface FMDBOneList : NSObject

+(FMDBOneList *)defaultManager;

//插入数据
- (void)insertDataModel:(shopData *)model;

//修改数据
- (void)updateDataModel:(shopData *)model number:(int)number ;

//查询数据
- (BOOL)isHasDataIDFromTable:(NSInteger)dataId;

//删除数据
- (void)deleteNameFromTable:(int )dataId;

//查询所有
- (NSArray *)getData;





@end




























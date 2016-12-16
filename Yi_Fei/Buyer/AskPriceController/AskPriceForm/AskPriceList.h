//
//  AskPriceList.h
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AskPriceModel.h"

@interface AskPriceList : NSObject


+(AskPriceList *)defaultManager;

//插入数据
- (void)insertDataModel:(AskPriceModel *)model;

//修改数据
- (void)updateDataModel:(AskPriceModel *)model number:(int)number ;

//查询数据
- (BOOL)isHasDataIDFromTable:(int)dataId;

//删除数据
- (void)deleteNameFromTable:(int)dataId;

//查询所有
//- (NSArray *)getData;

- (NSArray *)getDataWith:(NSString*)dataId;


@end









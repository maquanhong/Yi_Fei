//
//  NewTwoList.h
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductionData.h"


@interface NewTwoList : NSObject


+(NewTwoList *)newListManager;

//插入数据
- (void)insertDataModel:(ProductionData *)model;

//修改数据
- (void)updateDataModel:(ProductionData *)model number:(int)number;

//查询数据
- (BOOL)isHasDataIDFromTable:(NSString*)dataId;

//删除数据
- (void)deleteNameFromTable:(NSString*)dataId;

//查询所有
- (NSArray *)getData;






@end

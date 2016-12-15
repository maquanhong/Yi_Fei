//
//  SupplyList.h
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SupplyModel.h"

@interface SupplyList : NSObject

+(SupplyList *)defaultManager;

//插入数据
- (void)insertDataModel:(SupplyModel *)model;

//修改数据
- (void)updateDataModel:(SupplyModel *)model number:(int)number ;

//查询数据
- (BOOL)isHasDataIDFromTable:(NSString*)dataId;

//删除数据
- (void)deleteNameFromTable:(NSString*)dataId;

//查询所有
- (NSArray *)getData;





@end






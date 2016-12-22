//
//  TemplateList.h
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateModel.h"

@interface TemplateList : NSObject


+(TemplateList *)defaultManager;

//插入数据
- (void)insertDataModel:(TemplateModel *)model;

//修改数据
- (void)updateDataModel:(TemplateModel *)model number:(int)number ;

//查询数据
- (BOOL)isHasDataIDFromTable:(int)dataId;


//删除数据
- (void)deleteNameFromTable:(int)dataId;

//条件查询
- (NSArray *)getDataWith:(NSString*)dataId;




@end

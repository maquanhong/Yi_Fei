//
//  CustomerProductList.h
//  Yi_Fei
//
//  Created by yons on 16/12/30.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerProductModel.h"

@interface CustomerProductList : NSObject


+(CustomerProductList *)defaultManager;

//插入数据
- (void)insertDataModel:(CustomerProductModel *)model;

//删除
- (void)deleteElement:(NSString*)name and:(NSString*)companyName index:(NSString*)index num:(NSString*)num;

//查询
- (BOOL)isHasElement:(NSString*)name and:(NSString*)companyName productName:(NSString*)productName index:(NSString*)index;


//修改
-(void)updateMolde:(CustomerProductModel *)model Element:(NSString*)name and:(NSString*)companyName  num:(NSString*)num index:(NSString*)index;



/*
  发送过来之后，在客户信息里面进行展示
 */
//根据字段搜索结果
- (NSArray *)getDataName:(NSString*)name and:(NSString*)companyName identify:(NSString*)identify;


//根据字段搜索留样询价
-(NSArray *)getDataName:(NSString*)name and:(NSString*)companyName and:(NSString*)index  identify:(NSString*)identify;


/*
  自己添加的商品,并不是什么发送的
 */

//根据字段搜索询价类型
-(NSArray *)getDataName:(NSString*)name and:(NSString*)companyName and:(NSString*)index;







@end

























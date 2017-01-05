//
//  SupplyComeOut.h
//  Yi_Fei
//
//  Created by yons on 17/1/4.
//  Copyright © 2017年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerProductModel.h"

@interface SupplyComeOut : NSObject

#pragma mark Excel供应商导出
@property (readonly, nonatomic, nonnull) NSString *importFilePath;  //导入的文件路径

@property (readonly, nonatomic, nonnull) NSString *importFileName;   //导入的文件名

-(void)sendToBuyerExcel; // 用来导入的;

#pragma mark 数据源
@property (nonatomic,strong,nonnull) NSArray *objcArray;
@property (nonatomic,copy,nonnull) NSString *offerTime;
@property (nonatomic,copy,nonnull) NSString *companyName;
@property (nonatomic,copy,nonnull) NSString *supplyName;

@property (nonatomic,copy,nonnull) NSString *reverTime;

@property (nonatomic,strong,nonnull) CustomerProductModel *shopObjc;




@end

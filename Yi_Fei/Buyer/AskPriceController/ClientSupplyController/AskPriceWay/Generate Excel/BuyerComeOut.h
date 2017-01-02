//
//  BuyerComeOut.h
//  Yi_Fei
//
//  Created by yons on 16/12/30.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfferPriceModel.h"

@interface BuyerComeOut : NSObject

#pragma mark 导入
@property (readonly, nonatomic, nonnull) NSString *importFilePath;  //导入的文件路径

@property (readonly, nonatomic, nonnull) NSString *importFileName;   //导入的文件名

-(void)sendToSupplyExcel; // 用来导入的;

#pragma mark 数据源
@property (nonatomic,strong,nonnull) NSArray *objcArray;


@property (nonatomic,strong,nonnull) OfferPriceModel *shopObjc;


@end




























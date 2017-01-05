//
//  TranslationObjec.m
//  Yi_Fei
//
//  Created by yons on 16/12/23.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TranslationObjec.h"

@implementation TranslationObjec


-(CustomerProductModel*)trams:(shopData*)model customerName:(NSString*)customerName companyName:(NSString*)companyName index:(NSString*)index{
    
        CustomerProductModel *dataModel = [[CustomerProductModel alloc] init];

        dataModel.companyID = model.companyID;
        dataModel.shopName = model.shopName;
        dataModel.shopSize = model.shopSize;
        dataModel.shopMed = model.shopMed;
        dataModel.shopColor = model.shopColor;
        dataModel.shopPrice = model.shopPrice;
        dataModel.shopDescribe = model.shopDescribe;
        dataModel.shopInfo = model.shopInfo;
        dataModel.shopHuoBi = model.shopHuoBi;
        dataModel.shopTiaoK = model.shopTiaoK;
        dataModel.shopAdderss = model.shopAdderss;
        dataModel.shopCustom = model.shopCustom;
        dataModel.shopContent = model.shopContent;
        dataModel.imageOne = model.imageOne;
        dataModel.imageTwo = model.imageTwo;
        dataModel.imageThree = model.imageThree;
        dataModel.imageFour = model.imageFour;
        dataModel.flag = index;
        dataModel.customerName = customerName;
        dataModel.companyName = companyName;
    return dataModel;
}





















@end



















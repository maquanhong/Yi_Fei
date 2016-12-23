//
//  TranslationObjec.m
//  Yi_Fei
//
//  Created by yons on 16/12/23.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TranslationObjec.h"

@implementation TranslationObjec


-(AskPriceModel*)trams:(shopData*)model type:(NSString*)type customerName:(NSString*)customerName{
    
        AskPriceModel *askModel = [[AskPriceModel alloc] init];
        askModel.companyID = model.companyID;
        askModel.shopName = model.shopName;
        askModel.shopSize = model.shopSize;
        askModel.shopMed = model.shopMed;
        askModel.shopColor = model.shopColor;
        askModel.shopPrice = model.shopPrice;
        askModel.shopHuoBi = model.shopHuoBi;
        askModel.shopTiaoK = model.shopTiaoK;
        askModel.shopAdderss = model.shopAdderss;
        askModel.shopDescribe = model.shopDescribe;
        askModel.shopInfo = model.shopInfo;
        askModel.shopCustom = model.shopCustom;
        askModel.shopContent = model.shopContent;
        askModel.shopPicture = model.shopPicture;
        askModel.cleintName = customerName;
        askModel.record = type;
    
    return askModel;
    
}





















@end



















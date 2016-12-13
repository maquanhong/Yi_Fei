//
//  ConversionTrams.m
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ConversionTrams.h"

@implementation ConversionTrams

-(AskPriceModel*)trams:(ProductionData*)model tag:(NSString *)tag time:(NSString*)time{
    AskPriceModel *askModel = [[AskPriceModel alloc] init];
    askModel.flag = tag;
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
    askModel.time = time;
    return askModel;
}






@end







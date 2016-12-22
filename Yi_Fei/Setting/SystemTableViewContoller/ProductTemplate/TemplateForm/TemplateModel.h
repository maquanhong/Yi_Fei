//
//  TemplateModel.h
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemplateModel : NSObject


@property (nonatomic, copy) NSString *companyID; //公司货号

@property (nonatomic, copy) NSString *shopName;  //商品名称

@property (nonatomic, copy) NSString *shopPrice;  //商品的价格

@property (nonatomic, copy) NSString *shopMed;  //商品材质

@property (nonatomic, copy) NSString *shopColor;  //商品的颜色



@property (nonatomic, copy) NSString *sizeUnit;  //尺寸单位
@property (nonatomic, copy) NSString *HeightUnit;  //重量单位

@property (nonatomic, copy) NSString *shopSize;  //商品尺寸
@property (nonatomic, copy) NSString *shopHeight;  //商品重量


@property (nonatomic, copy) NSString *shopNumOne;  //外箱包装 数量
@property (nonatomic, copy) NSString *shopHeightOne;  //外箱包装 数量
@property (nonatomic, copy) NSString *shopSizeOne;  //外箱包装 数量


@property (nonatomic, copy) NSString *shopNumTwo;  //外箱包装 数量
@property (nonatomic, copy) NSString *shopHeightTwo;  //外箱包装 数量
@property (nonatomic, copy) NSString *shopSizeTwo;  //外箱包装 数量



@property (nonatomic, copy) NSString *shopHuoBi;  //货币

@property (nonatomic, copy) NSString *shopTiaoK;  //条款

@property (nonatomic, copy) NSString *shopPicture;  //条款

@property (nonatomic, copy) NSString *customeTile;  //自定义标题
@property (nonatomic, copy) NSString *customeContent;  //自定义内容

@property (nonatomic, copy) NSString *shopAddress;  //码头地址











@end

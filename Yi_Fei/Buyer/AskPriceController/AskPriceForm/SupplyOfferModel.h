//
//  SupplyOfferModel.h
//  Yi_Fei
//
//  Created by yons on 17/1/4.
//  Copyright © 2017年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupplyOfferModel : NSObject


//对象属性

@property (nonatomic, assign) int ind;

@property (nonatomic, copy) NSString *flag;    //询价类型

@property (nonatomic, copy) NSString *companyID; //公司货号
@property (nonatomic, copy) NSString *shopName;  //商品名称
@property (nonatomic, copy) NSString *shopSize;  //商品尺寸
@property (nonatomic, copy) NSString *shopMed;  //商品材质

@property (nonatomic, copy) NSString *shopColor;  //商品的颜色
@property (nonatomic, copy) NSString *shopPrice;  //商品的价格
@property(nonatomic,copy)NSString *shopHuoBi;    //货币类型
@property(nonatomic,copy)NSString *shopTiaoK;    //货币条款
@property(nonatomic,copy)NSString *shopAdderss;  //码头地址

@property (nonatomic, copy) NSString *shopDescribe;//商品备注
@property (nonatomic, copy) NSString *shopInfo;  //商品简介

@property(nonatomic,copy)NSString *shopCustom;  //自定义的商品类型
@property(nonatomic,copy)NSString *shopContent; //自定义的商品内容

@property (nonatomic, strong ) NSData *imageOne; //上传图片
@property (nonatomic, strong) NSData *imageTwo; //上传图片
@property (nonatomic, strong) NSData *imageThree; //上传图片
@property (nonatomic, strong) NSData *imageFour; //上传图片


@property (nonatomic, copy) NSString *time;       //预留时间
@property (nonatomic, copy) NSString *count;      //数量
@property (nonatomic, copy) NSString *supplyName;  //供应商姓名

@property (nonatomic, copy) NSString *shopSpecific;  //规格

@property (nonatomic, copy) NSString *offerTime;  //询价时间

@property (nonatomic, copy) NSString *companyName;  //客户公司

@property (nonatomic, copy) NSString *identify;  //判断是发送的还是添加的










@end

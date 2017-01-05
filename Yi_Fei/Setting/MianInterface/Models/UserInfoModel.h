//
//  UserInfoModel.h
//  Yi_Fei
//
//  Created by 徐友明 on 16/12/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

//公司名称
@property (nonatomic,strong)NSString *companyName;
//公司规模
@property (nonatomic,strong)NSString *companySize;
//联系电话
@property (nonatomic,strong)NSString *contactPhone;
//邮箱地址
@property (nonatomic,strong)NSString *email;
//行业类型
@property (nonatomic,strong)NSString *industryType;
//公司logo
@property (nonatomic,strong)NSString *logo;
//主要业务
@property (nonatomic,strong)NSString *mainBussiness;
//主要产品
@property (nonatomic,strong)NSString *mainProduct;
//vip等级
@property (nonatomic,strong)NSString *vipLevel;
//vip类型
@property (nonatomic,strong)NSString *vipType;
//网站
@property (nonatomic,strong)NSString *website;
//工作职位
@property (nonatomic,strong)NSString *jobTitle;
//联系人
@property (nonatomic,strong)NSString *contactPerson;
//地址
@property (nonatomic,strong)NSString *address;


@end

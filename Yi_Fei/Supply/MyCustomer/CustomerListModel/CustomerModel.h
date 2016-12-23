//
//  CustomerModel.h
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerModel : NSObject


@property (nonatomic, assign) int ind;

@property (nonatomic, copy) NSString *customerName;  //姓名

@property (nonatomic, copy) NSString *companyName; //公司名称

@property (nonatomic, copy) NSString *position;   //职位

@property (nonatomic, copy) NSString *phone;  //电话

@property (nonatomic, copy) NSString *emailAddress;  //邮箱

@property (nonatomic, copy) NSString *companyAddress;  //公司地址

@property (nonatomic, copy) NSString *industryType;  //行业类型

@property (nonatomic, copy) NSString *companyLogo;  //公司的logo

@property (nonatomic, copy) NSString *otherNote;  //备注





@end




















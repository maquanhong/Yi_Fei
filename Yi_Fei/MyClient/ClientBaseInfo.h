//
//  ClientBaseInfo.h
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/8.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "GYModelObject.h"

@interface ClientBaseInfo : GYModelObject
@property (nonatomic, strong, readonly) NSString  *clientId;
@property (nonatomic, strong, readonly) NSString  *company;
@property (nonatomic, strong, readonly) NSString  *telphone;
@property (nonatomic, strong, readonly) NSString  *email;
@property (nonatomic, strong, readonly) NSString  *companyAddress;
@property (nonatomic, strong, readonly) NSString  *jobType;
@end

//
//  ExibitionModel.h
//  Yi_Fei
//
//  Created by 徐友明 on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
//xym
@interface ExibitionModel : NSObject
//地址
@property (nonatomic,strong) NSString *address;
//收费标准
@property (nonatomic,strong) NSString *chargeStandard;
//城市
@property (nonatomic,strong) NSString *city;
//联系
@property (nonatomic,strong) NSString *contact;
//结束时间
@property (nonatomic,strong) NSNumber *endTime;
//每条信息的id
@property (nonatomic,strong) NSNumber *Id;
//介绍
@property (nonatomic,strong) NSString *introduction;
//组织者
@property (nonatomic,strong) NSString *organiser;
//馆名
@property (nonatomic,strong) NSString *pavilionName;
//范围
@property (nonatomic,strong) NSString *range;
//开始时间
@property (nonatomic,strong) NSNumber *startTime;
//状态
@property (nonatomic,strong) NSString *state;
//联系电话
@property (nonatomic,strong) NSString *telephone;
//标题
@property (nonatomic,strong) NSString *title;
//类型
@property (nonatomic,strong) NSString *type;

@end

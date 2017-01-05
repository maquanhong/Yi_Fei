//
//  AboutModel.h
//  Yi_Fei
//
//  Created by 徐友明 on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>

//xym
@interface AboutModel : NSObject

//客户服务
@property(nonatomic,strong)NSString *customerService;

//功能介绍
@property(nonatomic,strong)NSString *functionIntro;

//最新版本号
@property(nonatomic,strong)NSString *lastVersion;

//隐私
@property(nonatomic,strong)NSString *privacyPolicy;

//检查版本更新
@property(nonatomic,strong)NSString *sysInform;


@end

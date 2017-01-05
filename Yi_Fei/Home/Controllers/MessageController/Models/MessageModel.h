//
//  MessageModel.h
//  Yi_Fei
//
//  Created by 徐友明 on 16/12/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
//xym
@interface MessageModel : NSObject
//接收时间
@property (nonatomic,strong)NSNumber *acceptTime;
//创建时间
@property (nonatomic,strong)NSNumber *createTime;
//消息的id
@property (nonatomic,strong)NSNumber *messageId;
//读取时间
@property (nonatomic,strong)NSNumber *readTime;
//内容
@property (nonatomic,strong)NSString *content;
//已读状态
@property (nonatomic,strong)NSString *hasReadState;
//标题
@property (nonatomic,strong)NSString *title;
//类型
@property (nonatomic,strong)NSString *type;



@end

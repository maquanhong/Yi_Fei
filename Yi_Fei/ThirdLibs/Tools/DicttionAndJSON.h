//
//  DicttionAndJSON.h
//  字典与字符串的相互转换
//
//  Created by yons on 16/12/20.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DicttionAndJSON : NSObject

//字典转json格式字符串：
- (NSString*)dictionaryToJson:(NSDictionary *)dic;


//json格式字符串转字典：
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;






@end


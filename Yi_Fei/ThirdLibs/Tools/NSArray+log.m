//
//  NSArray+log.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "NSArray+log.h"

@implementation NSArray (log)



- (NSString *)descriptionWithLocale:(id)locale
 {
      NSMutableString *string = [NSMutableString string];

     // 开头有个[
         [string appendString:@"[\n"];
    
         // 遍历所有的元素
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
               [string appendFormat:@"\t%@,\n", obj];
          }];
 
     // 结尾有个]
     [string appendString:@"]"];
 
     // 查找最后一个逗号
     NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
       if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
     
      return string;
 }





@end

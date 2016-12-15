//
//  userDefaultManager.h
//  GYKuaidi
//
//  Created by yons on 15/12/30.
//  Copyright © 2015年 x5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultManager : NSObject

//存数据
+ (void)saveDataWithValue:(id)data key:(NSString *)key;

//取数据
+ (id)getDataByKey:(NSString *)key;
//删除数据
+(void)removeDataWithKey:(NSString*)key;

@end

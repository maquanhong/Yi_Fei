//
//  userDefaultManager.m
//  GYKuaidi
//
//  Created by yons on 15/12/30.
//  Copyright © 2015年 x5. All rights reserved.
//

#import "UserDefaultManager.h"

@implementation UserDefaultManager

+ (void)saveDataWithValue:(id)data key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (id)getDataByKey:(NSString *)key
{
    id data = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    return data;
}

+(void)removeDataWithKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end

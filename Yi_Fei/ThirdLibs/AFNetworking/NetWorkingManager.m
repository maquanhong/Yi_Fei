//
//  NetWorkingManager.m
//  Health management
//
//  Created by yons on 16/8/8.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "NetWorkingManager.h"

@interface NetWorkingManager()

@end



@implementation NetWorkingManager
  static NetWorkingManager *manager=nil;
+(NetWorkingManager *)shareManager{
  
    if (manager==nil) {
       manager = [[self alloc] init];
    }
    return manager;
}
+(AFHTTPRequestOperationManager *)getManager{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.requestSerializer.timeoutInterval = 20.f;
    NSSet *postCurrentAcceptSet = manager.responseSerializer.acceptableContentTypes;
    NSMutableSet *mset = [NSMutableSet setWithSet:postCurrentAcceptSet];
    [mset addObject:@"text/html"];
    [mset addObject:@"text/plain"];
    manager.responseSerializer.acceptableContentTypes = mset;
    return manager;
}







@end
















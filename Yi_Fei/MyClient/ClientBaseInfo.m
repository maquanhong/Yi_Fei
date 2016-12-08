//
//  ClientBaseInfo.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/8.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ClientBaseInfo.h"

@implementation ClientBaseInfo
+ (NSString *)dbName {
    return @"addYiFei.db";
}

+ (NSString *)tableName {
    return @"client";
}

+ (NSString *)primaryKey {
    return @"clientId";
}
+ (NSArray *)persistentProperties {
    static NSArray *properties = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        properties = @[
                       @"clientId",
                       @"company",
                       @"telphone",
                       @"email",
                       @"companyAddress",
                       @"jobType"
                       ];
    });
    return properties;
}

- (BOOL)isEqual:(id)object {
    ClientBaseInfo *other = (ClientBaseInfo *)object;
    
    if (self.clientId != other.clientId) {
        return NO;
    }
    
    return YES;
}

@end

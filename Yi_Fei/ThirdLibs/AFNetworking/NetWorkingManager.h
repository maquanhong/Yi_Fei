//
//  NetWorkingManager.h
//  Health management
//
//  Created by yons on 16/8/8.
//  Copyright © 2016年 yous. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetWorkingManager : NSObject


+(NetWorkingManager *)shareManager;

+(AFHTTPRequestOperationManager*)getManager;



@end

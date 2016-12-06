//
//  PeripheralBlueTooth.h
//  BlueToothText
//
//  Created by yons on 16/12/5.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeripheralBlueTooth : NSObject


+(instancetype)shareManager;

@property (nonatomic,copy) NSString *path;

@end

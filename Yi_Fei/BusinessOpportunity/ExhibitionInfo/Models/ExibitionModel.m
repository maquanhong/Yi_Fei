//
//  ExibitionModel.m
//  Yi_Fei
//
//  Created by 徐友明 on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ExibitionModel.h"

@implementation ExibitionModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"]){
        self.Id = value;
    }
    
}







@end

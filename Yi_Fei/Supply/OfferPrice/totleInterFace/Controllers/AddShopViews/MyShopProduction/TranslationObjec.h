//
//  TranslationObjec.h
//  Yi_Fei
//
//  Created by yons on 16/12/23.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "shopData.h"
#import "CustomerProductModel.h"

@interface TranslationObjec : NSObject


-(CustomerProductModel*)trams:(shopData*)model customerName:(NSString*)customerName companyName:(NSString*)companyName index:(NSString*)index;


@end

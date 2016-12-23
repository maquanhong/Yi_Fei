//
//  TranslationObjec.h
//  Yi_Fei
//
//  Created by yons on 16/12/23.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "shopData.h"
#import "AskPriceModel.h"

@interface TranslationObjec : NSObject


-(AskPriceModel*)trams:(shopData*)model type:(NSString*)type customerName:(NSString*)customerName;



@end

//
//  IndustryModel.h
//  Yi_Fei
//
//  Created by yons on 16/12/15.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndustryModel : NSObject


//获取全部行业第一级
-(NSMutableArray*)getAllIndustry;

-(NSString*)getAllIndustry:(NSInteger)number;

-(NSString*)getAllIndustryTwo:(NSInteger)number;

//获取全部行业第二级
-(NSMutableArray*)getIndustryTwo:(NSInteger)number;

-(NSString*)getIndustryTwo:(NSInteger)number threeNumber:(NSInteger)threeNumber;


//获取全部行业第三级
-(NSMutableArray*)getIndustryNumber:(NSInteger)number threeNumber:(NSInteger)threeNumber;









@end








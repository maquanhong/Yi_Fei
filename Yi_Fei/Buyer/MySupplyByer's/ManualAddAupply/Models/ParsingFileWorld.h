//
//  ParsingFileWorld.h
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParsingFileWorld : NSObject

//选择国家返回后续的
-(NSMutableArray *)ParsingXMLOne;//返回国家

-(NSString *)ParsingXMLTwoNumber:(NSInteger)number;//返回省份

-(NSString *)ParsingXMLThreeNumber:(NSInteger)number; //返回市区
-(NSString *)ParsingXMLFourNumber:(NSInteger)number; //返回市区



//选择省份返回后续的
-(NSMutableArray *)ParsingXMLPrivce:(NSInteger)number;//返回省

-(NSString *)ParsingXMLCity:(NSInteger)number numberOne:(NSInteger)numberOne;//返回市区

-(NSString *)ParsingXMLCounty:(NSInteger)number numberOne:(NSInteger)numberOne;//返回市区



//返回市区
-(NSMutableArray*)ParsingXMLCity:(NSInteger)number numberTwo:(NSInteger)numberTwo;

-(NSString *)ParsingXMLCounty:(NSInteger)number numberOne:(NSInteger)numberOne numberThree:(NSInteger)numberThree;//返回市区

//得到县
-(NSMutableArray *)ParsingXMLCounty:(NSInteger)number number:(NSInteger)numberOne number:(NSInteger)numberThree;



@end




























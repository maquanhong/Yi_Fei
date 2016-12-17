//
//  ParsingFileWorld.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ParsingFileWorld.h"

@implementation ParsingFileWorld


//点击国家后显示后面的
-(NSMutableArray*)ParsingXMLOne{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray  *elementArray= [rootElement children];
    NSMutableArray  *countryArray = [NSMutableArray array];
    for (NSInteger i = 0 ; i < elementArray.count; i++) {
    GDataXMLElement *oneElement = [elementArray objectAtIndex:i];
    GDataXMLNode *oneNode = [oneElement attributeForName:@"Name"];
    [countryArray addObject:[oneNode stringValue]];
   }
    
    //国家的
    return countryArray;
}


-(NSString *)ParsingXMLTwoNumber:(NSInteger)number{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray  *elementArray= [rootElement children];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
    //省份的
    NSArray *two = [oneElement children];
    GDataXMLElement *twoElement = [two objectAtIndex:0];
    GDataXMLNode *twoNode = [twoElement attributeForName:@"Name"];
    return [twoNode stringValue];
}


- (NSString *)ParsingXMLThreeNumber:(NSInteger)number{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray  *elementArray= [rootElement children];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];

    //省
    NSArray *two = [oneElement children];
    GDataXMLElement *twoElement = [two objectAtIndex:0];
    //区
    NSArray *three = [twoElement children];
    GDataXMLElement *threeElement = [three objectAtIndex:0];
    GDataXMLNode *threeNode = [threeElement attributeForName:@"Name"];
    return [threeNode stringValue];
}

-(NSString *)ParsingXMLFourNumber:(NSInteger)number{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray  *elementArray= [rootElement children];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
    
    //省
    NSArray *two = [oneElement children];
    GDataXMLElement *twoElement = [two objectAtIndex:0];
    //区
    NSArray *three = [twoElement children];
    GDataXMLElement *threeElement = [three objectAtIndex:0];
    
    //县
    NSArray *four = [threeElement children];
        GDataXMLElement *fourElement = [four objectAtIndex:0];
        GDataXMLNode *fourNode = [fourElement attributeForName:@"Name"];
    return [fourNode stringValue];
}




















//省份
-(NSMutableArray *)ParsingXMLPrivce:(NSInteger)number{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray  *elementArray= [rootElement children];
    NSMutableArray  *proviceArray = [NSMutableArray array];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
        NSArray *two = [oneElement children];
        for (NSInteger j = 0; j < two.count; j++) {
            GDataXMLElement *twoElement = [two objectAtIndex:j];
            GDataXMLNode *twoNode = [twoElement attributeForName:@"Name"];
            [proviceArray addObject:[twoNode stringValue]];
        }
    return proviceArray;
}


-(NSString *)ParsingXMLCity:(NSInteger)number numberOne:(NSInteger)numberOne{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray  *elementArray= [rootElement children];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
    NSArray *two = [oneElement children];
    GDataXMLElement *twoElement = [two objectAtIndex:numberOne];
    NSArray *three = [twoElement children];
    GDataXMLElement *threeElement = [three objectAtIndex:0];
    GDataXMLNode *threeNode = [threeElement attributeForName:@"Name"];
    return [threeNode stringValue];
}


-(NSString *)ParsingXMLCounty:(NSInteger)number numberOne:(NSInteger)numberOne{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray  *elementArray= [rootElement children];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
    NSArray *two = [oneElement children];
    GDataXMLElement *twoElement = [two objectAtIndex:numberOne];
    NSArray *three = [twoElement children];
    GDataXMLElement *threeElement = [three objectAtIndex:0];
    NSArray *four = [threeElement children];
    GDataXMLElement *fourElement = [four objectAtIndex:0];
    GDataXMLNode *fourNode = [fourElement attributeForName:@"Name"];
    
    return [fourNode stringValue];
    
}




//市区
-(NSMutableArray*)ParsingXMLCity:(NSInteger)number numberTwo:(NSInteger)numberTwo{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray  *elementArray= [rootElement children];
    

    NSMutableArray  *cityArray = [NSMutableArray array];
        GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
        NSArray *two = [oneElement children];
        GDataXMLElement *twoElement = [two objectAtIndex:numberTwo];
        NSArray *three = [twoElement children];
        for (NSInteger n = 0; n < three.count; n++) {
            GDataXMLElement *threeElement = [three objectAtIndex:n];
            GDataXMLNode *threeNode = [threeElement attributeForName:@"Name"];
            [cityArray addObject:[threeNode stringValue]];
        }
    return cityArray;
}


-(NSString *)ParsingXMLCounty:(NSInteger)number numberOne:(NSInteger)numberOne numberThree:(NSInteger)numberThree{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray  *elementArray= [rootElement children];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
    NSArray *two = [oneElement children];
    GDataXMLElement *twoElement = [two objectAtIndex:numberOne];
    NSArray *three = [twoElement children];
    GDataXMLElement *threeElement = [three objectAtIndex:numberThree];
    NSArray *four = [threeElement children];
    GDataXMLElement *fourElement = [four objectAtIndex:0];
    GDataXMLNode *fourNode = [fourElement attributeForName:@"Name"];
    
    return [fourNode stringValue];
}




-(NSMutableArray *)ParsingXMLCounty:(NSInteger)number number:(NSInteger)numberOne number:(NSInteger)numberThree{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray  *elementArray= [rootElement children];
    NSMutableArray  *countyArray = [NSMutableArray array];

        GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
        NSArray *two = [oneElement children];
        GDataXMLElement *twoElement = [two objectAtIndex:numberOne];
        NSArray *three = [twoElement children];
        GDataXMLElement *threeElement = [three objectAtIndex:numberThree];
        NSArray *four = [threeElement children];
        for (NSInteger m = 0; m < four.count; m++) {
            GDataXMLElement *fourElement = [four objectAtIndex:m];
            GDataXMLNode *fourNode = [fourElement attributeForName:@"Name"];
            [countyArray addObject:[fourNode stringValue]];
        }
  return countyArray;
}





















@end






































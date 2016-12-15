//
//  IndustryModel.m
//  Yi_Fei
//
//  Created by yons on 16/12/15.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "IndustryModel.h"

@implementation IndustryModel

-(NSMutableArray*)getAllIndustry{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"industry" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
   NSArray *elementArray= [rootElement children];
    NSMutableArray *totleArray = [NSMutableArray array];

    for (NSInteger i = 0 ; i < elementArray.count; i++) {
        GDataXMLElement *oneElement = [elementArray objectAtIndex:i];
        GDataXMLNode *oneNode = [oneElement attributeForName:@"Name"];
        [totleArray addObject:[oneNode stringValue]];
    }
    return totleArray;
}


-(NSString*)getAllIndustry:(NSInteger)number{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"industry" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray *elementArray= [rootElement children];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
    NSArray *two = [oneElement children];
    GDataXMLElement *twoElement = [two objectAtIndex:0];
    GDataXMLNode *twoNode = [twoElement attributeForName:@"Name"];
    return [twoNode stringValue];
}

-(NSString*)getAllIndustryTwo:(NSInteger)number{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"industry" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray *elementArray= [rootElement children];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
    NSArray *two = [oneElement children];
    GDataXMLElement *twoElement = [two objectAtIndex:0];
    NSArray *three = [twoElement children];
    GDataXMLElement *threeElement = [three objectAtIndex:0];
    GDataXMLNode *threeNode = [threeElement attributeForName:@"Name"];
    return [threeNode stringValue];
}






-(NSMutableArray*)getIndustryTwo:(NSInteger)number{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"industry" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray *elementArray= [rootElement children];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
    //进行第二轮解析
    NSMutableArray *twoArray = [NSMutableArray array];
    NSArray *two = [oneElement children];
    for (NSInteger i = 0; i < two.count; i++) {
    GDataXMLElement *twoElement = [two objectAtIndex:i];
    GDataXMLNode *twoNode = [twoElement attributeForName:@"Name"];
    [twoArray addObject:[twoNode stringValue]];
    }
    return twoArray;
}


-(NSString*)getIndustryTwo:(NSInteger)number threeNumber:(NSInteger)threeNumber{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"industry" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray *elementArray= [rootElement children];

    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
    NSArray *two = [oneElement children];
    GDataXMLElement *twoElement = [two objectAtIndex:threeNumber];
    NSArray *three = [twoElement children];
    GDataXMLElement *threeElement = [three objectAtIndex:0];
    GDataXMLNode *threeNode = [threeElement attributeForName:@"Name"];
    
    return [threeNode stringValue];
}



-(NSMutableArray*)getIndustryNumber:(NSInteger)number threeNumber:(NSInteger)threeNumber{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"industry" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray *elementArray= [rootElement children];
    NSMutableArray *arry = [NSMutableArray array];
    GDataXMLElement *oneElement = [elementArray objectAtIndex:number];
    NSArray *two = [oneElement children];
    GDataXMLElement *twoElement = [two objectAtIndex:threeNumber];
    NSArray *three = [twoElement children];
    for (NSInteger i = 0; i < three.count; i++) {
        GDataXMLElement *threeElement = [three objectAtIndex:i];
        GDataXMLNode *threeNode = [threeElement attributeForName:@"Name"];
        [arry addObject:[threeNode stringValue]];
    }
    return arry;
}







@end

































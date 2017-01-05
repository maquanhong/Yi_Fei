//
//  DataSecurity.m
//  TestDataSecurity
//
//  Created by 陈清源 on 16/5/18.
//  Copyright © 2016年 cq. All rights reserved.
//

#import "DataSecurity.h"

static DataSecurity *dataSecurity = nil;

@implementation DataSecurity


#pragma mark --- 单例 ---
+ (DataSecurity *)shareInstance
{
    @synchronized(self) {
        if (dataSecurity == nil) {
            dataSecurity = [[DataSecurity alloc] init];
        }
    }
    return dataSecurity;
}

/**********
 
 以下是对加密/解密操作的方法
 
 **********/

#pragma mark --- MD5对字符串的加密 ---
// 使用方法 传入想要加密的字符串 返回该字符串进行MD5加密之后的字符串
- (NSString *)MD5WithString:(NSString *)string
{
    // 1.对MD5的加密 必须输对C语言字符串 所以我们要先将OC字符串 转化成C语言字符串
    const char *strUTF = string.UTF8String;
    
    // 2.创建字符数组接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    // 3.计算MD5值 最终字符串通过MD5加密的值 会被存储到result数组当中
    CC_MD5(strUTF, (CC_LONG)strlen(strUTF), result);
    
    // 4.定义一个字符串 通过拼接 接收MD5加密之后的值
    NSMutableString *MD5String = [NSMutableString string];
    
    // 5.通过循环 对MD5加密的值 进行逐个字符拼接到字符串中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [MD5String appendFormat:@"%02X", result[i]];
    }
    return MD5String;
}

#pragma mark --- 对复杂对象进行加密 ---
// 必须先将对象 转化成 data 然后对data进行MD5加密 返回复杂对象加密后的字符串
- (NSString *)MD5WithData:(NSData *)data
{
    // 1.创建MD5变量
    CC_MD5_CTX md5;
    // 2.对MD5变量进行初始化
    CC_MD5_Init(&md5);
    // 3.对MD5加密进行准备
    CC_MD5_Update(&md5, data.bytes, (CC_LONG)strlen(data.bytes));
    // 4.创建字符串数组 接收MD5值
    unsigned char result [CC_MD5_DIGEST_LENGTH];
    // 5.定义一个字符串 用于接收MD5值
    NSMutableString *MD5String = [NSMutableString string];
    // 6.通过循环 对MD5加密的值 进行逐个字符拼接到字符串
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [MD5String appendFormat:@"%02X", result[i]];
    }
    return MD5String;
}







#pragma mark --- 复杂对象（单一Model数据模型）的归档 ---
- (NSData *)archiverModel:(id)model modelKey:(NSString *)modelKey
{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:model forKey:modelKey];
    [archiver finishEncoding];
    return data;
}

#pragma mark -- 复杂对象（单独Model）反归档 ---
// 传入归档model写入文件的路径 返回该model  要通过model对象 得到model归档时的key值
- (id)unArchiverModelWithFilePath:(NSString *)filePath modelKey:(NSString *)modelKey
{
    // 2.从路径中获取数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // 3.创建反归档对象
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    // 4.进行对model的反归档读取
    id model = [unArchiver decodeObjectForKey:modelKey];
    return model;
}




@end

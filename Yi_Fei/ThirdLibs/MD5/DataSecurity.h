//
//  DataSecurity.h
//  TestDataSecurity
//
//  Created by 陈清源 on 16/5/18.
//  Copyright © 2016年 cq. All rights reserved.
//

#import <Foundation/Foundation.h>
// 苹果系统自带的MD5加密 若想使用MD5加密 需要引入该系统头文件
#import <CommonCrypto/CommonCrypto.h>

// KeychainItemWrapper.h 针对于钥匙串加密 和 钥匙串解密 的第三方 MRC类 若工程是ARC 需要设置此类支持MRC
//#import "KeychainItemWrapper.h"

// RSA.h 针对于RSA加密 和 RSA解密 的第三方 MRC类 若工程是ARC 需要设置此类支持MRC

@interface DataSecurity : NSObject
/*
 注意：此类专门负责对数据的加密 此类的封装 是基于上面三个头文件的引用
 一、加密 / 解密功能
 1.MD5对字符串进行加密 传入字符串
 2.MD5对复杂对象Model进行加密 传入Model
 3.MD5对象复杂对象装载Model的数组进行加密 传入数组
 4.RSA加密 传入字符串
 5.RSA解密 传入被RSA加密的字符串
 
 二、沙盒文件管理操作功能
 1.Model归档 传入Model 以及 key值
 2.反归档Model 传入文档名称 以及 key值
 3.数组归档 传入数组 以及key值
 4.反归档数组 传入文档名称 以及key值
 
 三、创建/获取 文件夹 和 文档的功能
 1.传入文件夹名称在Documents/Caches创建或者获取文件夹整体路径的的功能
 2传入文档名称在Documents/Caches创建或者获取文档整体路径的功能
 */



#pragma mark --- 单例 ---
+ (DataSecurity *)shareInstance;


/**********
 
 以下是对加密/解密操作的方法
 
 **********/

#pragma mark --- MD5对字符串的加密 ---
// 传入想要加密的字符串 返回该字符串进行MD5加密之后的字符串
- (NSString *)MD5WithString:(NSString *)string;

#pragma mark --- 对复杂对象进行加密 ---
// 必须先将对象 转化成 data 然后对data进行MD5加密 返回复杂对象加密后的字符串
- (NSString *)MD5WithData:(NSData *)data;




/**********
 
 以下是归档反归档的操作方法
 
 **********/
#pragma mark --- 复杂对象（单独Model）归档 ---
// 传入model 进行归档 返回model的NSData
- (NSData *)archiverModel:(id)model modelKey:(NSString *)modelKey;

#pragma mark -- 复杂对象（单独Model）反归档 ---
// 传入归档model写入文件的路径 返回该model 后面传入model对象 要通过model对象 得到model归档时的key值
- (id)unArchiverModelWithFilePath:(NSString *)filePath modelKey:(NSString *)modelKey;






@end

//
//  Header.h
//  Yi_Fei
//
//  Created by yons on 16/11/25.
//  Copyright © 2016年 Practice. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define BussinessCellHeight     51
#define NextStepBtnTopGap       10
#define LabelHeight             25
#define LabelWidth              60
#define CellLeading             30


typedef NS_ENUM(NSInteger, BussiniessChanceType) {
    BussiniessChanceBuy,
    BussiniessChanceSale
};




//支付设置
#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif

//支付宝支付参数
//合作身份者id，以2088开头的16位纯数字
#define PARTNER    @"2088611922925773"
//收款支付宝账号
#define SELLER     @"crg__ok@126.com"

//支付宝公钥
#define AlipayPubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDXxDhrhw8kras3rbt+4DtC8cvbnAlaU97e6GqP6GB8nkCISOLMbu3Z020nbEdwyoJR4PvbDWyL7m8cXiz7346xfy75MtLGCBgUWMkF0G/pMDqtHcKhxr6jeBT9RMCOvQn0D/2tif8+A9LLRf4bb+AduHcWoO5sWSCiySb8LLVG5wIDAQAB"

//商户私钥，自助生成
#define PartnerPrivKey  @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANfEOGuHDyStqzetu37gO0Lxy9ucCVpT3t7oao/oYHyeQIhI4sxu7dnTbSdsR3DKglHg+9sNbIvubxxeLPvfjrF/Lvky0sYIGBRYyQXQb+kwOq0dwqHGvqN4FP1EwI69CfQP/a2J/z4D0stF/htv4B24dxag7mxZIKLJJvwstUbnAgMBAAECgYEAtVsDhTXPP6gNqs4HM3xrszgjfiIoJlkqkjfOIclTGEu3uBVzNBvlJdq0+5bicWZ1pTay2ors+qzdjX2G1+ovN2x9ZIZyVDL0P1CqgzwEu7hCIC5I/hlcMIux+h0U93stRxeimdCcbj2hCfzewE77hP4GQ6F4llzgDtvm9X41CYkCQQDy+63bcv7huWydUOuN7ObhOTAjoAe5SxJL89UkFkMGwJYqUm2cRNAkaJ3OPBBBXEeDpBjh323L6g0pUnM6q32lAkEA41NJY+GAXVUAWnAKNJHfXEi3XopnStsPRRL6gRCqTcceWEicq6CtyHEIxJuldiG0AP2u+Fh5faWx4phXKFEkmwJAFdGt2f/ojWJ2M2Y50MPOM7lL7lcHeocYPIPHxvbMzAVtNp2yRA8V1b8jNIrGNuhPb63DojzLAj2hMu25dTJDFQJAFi24CVCk73YtlKU9uadJvX0ytryWG02IDdsuKY1wsCnvIfnjnzMMAXRVwKjW2dGr+DTH717ia4nQ8ySdzEcuZQJAf1aGvpNuRP9Sf043ymPbhBVEb2bji6ltOr9R1VpCuaojP/EAYEAanzHLvcG+kc0QAk57+7hWp3smNQu+aYt1oQ=="









//微信支付参数






























#endif /* Header_h */

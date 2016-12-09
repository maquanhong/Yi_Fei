//
//  SupplyOutForm.h
//  Yi_Fei
//
//  Created by yons on 16/12/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

@import Foundation;

@interface SupplyOutForm : NSObject

#pragma mark 导出
@property (readonly, nonatomic, nonnull) NSString *outputFileName;  //导出的文件名
@property (readonly, nonatomic, nonnull) NSString *outputFilePath;  //导出的文件路径
- (void)outExportExcel; //导出来给客户看的;
@property (nonatomic,strong,nonnull) shopData *shopObjc;


@end





//
//  SupplyImport.m
//  Yi_Fei
//
//  Created by yons on 16/12/6.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//
#import <libxlsxwriter/xlsxwriter.h>
#import "SupplyImport.h"

static NSString * const kFileExtension = @"xls";

@implementation SupplyImport

#pragma mark 导入的文件路径
- (NSString *)importFilePath {
    
    NSAssert(self.importFileName, @"outputFileName needs to be overridden in subclasses");
    
    NSString *documentsFolderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [[documentsFolderPath stringByAppendingPathComponent:self.importFileName] stringByAppendingPathExtension:kFileExtension];
    
    return filePath;
}

#pragma mark 导出的文件名
- (NSString *)importFileName {
    return @"ImportPrice";
}

 
 //导入数据用的
 -(void)importExcel{
 
 //设置保存路径
 lxw_workbook  *workbookTwo   = workbook_new([self.importFilePath fileSystemRepresentation]);
 //创建Excel表格
 lxw_worksheet *worksheet = workbook_add_worksheet(workbookTwo, "ImportPrice");
 //设置表格的格式
 lxw_format *custom = workbook_add_format(workbookTwo);
 format_set_border(custom, LXW_BORDER_THIN); //设置边框
 format_set_border(custom, LXW_BORDER_THIN); //设置边框
 format_set_font_size(custom, 0x10);  //字体大小
 format_set_align(custom, LXW_ALIGN_CENTER);
 format_set_align(custom, LXW_ALIGN_VERTICAL_CENTER);
 //参数居中
 lxw_format *center = workbook_add_format(workbookTwo);
 format_set_align(center, LXW_ALIGN_CENTER);

 //第一行
 worksheet_set_row(worksheet, 0, 70, NULL);
 worksheet_set_column(worksheet, 0, 21, 20, NULL);
 worksheet_write_string(worksheet, 0, 0, "公司货号", custom); //第一列
 worksheet_write_string(worksheet, 0, 1, "商品名称", custom); //第二列
 worksheet_write_string(worksheet, 0, 2, "商品尺寸", custom); //第一列
 worksheet_write_string(worksheet, 0, 3, "商品材质", custom); //第一列
 worksheet_write_string(worksheet, 0, 4, "商品颜色", custom); //第一列
 worksheet_write_string(worksheet, 0, 5, "商品价格", custom); //第一列
 worksheet_write_string(worksheet, 0, 6, "货币类型", custom); //第一列
 worksheet_write_string(worksheet, 0, 7, "价格条款", custom); //第一列
 worksheet_write_string(worksheet, 0, 8, "商品备注", custom); //第一列
 worksheet_write_string(worksheet, 0, 9, "商品简介", custom); //第一列
 worksheet_write_string(worksheet, 0, 10, "自定义1", custom); //第一列
 worksheet_write_string(worksheet, 0, 11, "自定义2", custom); //第一列
 worksheet_write_string(worksheet, 0, 12, "产品图片一", custom); //第一列
 worksheet_write_string(worksheet, 0, 13, "产品图片二", custom); //第一列
 worksheet_write_string(worksheet, 0, 14, "产品图片三", custom); //第一列
 worksheet_write_string(worksheet, 0, 15, "产品图片四", custom); //第一列
 worksheet_write_string(worksheet, 0, 16, "供应商名称", custom); //第一列
 worksheet_write_string(worksheet, 0, 17, "供应商公司名", custom); //第一列
 worksheet_write_string(worksheet, 0, 18, "供应商电话", custom); //第一列
 worksheet_write_string(worksheet, 0, 19, "报价类型", custom); //第一列
 worksheet_write_string(worksheet, 0, 20, "报价时间", custom); //第一列
 worksheet_write_string(worksheet, 0, 21, "预留时间", custom); //第一列
 
 for (NSInteger i = 0 ;  i < 2; i++) {
 NSString *row = [NSString stringWithFormat:@"%ld",i + 1];
 int num =  [row intValue];
 worksheet_set_row(worksheet, num, 120, NULL);
 worksheet_set_column(worksheet, 0, 21, 20, NULL);
 
 
 const char *oneStr = [_shopObjc.companyID UTF8String];
 worksheet_write_string(worksheet, num, 0, oneStr, custom);
 
 const char *twoStr = [_shopObjc.shopName UTF8String];
 worksheet_write_string(worksheet, num, 1, twoStr, custom);
 
 const char *threeStr = [_shopObjc.shopSize UTF8String];
 worksheet_write_string(worksheet, num, 2, threeStr, custom);
 
 const char *fourStr = [_shopObjc.shopMed UTF8String];
 worksheet_write_string(worksheet, num, 3, fourStr, custom);
 
 const char *fiveStr = [_shopObjc.shopColor UTF8String];
 worksheet_write_string(worksheet, num, 4, fiveStr, custom);
 
 
 const char *sixStr = [_shopObjc.shopPrice UTF8String];
 worksheet_write_string(worksheet, num, 5, sixStr, custom);
 
 const char *sevenStr = [_shopObjc.shopHuoBi UTF8String];
 worksheet_write_string(worksheet, num, 6, sevenStr, custom);
 
 const char *eightStr = [_shopObjc.shopTiaoK UTF8String];
 worksheet_write_string(worksheet, num, 7, eightStr, custom);
 
 const char *nineStr = [_shopObjc.shopDescribe UTF8String];
 worksheet_write_string(worksheet, num, 8, nineStr, custom);
 
 const char *tenStr = [_shopObjc.shopInfo UTF8String];
 worksheet_write_string(worksheet, num, 9, tenStr, custom);
 
 const char *oneCustom = [_shopObjc.shopCustom UTF8String];
 worksheet_write_string(worksheet, num, 10, oneCustom, custom);
 
 const char *twoCustom = [_shopObjc.shopContent UTF8String];
 worksheet_write_string(worksheet, num, 11, twoCustom, custom);
 
 
 NSMutableArray *imageArray = [NSMutableArray array];
 NSArray *arrayimg=[_shopObjc.shopPicture componentsSeparatedByString:@"|"];
 NSString *path_document = NSHomeDirectory();
 //设置一个图片的存储路径
 for (NSInteger i = 0 ; i < arrayimg.count; i++) {
 NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[i]]];
 [imageArray addObject:imagePath];
 const char *image = [imageArray[i] UTF8String];
 NSString *str = [NSString stringWithFormat:@"%ld",i];
 int coulm =  [str intValue] + 12;
 worksheet_insert_image(worksheet,  num,  coulm, image);
 }
 
 worksheet_write_string(worksheet, num, 16, "供应商名称", custom);
 worksheet_write_string(worksheet, num, 17, "供应商公司名", custom);
 worksheet_write_string(worksheet, num, 18, "供应商电话", custom);
 worksheet_write_string(worksheet, num, 19, "报价类型", custom);
 worksheet_write_string(worksheet, num, 20, "报价时间", custom);
 worksheet_write_string(worksheet, num, 21, "预留时间", custom);
 }
 workbook_close(workbookTwo);
 }
 
 

















@end
































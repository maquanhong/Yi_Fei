//
//  SupplyOutForm.m
//  Yi_Fei
//
//  Created by yons on 16/12/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <libxlsxwriter/xlsxwriter.h>
#import "SupplyOutForm.h"

static NSString * const kFileExtension = @"xlsx";
@implementation SupplyOutForm


#pragma mark 导出的文件路径
- (NSString *)outputFilePath {
    
    NSAssert(self.outputFileName, @"outputFileName needs to be overridden in subclasses");
    
    NSString *documentsFolderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [[documentsFolderPath stringByAppendingPathComponent:self.outputFileName] stringByAppendingPathExtension:kFileExtension];
    
    return filePath;
    
}


#pragma mark 导出的文件名
- (NSString *)outputFileName {
    return @"供应商商品单价";
}


//供应商导出给客户看的
- (void)outExportExcel {
    
    //设置保存路径
    lxw_workbook  *workbook   = workbook_new([self.outputFilePath fileSystemRepresentation]);
    //创建Excel表格
    lxw_worksheet *worksheet1 = workbook_add_worksheet(workbook, "ProductPrice");
    
    //设置表格的格式
    lxw_format *format = workbook_add_format(workbook);
    format_set_border(format, LXW_BORDER_THIN); //设置边框
    format_set_bold(format);
    format_set_font_size(format, 0x12);  //字体大小
    format_set_align(format, LXW_ALIGN_CENTER);
    format_set_align(format, LXW_ALIGN_VERTICAL_CENTER);
    
    //参数居中
    lxw_format *center = workbook_add_format(workbook);
    format_set_align(center, LXW_ALIGN_CENTER);
    
    //创建第一行:
    lxw_format *font = workbook_add_format(workbook);
    format_set_bold(font);
    format_set_border(font, LXW_BORDER_THIN);
    format_set_font_size(font, 0x14);  //字体大小
    format_set_align(font, LXW_ALIGN_CENTER);
    format_set_align(font, LXW_ALIGN_VERTICAL_CENTER);
    worksheet_merge_range(worksheet1, 0, 0, 0, 11, "商品报价单", font);
    worksheet_set_column(worksheet1, 0, 0, 20, NULL);
    worksheet_set_row(worksheet1, 0, 55, NULL);
    //  worksheet_write_string(worksheet1, 0, 0, "商品报价单", font);
    
    //创建第二行
    //第一个单元格
    lxw_format *custom = workbook_add_format(workbook);
    //    format_set_bold(font);
    format_set_border(custom, LXW_BORDER_THIN); //设置边框
    format_set_font_size(custom, 0x10);  //字体大小
    format_set_align(custom, LXW_ALIGN_CENTER);
    format_set_align(custom, LXW_ALIGN_VERTICAL_CENTER);
    worksheet_set_column(worksheet1, 0, 0, 15, NULL);
    worksheet_set_row(worksheet1, 1, 35, NULL);
   	worksheet_write_string(worksheet1, 1, 0, "客户姓名", custom);
    
    //第二个单元格
    worksheet_set_column(worksheet1, 1, 5, 15, NULL);
    worksheet_merge_range(worksheet1, 1, 1, 1, 4, "张明军", custom);
    
    //第三个单元格
    worksheet_set_column(worksheet1, 5, 5, 15, NULL);
    worksheet_set_row(worksheet1, 1, 35, NULL);
   	worksheet_write_string(worksheet1, 1, 5, "报价时间", custom);
    
    //第四个单元格
    worksheet_set_column(worksheet1, 6, 10, 6, NULL);
    worksheet_merge_range(worksheet1, 1, 6, 1, 11, "2016-11-30", custom);
    
    
    //创建第三行
    worksheet_set_column(worksheet1, 1, 3, 6, NULL);
    worksheet_set_column(worksheet1, 4, 4, 4, NULL);
    worksheet_set_column(worksheet1, 6, 11, 6, NULL);
    worksheet_set_row(worksheet1, 2, 120, NULL);
   	worksheet_write_string(worksheet1, 2, 0, "产品图片", custom);
    
    //第二单元格
    worksheet_merge_range(worksheet1, 2, 1, 2, 3, "", custom);
    worksheet_merge_range(worksheet1, 2, 4, 2, 5, "", custom);
    worksheet_merge_range(worksheet1, 2, 6, 2, 8, "", custom);
    worksheet_merge_range(worksheet1, 2, 9, 2, 11, "", custom);
    
    NSMutableArray *imageArray = [NSMutableArray array];
    NSArray *arrayimg=[_shopObjc.shopPicture componentsSeparatedByString:@"|"];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    for (NSInteger i = 0 ; i < arrayimg.count; i++) {
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[i]]];
        [imageArray addObject:imagePath];
        
        if (i == 0) {
            const char *imageOne = [imageArray[i] UTF8String];
            worksheet_insert_image(worksheet1,  2, 1, imageOne);
        }else if (i == 1){
            const char *imageTwo = [imageArray[i] UTF8String];
            worksheet_insert_image(worksheet1,  2, 4, imageTwo);
            
        }else if (i == 2){
            const char *imageThree = [imageArray[i] UTF8String];
            worksheet_insert_image(worksheet1,  2, 6, imageThree);
        }else if (i == 3){
            const char *imageFour = [imageArray[i] UTF8String];
            worksheet_insert_image(worksheet1,  2, 9, imageFour);
        }
    }
    
    //第三单元格
    //第四单元格
    //第五单元格
    
    //第四行
    worksheet_merge_range(worksheet1, 3, 0, 3, 11, "产品参数详情", custom);
    worksheet_set_column(worksheet1, 0, 0, 20, NULL);
    worksheet_set_row(worksheet1, 3, 45, NULL);
    
    //第五行
    lxw_format *customFormat = workbook_add_format(workbook);
    //    format_set_bold(font);
    format_set_border(customFormat, LXW_BORDER_THIN); //设置边框
    format_set_font_size(customFormat, 0xe);  //字体大小
    format_set_align(customFormat, LXW_ALIGN_CENTER);
    format_set_align(customFormat, LXW_ALIGN_VERTICAL_CENTER);
    worksheet_set_row(worksheet1, 1, 35, NULL);
    
    worksheet_set_row(worksheet1, 4, 35, NULL);
    
   	worksheet_write_string(worksheet1, 4, 0, "商品名称", custom);
    //第二个单元格
    const char *oneStr = [_shopObjc.shopName UTF8String];
    worksheet_merge_range(worksheet1, 4, 1, 4, 4, oneStr, customFormat);
    //第三个单元格
    worksheet_write_string(worksheet1, 4, 5, "商品价格", custom);
    //第四个单元格
    const char *twoStr = [_shopObjc.shopPrice UTF8String];
    worksheet_merge_range(worksheet1, 4, 6, 4, 11, twoStr, customFormat);
    
    //第六行
    worksheet_set_row(worksheet1, 5, 35, NULL);
   	worksheet_write_string(worksheet1, 5, 0, "公司货号", custom);
    //第二个单元格
    const char *threeStr = [_shopObjc.companyID UTF8String];
    worksheet_merge_range(worksheet1, 5, 1, 5, 4, threeStr, customFormat);
    //第三个单元格
    worksheet_write_string(worksheet1, 5, 5, "商品材质", custom);
    //第四个单元格
    const char *fourStr = [_shopObjc.shopMed UTF8String];
    worksheet_merge_range(worksheet1, 5, 6, 5, 11, fourStr, customFormat);
    
    
    //第七行
    worksheet_set_row(worksheet1, 6, 35, NULL);
   	worksheet_write_string(worksheet1, 6, 0, "商品尺寸", custom);
    //第二个单元格
    const char *fiveStr = [_shopObjc.shopSize UTF8String];
    worksheet_merge_range(worksheet1, 6, 1, 6, 4, fiveStr, customFormat);
    //第三个单元格
    worksheet_write_string(worksheet1, 6, 5, "商品颜色", custom);
    //第四个单元格
    const char *sixStr = [_shopObjc.shopColor UTF8String];
    worksheet_merge_range(worksheet1, 6, 6, 6, 11, sixStr, customFormat);
    
    
    //第八行
    worksheet_set_row(worksheet1, 7, 35, NULL);
   	worksheet_write_string(worksheet1, 7, 0, "价格条款", custom);
    //第二个单元格
    const char *sevenStr = [_shopObjc.shopTiaoK UTF8String];
    worksheet_merge_range(worksheet1, 7, 1, 7, 4, sevenStr, customFormat);
    //第三个单元格
    worksheet_write_string(worksheet1, 7, 5, "货币类型", custom);
    //第四个单元格
    const char *eightStr = [_shopObjc.shopHuoBi UTF8String];
    worksheet_merge_range(worksheet1, 7, 6, 7, 11, eightStr, customFormat);
    
    
    //第九行
    worksheet_set_row(worksheet1, 8, 35, NULL);
   	worksheet_write_string(worksheet1, 8, 0, "商品介绍", custom);
    //第二个单元格
    const char *nineStr = [_shopObjc.shopInfo UTF8String];
    worksheet_merge_range(worksheet1, 8, 1, 8, 4, nineStr, customFormat);
    //第三个单元格
    worksheet_write_string(worksheet1, 8, 5, "商品备注", custom);
    //第四个单元格
    const char *tentStr = [_shopObjc.shopDescribe UTF8String];
    worksheet_merge_range(worksheet1, 8, 6, 8, 11, tentStr, customFormat);
    
    NSArray * customArray =[_shopObjc.shopCustom componentsSeparatedByString:@"|"];
    NSArray * bodyArray = [_shopObjc.shopContent componentsSeparatedByString:@"|"];
    for (int i = 0 ; i < customArray.count; i++) {
        if (i  % 2 == 0 ) {
            int count = i / 2;
            worksheet_set_row(worksheet1, (8 + count) , 35, NULL);
            NSString *str = [NSString stringWithFormat:@"%@",customArray[i]];
            const char *cStr = [str UTF8String];
            worksheet_write_string(worksheet1, (8 + count), 0, cStr, custom);
            //第二个单元格
            worksheet_merge_range(worksheet1, (8 + count) , 1, (8 + count), 4, cStr, customFormat);
            
        }else{
            int count = i / 2;
            worksheet_set_row(worksheet1, (8 + count) , 35, NULL);
            NSString *str = [NSString stringWithFormat:@"%@",bodyArray[i]];
            const char *cStr = [str UTF8String];
            worksheet_write_string(worksheet1, (8 + count), 5, cStr, custom);
            //第四个单元格
            worksheet_merge_range(worksheet1, (8 + count), 6, (8 + count), 11, cStr, customFormat);
        }
    }
    workbook_close(workbook);
}






@end

































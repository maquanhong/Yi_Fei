//
//  SupplyComeOut.m
//  Yi_Fei
//
//  Created by yons on 17/1/4.
//  Copyright © 2017年 ZMJPersonal. All rights reserved.
//

#import <libxlsxwriter/xlsxwriter.h>
#import "SupplyComeOut.h"
#import "UserDefaultManager.h"

static NSString * const kFileExtension = @"xlsx";

@implementation SupplyComeOut


#pragma mark 导入的文件路径
- (NSString *)importFilePath {
    
    NSAssert(self.importFileName, @"outputFileName needs to be overridden in subclasses");
    NSString *documentsFolderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [[documentsFolderPath stringByAppendingPathComponent:self.importFileName] stringByAppendingPathExtension:kFileExtension];
    [UserDefaultManager saveDataWithValue:filePath key:@"keyPath"];
    return filePath;
    
}

#pragma mark 导出的文件名
- (NSString *)importFileName {
    return @"outToBuyer";
}

//导入数据用的
-(void)sendToBuyerExcel{
    //设置保存路径
    lxw_workbook  *workbookTwo   = workbook_new([self.importFilePath fileSystemRepresentation]);
    //创建Excel表格
    lxw_worksheet *worksheet = workbook_add_worksheet(workbookTwo, "outToBuyer");
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
    worksheet_set_column(worksheet, 0, 26, 20, NULL);
    worksheet_write_string(worksheet, 0, 0, "商品货号", custom); //第一列
    worksheet_write_string(worksheet, 0, 1, "商品名称", custom); //第一列
    worksheet_write_string(worksheet, 0, 2, "商品规格", custom); //第一列
    worksheet_write_string(worksheet, 0, 3, "商品材质", custom); //第一列
    worksheet_write_string(worksheet, 0, 4, "商品尺寸", custom); //第一列
    worksheet_write_string(worksheet, 0, 5, "商品颜色", custom); //第一列
    worksheet_write_string(worksheet, 0, 6, "商品数量", custom); //第一列
    worksheet_write_string(worksheet, 0, 7, "询价类型", custom); //第一列
    worksheet_write_string(worksheet, 0, 8, "预留报价时间", custom); //第一列
    worksheet_write_string(worksheet, 0, 9, "报价时间", custom); //第一列
    worksheet_write_string(worksheet, 0, 10, "商品备注", custom); //第一列
    worksheet_write_string(worksheet, 0, 11, "产品图片一", custom); //第一列
    worksheet_write_string(worksheet, 0, 12, "产品图片二", custom); //第一列
    worksheet_write_string(worksheet, 0, 13, "产品图片三", custom); //第一列
    worksheet_write_string(worksheet, 0, 14, "产品图片四", custom); //第一列
    worksheet_write_string(worksheet, 0, 15, "供应商姓名", custom); //第一列
    worksheet_write_string(worksheet, 0, 16, "供应商公司名", custom); //第一列
    worksheet_write_string(worksheet, 0, 17, "货币类型", custom); //第一列
    worksheet_write_string(worksheet, 0, 18, "价格条款", custom); //第一列
    worksheet_write_string(worksheet, 0, 19, "自定义1", custom); //第一列
    worksheet_write_string(worksheet, 0, 20, "自定义2", custom); //第一列
    worksheet_write_string(worksheet, 0, 21, "商品简介", custom); //第一列
    worksheet_write_string(worksheet, 0, 22, "商品价格", custom); //第一列
    worksheet_write_string(worksheet, 0, 23, "码头地址", custom); //第一列
    worksheet_write_string(worksheet, 0, 24, "询价标识", custom); //第一列
    
    for (NSInteger i = 0 ;  i < _objcArray.count; i++) {
        
        NSString *row = [NSString stringWithFormat:@"%ld",i + 1];
        int num =  [row intValue];
        worksheet_set_row(worksheet, num, 120, NULL);
        worksheet_set_column(worksheet, 0, 25, 20, NULL);
        _shopObjc = [[CustomerProductModel alloc] init];
        _shopObjc = _objcArray[i];
        const char *oneStr = [_shopObjc.companyID  UTF8String];
        worksheet_write_string(worksheet, num, 0, oneStr, custom);
        
        const char *twoStr = [_shopObjc.shopName UTF8String];
        worksheet_write_string(worksheet, num, 1, twoStr, custom);
        
        const char *threeStr = [_shopObjc.shopSpecific UTF8String];
        worksheet_write_string(worksheet, num, 2, threeStr, custom);
        
        const char *fourStr = [_shopObjc.shopMed UTF8String];
        worksheet_write_string(worksheet, num, 3, fourStr, custom);
        
        const char *fiveStr = [_shopObjc.shopSize UTF8String];
        worksheet_write_string(worksheet, num, 4, fiveStr, custom);
        
        const char *sixStr = [_shopObjc.shopColor UTF8String];
        worksheet_write_string(worksheet, num, 5, sixStr, custom);
        
        const char *sevenStr = [_shopObjc.count UTF8String];
        worksheet_write_string(worksheet, num, 6, sevenStr, custom);
        
        const char *eightStr = [_shopObjc.flag UTF8String];
        worksheet_write_string(worksheet, num, 7, eightStr, custom);
        
        const char *tenStr = [self.reverTime UTF8String];
        worksheet_write_string(worksheet, num, 8, tenStr, custom);
        
        const char *one = [self.offerTime UTF8String];
        worksheet_write_string(worksheet, num, 9, one, custom);
        
        const char *two = [_shopObjc.shopDescribe UTF8String];
        worksheet_write_string(worksheet, num, 10, two, custom);
        
        NSMutableArray *array = [NSMutableArray array];
        
       NSString *path_document = NSHomeDirectory();
  
        if (_shopObjc.imageOne ) {
            CGSize  size = CGSizeMake(145, 160);
        UIImage *image = [self compressOriginalImage:[UIImage imageWithData:_shopObjc.imageOne] toSize:size ];
    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",@"0"]];
      [UIImagePNGRepresentation(image)  writeToFile:imagePath atomically:YES];
            [array addObject:@"0"];
    }
        
        if (_shopObjc.imageTwo ) {
            CGSize  size = CGSizeMake(145, 160);
            UIImage *image = [self compressOriginalImage:[UIImage imageWithData:_shopObjc.imageTwo] toSize:size ];
            
    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",@"1"]];
    [UIImagePNGRepresentation(image)  writeToFile:imagePath atomically:YES];
             [array addObject:@"1"];
        }
        
        if (_shopObjc.imageThree ) {
            CGSize  size = CGSizeMake(145, 160);
            UIImage *image = [self compressOriginalImage:[UIImage imageWithData:_shopObjc.imageThree] toSize:size ];
            NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",@"2"]];
            [UIImagePNGRepresentation(image)  writeToFile:imagePath atomically:YES];
              [array addObject:@"2"];
        }
        
        if (_shopObjc.imageFour ) {
            CGSize  size = CGSizeMake(145, 160);
            UIImage *image = [self compressOriginalImage:[UIImage imageWithData:_shopObjc.imageFour] toSize:size ];
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",@"3"]];
        [UIImagePNGRepresentation(image)  writeToFile:imagePath atomically:YES];
             [array addObject:@"3"];
        }
    
         NSMutableArray *imageArray = [NSMutableArray array];
        for (NSInteger i = 0 ; i < array.count; i++) {
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",array[i]]];
            [imageArray addObject:imagePath];
            const char *image = [imageArray[i] UTF8String];
            NSString *str = [NSString stringWithFormat:@"%ld",i];
            int coulm =  [str intValue] + 11;
            worksheet_insert_image(worksheet,  num,  coulm, image);
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:imagePath]) {
                [fileManager removeItemAtPath:imagePath error:nil];
            }
        }
        
        const char *three = [self.supplyName UTF8String];
        worksheet_write_string(worksheet, num, 15, three, custom);
        
        const char *four = [self.companyName UTF8String];
        worksheet_write_string(worksheet, num, 16, four, custom);
        
        const char *five = [_shopObjc.shopHuoBi UTF8String];
        worksheet_write_string(worksheet, num, 17, five, custom);
        
        const char *six = [_shopObjc.shopTiaoK UTF8String];
        worksheet_write_string(worksheet, num, 18, six, custom);
        
        const char *seven = [_shopObjc.shopCustom UTF8String];
        worksheet_write_string(worksheet, num, 19, seven, custom);
        
        const char *eight = [_shopObjc.shopContent UTF8String];
        worksheet_write_string(worksheet, num, 20, eight, custom);
        
        const char *nine = [_shopObjc.shopInfo UTF8String];
        worksheet_write_string(worksheet, num, 21, nine, custom);
        
        const char *ten = [_shopObjc.shopPrice UTF8String];
        worksheet_write_string(worksheet, num, 22, ten, custom);
        
        const char *eleven = [_shopObjc.shopAdderss UTF8String];
        worksheet_write_string(worksheet, num, 23, eleven, custom);
        
        const char *twleve = [ @"send" UTF8String];
        worksheet_write_string(worksheet, num, 24,twleve, custom);
    }
    workbook_close(workbookTwo);
}



-(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
































@end
























































//
//  ParsingController.m
//  Yi_Fei
//
//  Created by yons on 16/12/7.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ParsingController.h"
#import "BRAOfficeDocumentPackage.h"

@interface ParsingController ()

@end

@implementation ParsingController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *documentPath = [[NSBundle mainBundle] pathForResource:@"nihao" ofType:@"xlsx"];
    BRAOfficeDocumentPackage *spreadsheet = [BRAOfficeDocumentPackage open:documentPath];
    BRAWorksheet *firstWorksheet = spreadsheet.workbook.worksheets[0];
    NSString *formula = [[firstWorksheet cellForCellReference:@"公司货号"] formulaString];
    UIImage *image = [firstWorksheet imageForCellReference:@"产品图片一"].uiImage;
    }

    
    





@end












































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
    self.view.backgroundColor = INTERFACECOLOR;
    
    NSString *documentPath = [[NSBundle mainBundle] pathForResource:@"nihao" ofType:@"xlsx"];
    
    BRAOfficeDocumentPackage *spreadsheet = [BRAOfficeDocumentPackage open:documentPath];
    BRAWorksheet *firstWorksheet = spreadsheet.workbook.worksheets[0];
    NSString *formula = [[firstWorksheet cellForCellReference:@"商品名称"] formulaString];
     NSLog(@"%@",formula);
    UIImage *image = [firstWorksheet imageForCellReference:@"产品图片一"].uiImage;
    NSLog(@"%@",image);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    
    
    }

    
    





@end












































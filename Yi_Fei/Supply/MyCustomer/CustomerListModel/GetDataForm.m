
//
//  GetDataForm.m
//  Yi_Fei
//
//  Created by yons on 17/1/2.
//  Copyright © 2017年 ZMJPersonal. All rights reserved.
//

#import "GetDataForm.h"
#import "UserDefaultManager.h"
#import "BRAOfficeDocumentPackage.h"
#import "CustomerProductModel.h"
#import "CustomerProductModel.h"
#import "CustomerProductList.h"



@implementation GetDataForm


-(void)getDataFromeForm{
  
    CustomerProductModel *model = [[CustomerProductModel alloc] init];
    CustomerProductList * manager = [CustomerProductList defaultManager];
    
    NSString *path = [UserDefaultManager getDataByKey:@"path"];
BRAOfficeDocumentPackage *spreadsheet = [BRAOfficeDocumentPackage open:path];
BRAWorksheet *firstWorksheet = spreadsheet.workbook.worksheets[0];
 NSInteger i = 2;
  while (1) {
      
     NSString *UV = [NSString stringWithFormat:@"%@%ld",@"P",i];
     NSString *str =  [[firstWorksheet cellForCellReference:UV] stringValue];
      if ([str length] > 0 ) {
          NSString *a = [NSString stringWithFormat:@"%@%ld",@"A",i];
          NSString *formula = [[firstWorksheet cellForCellReference:a] stringValue];
          model.companyID = formula;
          
          NSString *b = [NSString stringWithFormat:@"%@%ld",@"B",i];
          NSString *one = [[firstWorksheet cellForCellReference:b] stringValue];
          model.shopName = one;
          
          NSString *c = [NSString stringWithFormat:@"%@%ld",@"C",i];
          NSString *two = [[firstWorksheet cellForCellReference:c] stringValue];
          model.shopSpecific = two;
          
          NSString *d = [NSString stringWithFormat:@"%@%ld",@"D",i];
          NSString *three = [[firstWorksheet cellForCellReference:d] stringValue];
          model.shopMed = three;
          
          NSString *e = [NSString stringWithFormat:@"%@%ld",@"E",i];
          NSString *four = [[firstWorksheet cellForCellReference:e] stringValue];
          model.shopSize = four;
          
          NSString *f = [NSString stringWithFormat:@"%@%ld",@"F",i];
          NSString *five = [[firstWorksheet cellForCellReference:f] stringValue];
          model.shopColor = five;
          
          NSString *g = [NSString stringWithFormat:@"%@%ld",@"G",i];
          NSString *six = [[firstWorksheet cellForCellReference:g] stringValue];
          model.count = six;
          
          NSString *h = [NSString stringWithFormat:@"%@%ld",@"H",i];
          NSString *seven = [[firstWorksheet cellForCellReference:h] stringValue];
          model.flag = seven;
          
          NSString *j = [NSString stringWithFormat:@"%@%ld",@"I",i];
          NSString *eight = [[firstWorksheet cellForCellReference:j] stringValue];
          model.time = eight;
        
          NSString *k = [NSString stringWithFormat:@"%@%ld",@"J",i];
          NSString *nine = [[firstWorksheet cellForCellReference:k] stringValue];
          model.askTime = nine;
          
          NSString *l = [NSString stringWithFormat:@"%@%ld",@"K",i];
          NSString *ten = [[firstWorksheet cellForCellReference:l] stringValue];
          model.shopDescribe = ten;
          
          NSString *m = [NSString stringWithFormat:@"%@%ld",@"L",i];
          UIImage *imageOne = [firstWorksheet imageForCellReference:m].uiImage;
          model.imageOne = UIImagePNGRepresentation(imageOne);
          
          NSString *n = [NSString stringWithFormat:@"%@%ld",@"M",i];
          UIImage *imageTwo = [firstWorksheet imageForCellReference:n].uiImage;
           model.imageTwo = UIImagePNGRepresentation(imageTwo);
          
          NSString *o = [NSString stringWithFormat:@"%@%ld",@"N",i];
          UIImage *imageThree = [firstWorksheet imageForCellReference:o].uiImage;
          model.imageThree = UIImagePNGRepresentation(imageThree);
          
          NSString *p = [NSString stringWithFormat:@"%@%ld",@"O",i];
          UIImage *imageFour = [firstWorksheet imageForCellReference:p].uiImage;
          model.imageFour = UIImagePNGRepresentation(imageFour);
          
          NSString *q = [NSString stringWithFormat:@"%@%ld",@"P",i];
          NSString *sixth = [[firstWorksheet cellForCellReference:q] stringValue];
          model.customerName = sixth;
          
          NSString *r = [NSString stringWithFormat:@"%@%ld",@"Q",i];
          NSString *seventh = [[firstWorksheet cellForCellReference:r] stringValue];
           model.companyName = seventh;
          
          NSString *s = [NSString stringWithFormat:@"%@%ld",@"R",i];
          NSString *eighth = [[firstWorksheet cellForCellReference:s] stringValue];
           model.shopHuoBi = eighth;
          
          NSString *t = [NSString stringWithFormat:@"%@%ld",@"S",i];
          NSString *tenth = [[firstWorksheet cellForCellReference:t] stringValue];
          model.shopTiaoK = tenth;
          
          NSString *u = [NSString stringWithFormat:@"%@%ld",@"T",i];
          NSString *oneStr = [[firstWorksheet cellForCellReference:u] stringValue];
          model.shopCustom = oneStr;
          
          NSString *v = [NSString stringWithFormat:@"%@%ld",@"U",i];
          NSString *twoStr = [[firstWorksheet cellForCellReference:v] stringValue];
          model.shopContent = twoStr;
          
          NSString *w = [NSString stringWithFormat:@"%@%ld",@"V",i];
          NSString *threeStr  = [[firstWorksheet cellForCellReference:w] stringValue];
           model.shopInfo = threeStr;
          
          NSString *x = [NSString stringWithFormat:@"%@%ld",@"W",i];
          NSString *fourStr = [[firstWorksheet cellForCellReference:x] stringValue];
          model.shopPrice = fourStr;
          
          NSString *y = [NSString stringWithFormat:@"%@%ld",@"X",i];
          NSString *fiveStr = [[firstWorksheet cellForCellReference:y] stringValue];
          model.shopAdderss = fiveStr;
          
          
          NSString *z = [NSString stringWithFormat:@"%@%ld",@"Y",i];
          NSString *sixStr = [[firstWorksheet cellForCellReference:z] stringValue];
          model.identify = sixStr;
    
          [manager insertDataModel:model];
          
          i++;
      }else{
          break;
      }
    }
}






@end






























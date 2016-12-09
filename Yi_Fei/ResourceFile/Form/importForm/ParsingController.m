//
//  ParsingController.m
//  Yi_Fei
//
//  Created by yons on 16/12/7.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ParsingController.h"
#import "DHxlsReader.h"

@interface ParsingController ()

@end

@implementation ParsingController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle ] pathForResource:@"ImportPrice.xls" ofType:nil];

DHxlsReader *reader = [DHxlsReader xlsReaderWithPath:path];
  assert(reader);
//  NSMutableArray *oneArray = [NSMutableArray array];
    //excel表中第几行开始
    int row = 1;
//    while(row < 2 ) {
    
        DHcell *cell ;
        for (NSInteger i = 1; i < 5; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld",i];
        int col = [str intValue];
        cell = [reader cellInWorkSheetIndex:0 row:1 col:col];
    if(cell.type == cellBlank) break;
          NSLog(@"%@",cell.dump);
    
        }
        row++;
    }

    
    





@end












































//
//  offerViewController.m
//  YiFei
//  Created by yangyan on 16/9/9.
//  Copyright © 2016年 yous. All rights reserved.



#import "AskPriceController.h"
#import "BUYButton.h"
#import "BuyerViewController.h"
#import "AskPriceSupplyController.h"
#import "ManualAddAupplyController.h"


@interface AskPriceController ()

@property(nonatomic,strong)NSArray *titleArray;


@end

@implementation AskPriceController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTool];
        self.title = @"询价";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self addContentView];
}

- (void)setNavTool
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(void)addContentView{
       _titleArray=@[@"供应商",@"新建供应商"];
    
    for (int i=0; i<_titleArray.count; i++) {
        UIButton *button=[BUYButton creatBtnWithBgColor:NAVCOLOR borderColor:NAVCOLOR borderWidth:0 titleColor:[UIColor whiteColor] text:[self.titleArray objectAtIndex:i]];
        [button sizeToFit];
        button.tag = 1000 + i;
        button.frame=CGRectMake(10, 64+10+60*i + 30 * i, WIDTH-20, 60);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

-(void)buttonClick:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
        if (index == 1) {
ManualAddAupplyController *clientVc = [[ManualAddAupplyController alloc] init];
    [self.navigationController pushViewController:clientVc animated:YES];
        } else if (index == 0) {
AskPriceSupplyController *salerVc = [[AskPriceSupplyController alloc] init];
[self.navigationController pushViewController:salerVc animated:YES];
        }
    
}









@end






//
//  offerViewController.m
//  YiFei
//  Created by yangyan on 16/9/9.
//  Copyright © 2016年 yous. All rights reserved.



#import "AskPriceController.h"
#import "BUYButton.h"
#import "BuyerViewController.h"
#import "ClientSupplyController.h"
#import "AskPriceSupplyController.h"
#import "ManualAddAupplyController.h"


@interface AskPriceController ()
@property(nonatomic,strong)NSArray *titleArray;
@property (nonatomic, assign) BussinessType type;
@end

@implementation AskPriceController

- (instancetype)initWithIdType:(BussinessType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTool];
    if (self.type == BussinessBuyer) {
        self.title = @"询价";
    }else {
        self.title = @"报价";
    }
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self addContentView];
}

- (void)setNavTool
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(void)addContentView{
    if (self.type == BussinessBuyer) {
       _titleArray=@[@"供应商",@"新建供应商"];
    } else {
        _titleArray=@[@"客户",@"新建客户"];
    }
    
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
    if (self.type == BussinessBuyer) {
        if (index == 1) {
ManualAddAupplyController *clientVc = [[ManualAddAupplyController alloc] init];
    [self.navigationController pushViewController:clientVc animated:YES];
        } else if (index == 0) {
AskPriceSupplyController *salerVc = [[AskPriceSupplyController alloc] init];
[self.navigationController pushViewController:salerVc animated:YES];
        }
    } else {
        if (index == 0) {
            ClientSupplyController *clientVc = [[ClientSupplyController alloc] init];
            [self.navigationController pushViewController:clientVc animated:YES];
        } else if (index == 1) {
            
//            NewClientSupplyController *clientVc = [[NewClientSupplyController alloc] initWithTypeId:BussinessSaler];
//            [self.navigationController pushViewController:clientVc animated:YES];
            
        }
    }


}









@end






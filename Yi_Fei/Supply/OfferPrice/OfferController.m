//
//  OfferController.m
//  Yi_Fei
//
//  Created by yons on 16/12/18.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "OfferController.h"
#import "BUYButton.h"
#import "CustomController.h"
#import "CustomerController.h"


@interface OfferController ()


@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation OfferController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTool];
    self.title = @"报价";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self addContentView];
}

- (void)setNavTool
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(void)addContentView{
    _titleArray=@[@"客户",@"新建客户"];
    
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
   CustomerController *salerVc = [[CustomerController alloc] init];
    [self.navigationController pushViewController:salerVc animated:YES];
    } else if (index == 0) {
    CustomController *clientVc = [[CustomController alloc] init];
    [self.navigationController pushViewController:clientVc animated:YES];
    }
}







@end






























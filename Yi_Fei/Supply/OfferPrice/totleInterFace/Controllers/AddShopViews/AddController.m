//
//  AddController.m
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AddController.h"
#import "BUYButton.h"
#import "AddOneController.h"
#import "AddMyProductionController.h"

@interface AddController ()

@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation AddController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = INTERFACECOLOR;
   [self setNav];
   [self addContentView];
}


- (void)setNav {
    self.navigationItem.title = @"商品添加";
    BackButton* leftBtn= [BackButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)addContentView{
    _titleArray=@[@"我的商品",@"新建商品"];
    for (int i=0; i<_titleArray.count; i++) {
        UIButton *button=[BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:[UIColor lightGrayColor] borderWidth:1.0 titleColor:BACKCOLOR text:[self.titleArray objectAtIndex:i]];
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
  AddOneController *salerVc = [[AddOneController alloc] init];
    [self.navigationController pushViewController:salerVc animated:YES];
        
    } else if (index == 0) {
AddMyProductionController *clientVc = [[AddMyProductionController alloc] init];
    [self.navigationController pushViewController:clientVc animated:YES];
    }
}





@end












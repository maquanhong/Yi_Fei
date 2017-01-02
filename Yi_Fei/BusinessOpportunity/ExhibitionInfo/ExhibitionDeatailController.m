//
//  ExhibitionDeatailController.m
//  Yi_Fei
//
//  Created by yons on 16/11/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved


#import "ExhibitionDeatailController.h"

@interface ExhibitionDeatailController ()

@end

@implementation ExhibitionDeatailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self createNavigationView];
}

#pragma mark - 设置导航条
-(void)createNavigationView
{
    self.navigationItem.title = @"展会详情";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

































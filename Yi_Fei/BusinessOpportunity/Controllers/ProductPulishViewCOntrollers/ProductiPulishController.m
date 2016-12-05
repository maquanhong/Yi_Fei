//
//  ProductionViewController.m
//  Yi_Fei
//
//  Created by yons on 16/11/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ProductiPulishController.h"
#import "PulishOneViewController.h"
#import "PulishTwoController.h"
#import "CCZSegementController.h"

@interface ProductiPulishController ()

@end

@implementation ProductiPulishController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createNavigationView];
    [self createScrollerView];
}

#pragma mark - 设置导航条
-(void)createNavigationView
{
    self.navigationItem.title = @"商品发布";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createScrollerView{
    
    PulishOneViewController *oneView = [[PulishOneViewController alloc] init];
    PulishTwoController *twoView = [[PulishTwoController alloc] init];
    CCZSegementController *segement = [CCZSegementController segementControllerWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) titles:@[@"我的供应商",@"全行业供应商"]];
    [segement setSegementTintColor:COLOR];
    [segement setSegementViewControllers:@[oneView,twoView]];
    [segement setSelectedItemAtIndex:3];
    segement.style = CCZSegementStyleDefault;
    [segement selectedAtIndex:^(NSInteger index) {
        NSLog(@"index %ld",index);
    }];
    [self.view addSubview:segement.view];
    [self addChildViewController:segement];
    
    
    
}




































































@end

















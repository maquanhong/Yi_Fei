//
//  DemandViewController.m
//  Yi_Fei
//
//  Created by yons on 16/11/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "DemandViewController.h"
#import "CCZSegementController.h"
#import "DemandOneViewController.h"
#import "DemandTwoViewController.h"

@interface DemandViewController ()


@end

@implementation DemandViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self createNavigationView];
    [self createScrollerView];
}

#pragma mark - 设置导航条
-(void)createNavigationView
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
     titleLabel.text = @"需求发布";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
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

    DemandOneViewController *oneView = [[DemandOneViewController alloc] init];
    DemandTwoViewController *twoView = [[DemandTwoViewController alloc] init];
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
























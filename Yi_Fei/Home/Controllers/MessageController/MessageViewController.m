//
//  MessageViewController.m
//  Yi_Fei
//
//  Created by yons on 16/11/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.

#import "MessageViewController.h"
#import "CCZSegementController.h"
#import "MessageInfoController.h"
#import "MessageTradeController.h"
#import "MessageSystemController.h"
#import "BackButton.h"

@interface MessageViewController ()


@end


@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationView];
    [self createScrollerView];
}

-(void)createNavigationView
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    titleLabel.text = NSLocalizedString(@"info", nil);
    titleLabel.font = [UIFont systemFontOfSize:24];
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
    
     MessageInfoController *oneView = [[MessageInfoController alloc] init];
     MessageTradeController *twoView = [[MessageTradeController alloc] init];
     MessageSystemController *threeView = [[MessageSystemController alloc] init];
    
    CCZSegementController *segement = [CCZSegementController segementControllerWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) titles:@[NSLocalizedString(@"information", nil),NSLocalizedString(@"trading", nil),NSLocalizedString(@"system", nil)]];
    [segement setSegementTintColor:COLOR];
    [segement setSegementViewControllers:@[oneView,twoView,threeView]];
    [segement setSelectedItemAtIndex:3];
    segement.style = CCZSegementStyleDefault;
    [segement selectedAtIndex:^(NSInteger index) {
        NSLog(@"index %ld",index);
    }];
    [self.view addSubview:segement.view];
    [self addChildViewController:segement];
    
    
    
}









@end



































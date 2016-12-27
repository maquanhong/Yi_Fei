//
//  ScanQrcode.m
//  Yi_Fei
//
//  Created by yons on 16/12/26.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ScanQrcode.h"

@interface ScanQrcode ()

@end

@implementation ScanQrcode

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = [UIColor blackColor];
      [self setNav];
    
    
}

- (void)setNav {
    self.title = @"扫描二维码";
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =  leftBtnItem ;
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}



























@end













//
//  CustomerScanController.m
//  Yi_Fei
//
//  Created by yons on 16/12/18.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CustomerScanController.h"
#import "ScanQrcode.h"
#import "ScanCardController.h"


@interface CustomerScanController ()


@property (nonatomic, strong) UIButton  *btnOne;
@property (nonatomic, strong) UIButton  *btnTwo;

@end

@implementation CustomerScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR;
    [self setNav];
    [self createBtn];
}


- (void)setNav {
    self.title = @"扫描";
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


-(void)createBtn{

    NSArray *strs = @[@"扫描二维码",@"扫描名片"];
    _btnOne = [[UIButton alloc] init];
    [_btnOne setTitle:strs[0] forState:UIControlStateNormal];
    _btnOne.backgroundColor = [UIColor whiteColor];
    _btnOne.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnOne.layer.borderWidth = 1.0;
    _btnOne.layer.cornerRadius = 5;
    _btnOne.layer.masksToBounds = YES;
    _btnOne.titleLabel.font = [UIFont systemFontOfSize:18];
    [_btnOne setTitleColor:COLOR forState:UIControlStateNormal];
    [self.view addSubview:_btnOne];
    [_btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(74);
        make.leading.mas_equalTo(self.view).offset(20);
        make.trailing.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
    }];
    _btnOne.tag = 1870;
    [_btnOne addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    

    _btnTwo = [[UIButton alloc] init];
    [_btnTwo setTitle:strs[1] forState:UIControlStateNormal];
    _btnTwo.titleLabel.font = [UIFont systemFontOfSize:18];
    [_btnTwo setTitleColor:COLOR forState:UIControlStateNormal];
    _btnTwo.backgroundColor = [UIColor whiteColor];
    _btnTwo.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnTwo.layer.borderWidth = 1.0;
    _btnTwo.layer.cornerRadius = 5;
    _btnTwo.layer.masksToBounds = YES;
    [self.view addSubview:_btnTwo];
    [_btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnOne.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.view).offset(20);
        make.trailing.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
    }];
    _btnTwo.tag = 1871;
    [_btnTwo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)btnClick:(UIButton *)sender
{

    ScanCardController *cardVC = [[ScanCardController alloc] init];
    
    ScanQrcode *qrVC = [[ScanQrcode alloc] init];
       qrVC.style = [self setQRCode];
       qrVC.isQQSimulator = YES;
       qrVC.isVideoZoom = YES;
    
    
    switch (sender.tag) {
        case 1870:
        {
    [self.navigationController pushViewController:qrVC animated:YES];
        }
            break;
        case 1871:
    [self.navigationController pushViewController:cardVC animated:YES];
            break;
        default:
            break;
    }
}


-(LBXScanViewStyle*)setQRCode{

    //设置扫码区域参数设置
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    return style;
}





















@end










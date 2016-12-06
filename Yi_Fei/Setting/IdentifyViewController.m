//
//  IdentifyViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "IdentifyViewController.h"
#import "PureLayout.h"

@interface IdentifyViewController ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIView  *bgView;
@property (nonatomic, strong) UIImageView *identifyImageView;
@property (nonatomic, strong) UIImage  *navBackgroundImage;
@end

@implementation IdentifyViewController
- (void)setNav {
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
}

- (void)leftButtonClick {
    [self.navigationController.navigationBar setBackgroundImage:self.navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.title = @"我的二维码";
    self.navBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    _bgImageView = [[UIImageView alloc] initForAutoLayout];
    _bgImageView.backgroundColor = UIColorFromRGB(0x4fc2f9);
    [self.view addSubview:self.bgImageView];
    _bgView = [[UIView alloc] initForAutoLayout];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 8;
    [self.view addSubview:self.bgView];
    _identifyImageView = [[UIImageView alloc] initForAutoLayout];
    _identifyImageView.contentMode = UIViewContentModeCenter;
    [self.bgView addSubview:self.identifyImageView];
    [self addViewConstraints];
    // Do any additional setup after loading the view.
}

- (void)addViewConstraints {
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    
    [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:3];
    [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:3];
    [self.bgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.bgView autoSetDimension:ALDimensionHeight toSize:100];
    
    [self.identifyImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.identifyImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.identifyImageView autoSetDimension:ALDimensionHeight toSize:100];
    [self.identifyImageView autoSetDimension:ALDimensionWidth toSize:100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  BUYLoginControl.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYLoginControl.h"
#import "ZMJTotleHomeController.h"
#import "LogonView.h"

@interface BUYLoginControl ()

@property (nonatomic,strong) UIImageView *logoImgView;

@property (nonatomic, strong) UILabel  *versionLabel;

@property (nonatomic, strong) UIButton *loginBtn;


@end

@implementation BUYLoginControl

- (void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR;
    [self setNav];
    //添加最下面版本号
    [self addVersion];
    [self createLogon];
}


-(void)setNav{

    BackButton *btn = [[BackButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(25);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
  [btn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 添加版本号
- (void) addVersion
{
    _versionLabel = [[UILabel alloc] init];
    NSString *version = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *str = [NSString stringWithFormat:@"V %@",version];
    _versionLabel.text=str;
    _versionLabel.font = [UIFont systemFontOfSize:14];
    _versionLabel.textAlignment = NSTextAlignmentCenter;
    _versionLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_versionLabel];
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
}


#pragma makr - 添加两个按钮去
-(void)createLogon{
    
    _logoImgView = [[UIImageView alloc] init];
    _logoImgView.contentMode = UIViewContentModeCenter;
    _logoImgView.image = [UIImage imageNamed:NSLocalizedString(@"Login", nil)];
    [self.view addSubview:_logoImgView];
    [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    NSArray *arrs = @[NSLocalizedString(@"account", nil),NSLocalizedString(@"password", nil)];
    NSArray *imgs = @[@"zhanghao.png",@"mima.png"];
    LogonView *oneView = [[LogonView alloc] init];
    oneView.logoImage.image = [UIImage imageNamed:imgs[0]];
    oneView.textFiled.placeholder = arrs[0];
    oneView.layer.cornerRadius = 5;
    oneView.layer.masksToBounds = YES;
    oneView.layer.borderWidth = 1.0 ;
    oneView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:oneView];
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_logoImgView.mas_bottom).offset(70);
        make.leading.mas_equalTo(self.view).offset(50);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.height.mas_equalTo(40);
    }];
    
    LogonView *twoView = [[LogonView alloc] init];
    twoView.logoImage.image = [UIImage imageNamed:imgs[1]];
    twoView.textFiled.placeholder = arrs[1];
    twoView.layer.cornerRadius = 5;
    twoView.layer.masksToBounds = YES;
    twoView.layer.borderWidth = 1.0 ;
    twoView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:twoView];
    [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneView.mas_bottom).offset(25);
        make.leading.mas_equalTo(self.view).offset(50);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.height.mas_equalTo(40);
    }];
    
    _loginBtn  = [[UIButton alloc] init];
    [_loginBtn setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    [_loginBtn setTitleColor:BACKCOLOR forState:UIControlStateNormal];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(twoView.mas_bottom).offset(35);
        make.leading.mas_equalTo(self.view).offset(50);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.height.mas_equalTo(40);
    }];
    [_loginBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}



- (void)btnClick
{
    ZMJTotleHomeController *vc = [[ZMJTotleHomeController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

























@end






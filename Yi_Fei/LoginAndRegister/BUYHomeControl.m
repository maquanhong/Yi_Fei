//
//  BUYLoginControl.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYHomeControl.h"
#import "BUYRegisterControl.h"
#import "BUYLoginControl.h"
#import "ZMJTotleHomeController.h"
#import "BUYButton.h"
#import "PureLayout.h"

@interface BUYHomeControl ()
@property (nonatomic,strong) UIImageView *logoImgView;
@property (nonatomic, strong) UILabel  *versionLabel;

@end

@implementation BUYHomeControl


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR;
    
    [self addBtn];
    //添加最下面版本号
    [self addVersion];
    [self addViewConstraints];
}


#pragma makr - 添加三个按钮去
- (void)addBtn
{
    _logoImgView = [[UIImageView alloc] init];
    _logoImgView.contentMode = UIViewContentModeCenter;
    _logoImgView.image = [UIImage imageNamed:@"登录"];
    [self.view addSubview:_logoImgView];
    [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
  NSArray *strs = @[@"登录",@"注册",@"试用"];
BUYButton *btnOne = [BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:nil borderWidth:0 titleColor:COLOR text:strs[0]];
    btnOne.tag = 1530;
    [self.view addSubview:btnOne];
    [btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(50);
         make.trailing.mas_equalTo(self.view).offset(-50);
        make.top.mas_equalTo(_logoImgView.mas_bottom).offset(75);
        make.height.mas_equalTo(40);
    }];
[btnOne addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

   BUYButton *btnTwo = [BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:nil borderWidth:0 titleColor:COLOR text:strs[1]];
    btnTwo.tag = 1531;
    [self.view addSubview:btnTwo];
    [btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(50);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.top.mas_equalTo(btnOne.mas_bottom).offset(25);
        make.height.mas_equalTo(40);
    }];
 [btnTwo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
BUYButton *btnThree = [BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:nil borderWidth:0 titleColor:COLOR text:strs[2]];
    btnThree.tag = 1532;
    [self.view addSubview:btnThree];
    [btnThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(50);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.top.mas_equalTo(btnTwo.mas_bottom).offset(25);
        make.height.mas_equalTo(40);
    }];
  [btnThree addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//应该在下面的方法中隐藏标签栏，不能在viewDidLoad里面隐藏
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


#pragma  mark - btn按钮的点击事件
- (void)btnClick:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
    //注册控制器
    BUYLoginControl *login = [[BUYLoginControl alloc] init];
    BUYRegisterControl *reg = [[BUYRegisterControl alloc] init];
ZMJTotleHomeController *trialVC = [[ZMJTotleHomeController alloc] init];
    
    switch (sender.tag) {
        case 1530:
[self.navigationController pushViewController:login animated:YES];
            break;
        case 1531:
  [self.navigationController pushViewController:reg animated:YES];
            break;
        case 1532:
[self.navigationController pushViewController:trialVC animated:YES];
            break;
        default:
            break;
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}














#pragma mark - 添加版本号
- (void)addViewConstraints {
    
    [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.versionLabel autoSetDimension:ALDimensionHeight toSize:20];
}


- (void) addVersion
{
    UILabel *label = [[UILabel alloc] initForAutoLayout];
    NSString *version = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *str = [NSString stringWithFormat:@"V %@",version];
    label.text=str;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    _versionLabel = label;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
}



















@end


















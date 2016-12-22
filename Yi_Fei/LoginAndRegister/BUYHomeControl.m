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
@property (nonatomic, strong) NSMutableArray *btnMutableArray;
@property (nonatomic, strong) UIView  *btnBgView;
@end

@implementation BUYHomeControl

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnMutableArray = [NSMutableArray array];
    self.view.backgroundColor = COLOR;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //添加控件1
    [self addLogo];
    
    //添加控件2
    _btnBgView = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:self.btnBgView];
    [self addBtn];
    
    //添加最下面版本号
    [self addVersion];
    [self addViewConstraints];
}

- (void)addViewConstraints {
    
    [self.logoImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:120];
    [self.logoImgView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:50];
    [self.logoImgView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:50];
    UIImage *logoImage = [UIImage imageNamed:@"regitstlogo"];
    [self.logoImgView autoSetDimension:ALDimensionHeight toSize:logoImage.size.height];
    
    [self.btnBgView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.btnBgView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.btnBgView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.logoImgView withOffset:50];
    [self.btnBgView autoSetDimension:ALDimensionHeight toSize:150];
    
    BUYButton *btn = [self.btnMutableArray firstObject];
    [btn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    [btn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    [self.btnMutableArray autoMatchViewsDimension:ALDimensionHeight];
    [self.btnMutableArray autoMatchViewsDimension:ALDimensionWidth];
    [self.btnMutableArray autoAlignViewsToEdge:ALEdgeLeading];
    [self.btnMutableArray autoDistributeViewsAlongAxis:ALAxisVertical alignedTo:ALAttributeLeft withFixedSpacing:10];
    
    [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.versionLabel autoSetDimension:ALDimensionHeight toSize:20];
}

#pragma mark - 添加logo
- (void)addLogo
{
    UIImageView *img = [[UIImageView alloc] initForAutoLayout];
    _logoImgView = img;
    img.contentMode = UIViewContentModeCenter;
    UIImage *logoImage = [UIImage imageNamed:@"regitstlogo"];
    img.image = logoImage;
    [self.view addSubview:img];
}

#pragma makr - 添加三个按钮去
- (void)addBtn
{
    NSArray *strs = @[@"登录",@"注册",@"试用"];

    for (int i = 0; i < 3; i++) {
        NSString *str = strs[i];
        BUYButton *btn = [BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:nil borderWidth:0 titleColor:COLOR text:str];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnMutableArray addObject:btn];
        [self.btnBgView addSubview:btn];
    }
}

#pragma mark - 添加版本号
- (void) addVersion
{
    UILabel *label = [[UILabel alloc] initForAutoLayout];
    NSString *version = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *str = [NSString stringWithFormat:@"V %@",version];
    label.text=str;
    label.font = [UIFont systemFontOfSize:11];
    label.textAlignment = NSTextAlignmentCenter;
    _versionLabel = label;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
}

//应该在下面的方法中隐藏标签栏，不能在viewDidLoad里面隐藏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


#pragma  mark - btn按钮的点击事件
- (void)btnClick:(UIButton *)sender
{
    //注册控制器
    BUYRegisterControl *reg = [[BUYRegisterControl alloc] init];
    BUYLoginControl *login = [[BUYLoginControl alloc] init];
    
    switch (sender.tag) {
        case 0:
//            NSLog(@"登录");
[self.navigationController pushViewController:login animated:YES];
            break;
        case 1:
//            NSLog(@"注册");
  [self.navigationController pushViewController:reg animated:YES];
            break;
            
        case 2:
//            NSLog(@"试用");
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







@end

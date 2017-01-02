//
//  BUYLoginHomeController.m
//  YiFei
//
//  Created by yons on 16/8/27.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "ZMJTotleHomeController.h"
#import "SDCycleScrollView.h"
#import "BUYButton.h"
#import "ZMJProviderController.h"
#import "PrividerBusinessControler.h"
#import "BusinessChanceViewController.h"
#import "MessageViewController.h"
#import "SettingTableViewController.h"

@interface ZMJTotleHomeController ()<SDCycleScrollViewDelegate>

@property (nonatomic,weak) SDCycleScrollView *cycleview;

@property (nonatomic, strong) UIButton  *Btn;

@end

@implementation ZMJTotleHomeController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //导航条的设置
    [self setNav];
    //添加图片轮播图
    [self addPictures];
    //添加按钮
    [self addBtns];
}


#pragma  mark - 设置导航条
- (void)setNav
{
    //标题
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = BACKCOLOR;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.height.mas_equalTo(64);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"EasyFair";
    titleLabel.textColor = [UIColor whiteColor];
    [backView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(backView.mas_top).offset(30);
    }];
    
    UIButton *leftBtn = [[UIButton alloc] init];
  [leftBtn setImage:[UIImage imageNamed:@"zhanghu_icon.png"] forState:UIControlStateNormal];
    [backView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(backView).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.top.equalTo(backView).offset(30);
    }];
    [leftBtn addTarget:self action:@selector(showUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:[UIImage imageNamed:@"xiaoxi_icon.png"] forState:UIControlStateNormal];
    [backView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(backView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.top.mas_equalTo(backView.mas_top).offset(30);
    }];
[rightBtn addTarget:self action:@selector(showMessage) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showUserInfo {
    SettingTableViewController *settingVc = [[SettingTableViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];

}

- (void)showMessage {
    
    MessageViewController *messageVC = [[MessageViewController alloc] init];
 [self.navigationController pushViewController:messageVC animated:YES];

}

#pragma mark - 添加图片轮播图
-(void)addPictures
{    
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg",
                            ];
    CGFloat w = self.view.bounds.size.width;
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, w, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleview = cycleScrollView;
    [self.view addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;
}

#pragma mark - 添加按钮
- (void)addBtns
{
    NSArray *titleArray = @[NSLocalizedString(@"mySupply", nil),NSLocalizedString(@"myXustomer", nil),NSLocalizedString(@"Business", nil)];
    for (NSInteger i = 0; i < 3; i++) {
    _Btn  = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_cycleview.frame) + 15 + i * 60, WIDTH - 30, 50)];
        _Btn.backgroundColor = [UIColor whiteColor];
        [_Btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [_Btn setTitleColor:COLOR forState:UIControlStateNormal];
        _Btn.layer.cornerRadius = 5.0;
        _Btn.layer.masksToBounds =YES;
        _Btn.tag = 2200 + i;
[_Btn addTarget:self action:@selector(NextView:) forControlEvents:UIControlEventTouchUpInside];
        _Btn.layer.borderColor = [UIColor lightGrayColor] .CGColor;
        _Btn.layer.borderWidth = 1;
        [self.view addSubview:_Btn];
    }
}

#pragma  mark - btn按钮的点击事件
- (void)NextView:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 2200: {
            ZMJProviderController *buin = [[ZMJProviderController alloc] init];
            [self.navigationController pushViewController:buin animated:YES];
            break;
        }
        case 2201: {
            PrividerBusinessControler *prividerVc = [[PrividerBusinessControler alloc] init];
            [self.navigationController pushViewController:prividerVc animated:YES];
            break;
        }
        case 2202: {
            BusinessChanceViewController *bcVc = [[BusinessChanceViewController alloc] init];
            [self.navigationController pushViewController:bcVc animated:YES];
            break;
        }
        default:
            break;
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}






@end







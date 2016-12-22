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
    CGFloat w = 200;
    CGFloat h = 40;
    CGFloat x = (WIDTH-w)*0.5;
    CGFloat margin1 = 20;
    CGFloat margin2 = 20;
    NSArray *strs = @[@"我是供应商",@"我是采购商",@"商机"];
    
    for (int i = 0; i < 3; i++) {
        NSString *str = strs[i];
        UIButton *btn = [BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:BACKCOLOR text:str];
        btn.tag = i;
        if (i == 0) {
    btn = [BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:[UIColor lightGrayColor] borderWidth:1.0 titleColor:BACKCOLOR text:str];
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //frame
        CGFloat y = CGRectGetMaxY(_cycleview.frame) + margin1 + i * (margin2+h);
        btn.frame = CGRectMake(x, y, w, h);
        [self.view addSubview:btn];
    }
}

#pragma  mark - btn按钮的点击事件
- (void)btnClick:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0: {
            ZMJProviderController *buin = [[ZMJProviderController alloc] init];
            [self.navigationController pushViewController:buin animated:YES];
//            NSLog(@"我是供应商");
            break;
        }
        case 1: {
            PrividerBusinessControler *prividerVc = [[PrividerBusinessControler alloc] init];
            [self.navigationController pushViewController:prividerVc animated:YES];
//            NSLog(@"我是采购商");
            break;
        }
        case 2: {
//            NSLog(@"商机");
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







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

@interface ZMJTotleHomeController ()<SDCycleScrollViewDelegate>

@property (nonatomic,weak) SDCycleScrollView *cycleview;

@end

@implementation ZMJTotleHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //导航条的设置
    [self setNavToolBar];
    
    //添加图片轮播图
    [self addPictures];
    
    //添加按钮
    [self addBtns];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma  mark - 设置导航条
- (void)setNavToolBar
{
    //标题
    self.title = @"EasyFair";
#warning 左右两侧的图片 --  需要添加
    //左右两侧的图标
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zhanghu_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showUserInfo)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xiaoxi_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showMessage)];
}

- (void)showUserInfo {
    
    
    

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
        UIButton *btn = [BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:COLOR text:str];
        btn.tag = i;
        if (i == 0) {
            btn = [BUYButton creatBtnWithBgColor:COLOR borderColor:nil borderWidth:0 titleColor:[UIColor whiteColor] text:str];
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

@end

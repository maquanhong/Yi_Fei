//
//  BusinessChanceViewController.m
//  YiFei
//
//  Created by maquanhong on 10/20/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import "BusinessChanceViewController.h"
#import "SDCycleScrollView.h"
#import "ExhibitionViewController.h"
#import "DemandController.h"
#import "ProductiPulishController.h"



@interface BusinessChanceViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIButton  *Btn;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;



@end

@implementation BusinessChanceViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone; //不让视图，显示到navigationBar上面
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createNavigationView];
    [self addPictures];
    [self addViewConstraints];

}

#pragma mark - 设置导航条
-(void)createNavigationView
{
    self.navigationItem.title = NSLocalizedString(@"Business", nil);
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 设置轮播图
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
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.view addSubview:self.cycleScrollView];
    self.cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;
}


#pragma mark 设置按钮
- (void)addViewConstraints {
    
    NSArray *titleArray = @[NSLocalizedString(@"productPulish", nil),NSLocalizedString(@"demandPulish", nil),NSLocalizedString(@"exhibitionInfo", nil)];
    for (NSInteger i = 0; i < 3; i++) {
        _Btn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_cycleScrollView.frame) + 15 + i * 60, WIDTH - 30, 50)];
        _Btn.backgroundColor = [UIColor whiteColor];
        [_Btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [_Btn setTitleColor:COLOR forState:UIControlStateNormal];
        _Btn.layer.cornerRadius = 5.0;
        _Btn.layer.masksToBounds =YES;
        _Btn.tag = 2100 + i;
    [_Btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        //边框
        _Btn.layer.borderColor = [UIColor lightGrayColor] .CGColor;
        _Btn.layer.borderWidth = 1;
        [self.view addSubview:_Btn];
    }
 
}

-(void)clickBtn:(UIButton*)sender
{
    
    switch (sender.tag) {
        case 2100:
        {
    ProductiPulishController  *productVC = [[ProductiPulishController alloc] init];
    [self.navigationController pushViewController:productVC animated:YES];
        }
            break;
        case 2101:
        {
   DemandController  *demandVC = [[DemandController alloc] init];
   [self.navigationController pushViewController:demandVC animated:YES];
        }
            break;
        case 2102:
        {
    ExhibitionViewController *conVc = [[ExhibitionViewController alloc] init];
    [self.navigationController pushViewController:conVc animated:YES];
        }
            break;
        default:
            break;
    }

    
    
    
    

}









@end

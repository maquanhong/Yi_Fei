//
//  PrividerBusinessControler.m
//  YiFei
//
//  Created by yons on 16/8/27.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "PrividerBusinessControler.h"
#import "UIView+Layout.h"
#import "BUYButton.h"
#import "MyProductionController.h"
#import "BuyerProductController.h"
#import "BuyerViewController.h"
#import "offerViewController.h"

@interface PrividerBusinessControler ()

@property (nonatomic,weak) UIView *symView;

@property (nonatomic,weak) UIImageView *navBarHairlineImageView;

@end

@implementation PrividerBusinessControler

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.s
    self.view.backgroundColor = [UIColor whiteColor];
    _navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //设置导航条
    [self setNavTool];
    //添加标志图片
    [self addSymbol];
    
    //添加按钮
    [self addBtns];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _navBarHairlineImageView.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _navBarHairlineImageView.hidden = NO;
}

#pragma mark - 设置导航条
- (void)setNavTool
{
    self.title = @"我是采购商";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - 添加标志图片
- (void)addSymbol
{
    UIView *symbol = [[UIView alloc] init];
    _symView = symbol;
    symbol.backgroundColor = [UIColor colorWithRed:0/255.0 green:138.0/255.0 blue:244/255.0 alpha:1.0];
    //添加标志图
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"logo.png"];
    img.layer.cornerRadius = 5;
    img.layer.masksToBounds = YES;
    CGFloat x = 40;
    CGFloat y = 20;
    CGFloat w = 80;
    CGFloat h = 68;
    img.frame = CGRectMake(x, y, w, h);
    [symbol addSubview:img];
    
    //添加公司名称
    UILabel *label = [[UILabel alloc] init];
    label.text = @"百倍云科技有限公司";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    CGFloat Lx = CGRectGetMaxX(img.frame)+26;
    CGFloat Ly = CGRectGetMaxY(img.frame) - img.height*0.5 - label.height*0.5;
    label.x = Lx;
    label.y = Ly;
    [symbol addSubview:label];
    
    symbol.frame = CGRectMake(0, 64, WIDTH, CGRectGetMaxY(img.frame)+20);
    
    [self.view addSubview:symbol];
}

#pragma mark - 添加下面三个按钮

- (void)addBtns
{
    CGFloat w = 240;
    CGFloat h = 40;
    CGFloat x = (WIDTH-w)*0.5;
    CGFloat margin1 = 20;
    CGFloat margin2 = 20;
    NSArray *strs = @[@"我的商品",@"我的供应商",@"询价"];
    
    for (int i = 0; i < 3; i++) {
        NSString *str = strs[i];
        UIButton *btn = [BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:COLOR text:str];
        btn.tag = i;
        if (i == 0) {
            btn = [BUYButton creatBtnWithBgColor:COLOR borderColor:nil borderWidth:0 titleColor:[UIColor whiteColor] text:str];
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        CGFloat y = CGRectGetMaxY(_symView.frame) + margin1 + i * (margin2+h);
        btn.frame = CGRectMake(x, y, w, h);
        [self.view addSubview:btn];
    }
}


#pragma mark - btn按钮的点击事件
- (void)btnClick:(UIButton *)sender
{
    MyProductionController *vc = [[MyProductionController alloc] init];
    BuyerViewController *BuyerVc = [[BuyerViewController alloc] initWithTypeId:BussinessBuyer];
    offerViewController *offerVC=[[offerViewController alloc] initWithIdType:BussinessBuyer];
    
    switch (sender.tag) {
        case 0:
            [self.navigationController pushViewController:vc animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:BuyerVc animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:offerVC animated:YES];
            
            break;
        default:
            break;
    }
}

















@end
















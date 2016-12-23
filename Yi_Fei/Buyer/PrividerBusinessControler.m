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
#import "BuyerProductController.h"
#import "BuyerViewController.h"
#import "AskPriceController.h"
#import "UserModel.h"
#import "UserList.h"
#import "UserDefaultManager.h"


@interface PrividerBusinessControler ()
{
    UserModel *oneModel;
}

@property (nonatomic,strong) UIView *symView;



@end

@implementation PrividerBusinessControler

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR;
    //添加标志图片
    [self addSymbol];
    //添加按钮
    [self addBtns];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


#pragma mark - 添加标志图片
- (void)addSymbol
{
    
    UIView *symbol = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    _symView = symbol;
    symbol.backgroundColor =  BACKCOLOR;
    
    //添加标志图
    UIImageView *img = [[UIImageView alloc] init];
    img.layer.cornerRadius = 5;
    img.layer.masksToBounds = YES;
    [symbol addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(symbol).offset(15);
        make.bottom.mas_equalTo(symbol.mas_bottom).offset(-50);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    
    //获取单例对象
    UserList *manager = [UserList defaultManager];
    //可变数组初始化
    oneModel = [[ UserModel alloc] init];
    NSString *str = [UserDefaultManager getDataByKey:@"user"];
    oneModel = [manager getDataWith:str];
    
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    if (oneModel.picture.length > 0) {
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",oneModel.picture]];
        img.image = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text  = @"我是供应商";
    titleLabel.textColor = [UIColor whiteColor];
    [symbol addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(symbol);
        make.top.mas_equalTo(symbol.mas_top).offset(30);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    [symbol addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(symbol).offset(10);
        make.top.mas_equalTo(symbol.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [btn addTarget:self action:@selector(returnNextView) forControlEvents:UIControlEventTouchUpInside];
    
    //添加公司名称
    UILabel *label = [[UILabel alloc] init];
    label.text = oneModel.name;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    [symbol addSubview:label];
    [self.view addSubview:symbol];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).offset(15);
        make.centerY.equalTo(img);
        make.height.mas_equalTo(20);
    }];
}


-(void)returnNextView{
    [self.navigationController popViewControllerAnimated:YES];
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
            btn = [BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:[UIColor lightGrayColor] borderWidth:1.0 titleColor:COLOR text:str];
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
    BuyerProductController *vc = [[BuyerProductController alloc] init];
    BuyerViewController *BuyerVc = [[BuyerViewController alloc] init];
    AskPriceController *offerVC=[[AskPriceController alloc] init];
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
















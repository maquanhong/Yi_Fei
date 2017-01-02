
//
//  DemandController.m
//  Yi_Fei
//
//  Created by yons on 16/12/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "DemandController.h"
#import "DemandOneController.h"
#import "DemandTwoController.h"

@interface DemandController (){
    UIScrollView *_scrollerView;
    UIButton *_leftBtn;
    UIButton *_RightBtn;
}

@property (nonatomic,strong)UIView *moveView;


@end

@implementation DemandController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR;
    [self setNav];
    [self createScrollerView];
    [self createButton];

}

- (void)setNav {
    self.navigationItem.title = NSLocalizedString(@"demandPulish", nil);
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --创建scrollerView视图
-(void)createScrollerView{
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,40, WIDTH, HEIGHT * 3)];
    _scrollerView.contentSize  = CGSizeMake(WIDTH, HEIGHT * 3);
    _scrollerView.scrollEnabled = NO;
    [self.view addSubview:_scrollerView];
    DemandOneController *oneController = [[DemandOneController alloc] init];
    DemandTwoController *twoController = [[DemandTwoController alloc] init];
    NSArray *controllerArray = @[oneController,twoController];
    int i = 0;
    for (UIViewController *VC in controllerArray) {
        VC.view.frame = CGRectMake(i * WIDTH , 0, WIDTH, HEIGHT);
        [self addChildViewController:VC];
        //不实现滚动效果直接 ，添加子视图
        [_scrollerView addSubview:VC.view];
        i++;
    }
}

#pragma mark -- 设置上部视图
-(void)createButton{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64 , WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 0, WIDTH / 2, 38);
    [_leftBtn setTitle:NSLocalizedString(@"mine", nil) forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:BACKCOLOR forState:UIControlStateSelected];
    
    [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_leftBtn];
    
    _RightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _RightBtn.frame = CGRectMake(WIDTH / 2, 0, WIDTH / 2, 38);
    [_RightBtn setTitle:NSLocalizedString(@"allSupply", nil) forState:UIControlStateNormal];
    [_RightBtn setTitleColor:BACKCOLOR forState:UIControlStateNormal];
    [_RightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_RightBtn setTitleColor:BACKCOLOR forState:UIControlStateSelected];
    [view addSubview:_RightBtn];
    self.moveView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH / 4 - 50, 38, 100, 2)];
    self.moveView.backgroundColor = BACKCOLOR;
    [view addSubview:self.moveView];
}


-(void)leftBtnClick{
    _RightBtn.selected = NO;
    _leftBtn.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
    self.moveView.frame = CGRectMake(WIDTH / 4 - 50, 38, 100, 2);
    }];
    CGPoint offset = _scrollerView.contentOffset;
    offset.x = 0;
    _scrollerView.contentOffset  = offset;
    
}

-(void)rightBtnClick{
    _leftBtn.selected = NO;
    _RightBtn.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.moveView.frame = CGRectMake(3 * WIDTH/4-50, 38, 100, 2);
    }];
    CGPoint offset = _scrollerView.contentOffset;
    offset.x = WIDTH;
    _scrollerView.contentOffset  = offset;
}

































@end





















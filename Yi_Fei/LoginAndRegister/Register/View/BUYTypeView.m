//
//  BUYTypeView.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYTypeView.h"
#import "UIView+Layout.h"
#import "BUYTitleButton.h"

@interface BUYTypeView ()

@property (nonatomic,weak) UILabel *label;

@property (nonatomic,strong) NSMutableArray *btns;

@property (nonatomic,strong) NSMutableArray *Slines;

@property (nonatomic,weak) UIView *HLine;

@end

@implementation BUYTypeView

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)Slines
{
    if (!_Slines) {
        _Slines = [NSMutableArray array];
    }
    return _Slines;
}

+ (instancetype) creatTypeView
{
    BUYTypeView *view = [[self alloc] init];
    
    //设置边框为圆角
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    
    //添加子控件
    [view addSubViews];
    return view;
}

#pragma mark - 添加子控件
- (void) addSubViews
{
    //@“行业类型”
    [self addLabel];
    
    //四个button
    [self addFourBtns];
    
    //添加横竖线
    [self addLines];
}

- (void)addLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0];
    label.text = @"行业类型";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    _label = label;
    [self addSubview:label];
}

- (void)addFourBtns
{
    NSArray *arrs = @[@"照明设备",@"照明应用",@"装饰照明",@"灯罩灯柱"];
    for (int i=0; i<4; i++) {
        NSString *str = arrs[i];
        BUYTitleButton *btn = [BUYTitleButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"xiala.png"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:COLOR forState:UIControlStateNormal];
        [self.btns addObject:btn];
        [self addSubview:btn];
    }
}

- (void)addLines

{
    //两条竖线
    for (int i=0; i<2; i++) {
        UIView *viewS = [[UIView alloc] init];
        viewS.backgroundColor = [UIColor lightGrayColor];
        [self.Slines addObject:viewS];
        [self addSubview:viewS];
    }
    
    //一条横线
    UIView *viewH = [[UIView alloc] init];
    viewH.backgroundColor = [UIColor lightGrayColor];
    _HLine = viewH;
    [self addSubview:viewH];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //行业类型
    [self.label sizeToFit];
    self.label.x = 8;
    self.label.y = (self.bounds.size.height - self.label.height)*0.5;
    
    //btn
    CGFloat x1 = CGRectGetMaxX(self.label.frame)+14;
    CGFloat W = (self.bounds.size.width-self.label.width)*0.5-8;
    CGFloat H = (self.bounds.size.height-self.label.height)*0.5;
    CGFloat y1 = (self.height-H*2)*0.5;
    for (int i=0; i<4; i++) {
        UIButton *btn = self.btns[i];
        CGFloat colum = i % 2;
        CGFloat row = i / 2;
        CGFloat x = x1+colum*W;
        CGFloat y = y1+row*H;
        btn.frame = CGRectMake(x, y, W, H);
        NSLog(@"%@",NSStringFromCGRect(btn.frame));
    }
    
    //线的位置
    CGFloat LW = 1;
    CGFloat LH = self.height;
    CGFloat LX = x1;
    for (int i=0; i<2; i++) {
        UIView *line = self.Slines[i];

        if (i==1) {
            LX = x1+W;
        }
        line.frame = CGRectMake(LX, 0, LW, LH);
    }
    
    CGFloat SH = 1;
    UIButton *btn = self.btns[0];
    CGFloat SY = CGRectGetMaxY(btn.frame);
    self.HLine.frame = CGRectMake(x1, SY, self.width-self.label.width, SH);
}

@end

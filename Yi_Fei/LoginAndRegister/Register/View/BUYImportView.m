//
//  BUYImportView.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYImportView.h"
#import "UIView+Layout.h"

@interface BUYImportView ()

@property (nonatomic,strong) UIButton *confirmBtn;



@property (nonatomic,weak) UIView *shuxian;

@end

@implementation BUYImportView

//懒加载
- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_confirmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:COLOR forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor colorWithRed:57/255.0 green:154/255.0 blue:253/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [_confirmBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _confirmBtn.hidden = YES;
        [self addSubview:self.confirmBtn];
    }
    return _confirmBtn;
}


+ (instancetype)creatImportViewWithStr:(NSString *)placehold flag:(BOOL) isflag leftImg:(NSString *)leftimg
{
    BUYImportView *view = [[self alloc] init];
    
    //添加子控件
    [view addSubViewsWithplaceHold:placehold LeftImg:leftimg];
    //如果为正，需要添加确认框
    if (isflag) {
        [view addConfirmView];
    }
    return view;
}

#pragma mark - 重写边框颜色的setter方法
- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    
    //设置边框为圆角
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}


#pragma mark - 添加子控件
- (void) addSubViewsWithplaceHold:(NSString *)str LeftImg:(NSString *) leftimg
{
    UITextField *field = [[UITextField alloc] init];
    field.placeholder = str;
    field.borderStyle = UITextBorderStyleNone;
    [field setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    if (leftimg.length != 0) {
        //有左侧图片，给左侧添加一个图片
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftimg]];
        img.width += 12;
        img.contentMode = UIViewContentModeCenter;
        field.leftView = img;
        field.leftViewMode = UITextFieldViewModeAlways;
    }
    _field = field;
    [self addSubview:field];
}

- (void) addConfirmView
{
    self.confirmBtn.hidden = NO;
    //增加一条竖线
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    _shuxian = view;
    [self addSubview:view];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //输入框的位置
    CGFloat x = 8;
    CGFloat y = 5;
    CGFloat W = self.bounds.size.width - x*2;
    CGFloat H = self.bounds.size.height - y*2;
    _field.frame = CGRectMake(x, y, W, H);
    
    //确认框的位置
    if (!self.confirmBtn.hidden) {
        //显示，设置位置
        CGFloat BW = 100;
        CGFloat BH = self.bounds.size.height;
        CGFloat BX = self.bounds.size.width - BW;
        self.confirmBtn.frame = CGRectMake(BX, 0, BW, BH);
        _field.frame = CGRectMake(x, y, BX, H);
        
        //竖线的位置
        _shuxian.frame = CGRectMake(BX, 0, 1, BH);
    }
    
}

#pragma mark - 点击获取验证码
- (void)btnClick
{
    NSLog(@"获取验证码");
    //代理，让注册控制器获取邮箱号并且判断是否为邮箱
    if ([self.delegate respondsToSelector:@selector(judgeMail)]) {
        [self.delegate judgeMail];
    }
}

@end

//
//  BUYRegisterControl.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYRegisterControl.h"
#import "BUYImportView.h"
#import "BUYTypeView.h"
#import "UIView+Layout.h"
#import "BUYTextView.h"
#import "BUYAgreementController.h"
#import "BUYLoginControl.h"
#import "BUYButton.h"

@interface BUYRegisterControl () <BUYTextViewDelegate,BUYImportViewDelegate>

@property (nonatomic,strong)NSMutableArray *arrs;

@property (nonatomic,weak)BUYTypeView *typeView;

@property (nonatomic,weak) BUYTextView *textView;
@end

@implementation BUYRegisterControl

- (NSMutableArray *)arrs
{
    if (!_arrs) {
        _arrs = [NSMutableArray array];
    }
    return _arrs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";
    //添加三个按钮
    [self addBtns];
    //添加 行业类型 按钮
    [self addTypeBtn];
    //添加 协议说明
    [self addTextView];
    //添加  注册按钮
    [self addResignBtn];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 添加前面三个按钮
- (void) addBtns
{
    CGFloat X = 25;
    CGFloat margin1 = 20;
    CGFloat margin2 = 14;
    CGFloat W = WIDTH - 2*X;
    CGFloat H = 40;
    CGFloat y = 0;
    NSArray *array = @[@"请输入手机号或邮箱",@"请输入验证码",@"请输入密码"];
    for (int i=0; i<3; i++) {
        NSString *str = array[i];
        BUYImportView *view = [BUYImportView creatImportViewWithStr:str flag:NO leftImg:nil];
        if (i == 1) {
            view = [BUYImportView creatImportViewWithStr:str flag:YES leftImg:nil];
            view.delegate = self;
        }
        view.borderColor = [UIColor lightGrayColor];
        //设置位置
        y = 64 + margin1 + i * (H + margin2);
        view.frame = CGRectMake(X, y, W, H);
        [self.arrs addObject:view];
        [self.view addSubview:view];
    }
}

#pragma mark - 添加行业类型按钮
- (void)addTypeBtn
{
    BUYTypeView *view = [BUYTypeView creatTypeView];
    BUYImportView *last = [self.arrs lastObject];
    CGFloat x = last.x;
    CGFloat y = CGRectGetMaxY(last.frame)+14;
    CGFloat W = last.width;
    CGFloat H = 100;
    view.frame = CGRectMake(x, y, W, H);
    _typeView = view;
    [self.view addSubview:view];
    
}

#pragma mark - 添加协议说明
- (void)addTextView
{
    BUYTextView *view = [BUYTextView creatTextView];
    view.delegate = self;
    CGFloat h = 20;
    CGFloat w = self.view.width;
    view.frame = CGRectMake(0, CGRectGetMaxY(self.typeView.frame)+14, w, h);
    _textView = view;
    [self.view addSubview:view];
}

#pragma mark - 添加注册按钮
- (void)addResignBtn
{
    BUYButton *btn = [BUYButton creatBtnWithBgColor:COLOR borderColor:nil borderWidth:0 titleColor:[UIColor whiteColor] text:@"注册"];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    CGFloat x =40;
    CGFloat H = 40;
    
    btn.frame = CGRectMake(x, CGRectGetMaxY(self.textView.frame)+20, self.view.width-2*x, H);
    [self.view addSubview:btn];
}

- (void)btnClick{
    NSLog(@"点击注册按钮");
    //跳转到登录页面
    //1. 验证获取到的验证码是否正确
    //2. 是否点击了接受协议
    // 满足以上条件以后，才跳转到登录界面
    BUYLoginControl *login = [[BUYLoginControl alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

#pragma mark - BUYTextViewDelegate的代理方法
- (void) pushViewcontroller:(BUYTextView *)BuyTextView
{
    BUYAgreementController *vc = [[BUYAgreementController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - BUYImportViewDelegate的代理方法
- (void)judgeMail
{
    //获取邮箱
    BUYImportView *view = [self.arrs firstObject];
    NSString *str = view.field.text;
    NSLog(@"%@",str);
    //判断
    if ([self validateEmail:str]) {
        NSLog(@"yes");
        //如果是qq邮箱，则不能带有数字
        if ([str containsString:@"qq.com"]) {
            NSLog(@"qq邮箱");
            //qq邮箱不能包含字母
            NSRange range = [str rangeOfString:@"@qq.com"];
            NSString *prefix = [str substringToIndex:range.location];
            //不能包含字母
            if (![self isPureNumandCharacters:prefix]) {
                [self prompt];
                return;
            }
        }
        NSLog(@"发送请求");
    }else{
        NSLog(@"no");
        [self prompt];
    }
}

//判断是否为字符串
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//判断是否是全数字
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

- (void) prompt
{
    //弹出输入框，提示输入正确的格式
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入正确的邮箱号" preferredStyle:UIAlertControllerStyleAlert];
    
    [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //第一个输入框成为焦点
        BUYImportView *view = [self.arrs firstObject];
        [view.field becomeFirstResponder];
    }]];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end

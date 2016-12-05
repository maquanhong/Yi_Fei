//
//  BUYTextView.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYTextView.h"
#import "UIView+Layout.h"

@interface BUYTextView () <UITextViewDelegate>

@property (nonatomic,weak) UIButton *btn;

@property (nonatomic,weak) UITextView *label;

@property (nonatomic,assign,getter=isAccept) BOOL Accept;

@end

@implementation BUYTextView

+ (instancetype) creatTextView
{
    BUYTextView *view = [[self alloc] init];
    
    //添加子控件
    [view addSubViews];
    return view;
}


#pragma mark - 添加子控件
- (void)addSubViews
{
    //btn按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"registerUnCheck@2x.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _btn = btn;
    [self addSubview:btn];
    
    //文字
    UITextView *textview = [[UITextView alloc] init];
    textview.delegate = self;
    [textview setSelectable:YES];
//    textview.dataDetectorTypes = UIDataDetectorTypeLink;
    [textview setEditable:NO];
    NSString *str = @"我已经阅读并接受《EasyFair服务协议》";
    NSRange range = [str rangeOfString:@"《EasyFair服务协议》"];
//    NSMakeRange(8, 14)
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString: str];
    [attributedStr addAttribute: NSForegroundColorAttributeName value: [UIColor blueColor] range: range];
    [attributedStr addAttribute:NSLinkAttributeName
                   value:@""
                   range:range];
    textview.font = [UIFont systemFontOfSize:13];
    textview.attributedText = attributedStr;
    _label = textview;
    [self addSubview:textview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //btn
    CGFloat WH = 20;
    self.btn.frame = CGRectMake(0, 0, WH, WH);
    
    [self.label sizeToFit];
    self.label.x = CGRectGetMaxX(self.btn.frame)+5;
    self.label.y = -5;
    
    CGFloat btnX = (self.width-CGRectGetMaxX(self.label.frame))*0.5;
    //为了设置控件在中间显示 有没有更好的办法？
    self.btn.frame = CGRectMake(btnX, 0, WH, WH);
    self.label.x = CGRectGetMaxX(self.btn.frame)+5;
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)btn
{
    self.Accept = !self.Accept;
    if (self.isAccept) {
        [btn setImage:[UIImage imageNamed:@"registerCheck@2x.png"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"registerUnCheck@2x.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - UITextView的代理方法
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"sssss");
    //通过代理，实现控制器的跳转
    if ([self.delegate respondsToSelector:@selector(pushViewcontroller:)]) {
        [self.delegate pushViewcontroller:self];
    }
    return YES;
}





@end

//
//  BUYButton.m
//  YiFei
//
//  Created by yons on 16/8/27.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYButton.h"

@implementation BUYButton

+ (instancetype) creatBtnWithBgColor:(UIColor *)Bgcolor borderColor:(UIColor *)Bdcolor borderWidth:(CGFloat) width titleColor:(UIColor *)Ttcolor text:(NSString *)text
{
    BUYButton *btn = [self buttonWithType:UIButtonTypeCustom];
    
    //设置属性
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:Ttcolor forState:UIControlStateNormal];

    //圆角
    btn.layer.cornerRadius = 5.0;
    btn.layer.masksToBounds =YES;
    
    //边框
    btn.layer.borderColor = Bdcolor.CGColor;
    btn.layer.borderWidth = width;
    
    //背景颜色
    [btn setBackgroundColor:Bgcolor];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return btn;
}


@end

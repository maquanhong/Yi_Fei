//
//  BUYButton.h
//  YiFei
//
//  Created by yons on 16/8/27.
//  Copyright © 2016年 yous. All rights reserved.
//
//登录，注册的按钮，自定义得

#import <UIKit/UIKit.h>

@interface BUYButton : UIButton


+ (instancetype) creatBtnWithBgColor:(UIColor *)Bgcolor borderColor:(UIColor *)Bdcolor borderWidth:(CGFloat) width titleColor:(UIColor *)Ttcolor text:(NSString *)text;

@end

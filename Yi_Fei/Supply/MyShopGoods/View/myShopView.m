//
//  myShopView.m
//  YiFei
//
//  Created by yangyan on 16/8/30.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "myShopView.h"

@implementation myShopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype) creatLableWithBgColor:(UIColor *)Lgcolor borderColor:(UIColor *)Lcolor borderWidth:(CGFloat) width titleColor:(UIColor *)Ttcolor text:(NSString *)text
{
    myShopView *lable= [[self alloc] init];
    
    //设置属性
    lable.text=text;
    lable.textColor=[UIColor lightGrayColor];
    
    //圆角
    lable.layer.cornerRadius = 5.0;
    lable.layer.masksToBounds =YES;
    
    //边框
    lable.layer.borderColor = Lgcolor.CGColor;
    lable.layer.borderWidth = width;
    
    //背景颜色
    lable.backgroundColor=[UIColor whiteColor];
//    lable.textAlignment=NSTextAlignmentCenter;
    return lable;
}



@end
